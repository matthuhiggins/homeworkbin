class Factory
  class_attribute :factories
  self.factories = {}

  class << self
    def define(name, options = {})
      factory = new(name, options)
      yield factory
      factories[name] = factory

      instance_eval <<-FACTORY, __FILE__, __LINE__
        def #{name}(attributes = {})
          factories[:#{name}]
        end
      FACTORY
    end

    def [](name)
      factories[name.to_sym] || (raise ArgumentError.new("No such factory: #{name.to_s}"))
    end
  end

  class Sequence
    class_attribute :sequences
    self.sequences = {}

    class << self
      def sequence(name, &block)
        self.sequences[name] = new(&block)
      end
    end
    
    def initialize(&block)
      @block = block
      @value = 0
    end

    # Returns the next value for this sequence
    def next
      @value += 1
      @block.present? ? @block.call(@value) : @value
    end
  end

  attr_reader :factory_name
  attr_reader :defined_attributes
  attr_reader :options
  attr_reader :after_builds

  def initialize(name, options)
    @factory_name = name.to_s
    @defined_attributes = {}
    @options = options
    @after_builds = []
  end

  # Factory.define :people do |f|
  #   f.sequence(:email) { |n| "person#{n}@example.com" }
  # end
  def sequence(name, &block)
    s = Sequence.new(&block)
    send(name) { s.next }
  end

  def association(name)
    send(name) { Factory[name].create }
  end

  def create(overrides = {})
    record = build(overrides)
    record.save!
    record
  end

  def build(overrides = {})
    record = model.new(attributes(overrides))
    run_after_builds(record)
    record
  end

  def attributes(overrides = {})
    overrides.symbolize_keys!

    result = options[:parent].present? ? Factory[options[:parent]].attributes : {}

    defined_attributes.each do |key, value|
      value = overrides[key] if overrides[key]
      result[key] = value.is_a?(Proc) ? value.call : value
    end

    result
  end

  def after_build(&block)
    after_builds << block
  end

  private
    def model
      options[:class] || factory_name.camelize.constantize
    end
  
    def method_missing(name, *args, &block)
      if block_given?
        defined_attributes[name] = block
      else
        defined_attributes[name] = args.first
      end
    end

    def run_after_builds(record)
      after_builds.each do |block|
        block.call record
      end
    end
end

Dir[Rails.root.join('factories', '*.rb')].each do |file|
  require file
end