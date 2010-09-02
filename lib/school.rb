class School
  class << self
    def student_names
      [
        'Adam Baum',
        'Adam Zapel',
        'Al Bino',
        'Al Dente',
        'Al Fresco',
        'Al K. Seltzer',
        'Alf A. Romeo',
        'Ali Katt',
        'Amanda Lay',
        'Amanda Lynn',
        'Amber Green',
        'Andy Friese',
        'Anita Bath',
        'Anita Lay',
        'Anna Graham',
        'Anna Prentice',
        'Anna Recksiek',
        'Anna Sasin',
        'Barry Cade',
        'Beau Archer',
        'Ben Dover',
        'Bess Eaton',
        'Biff Wellington',
        'Bill Board',
        'Bill Ding',
        'Bill Foldes',
        'Bill Loney',
        'Carrie Oakey',
        'Casey Macy',
        'Harry Pitts',
        'Dick Trickle'
      ]
    end
  end
  attr_accessor :teacher, :courses, :students

  def initialize
    self.teacher = Factory.teacher.create email: 'teacher@wa.edu'
    self.courses = create_courses
    self.students = create_students

    courses.each { |course| CourseGenerator.new(course, students).generate }
  end

  def create_courses
    [
      Factory.course.create(teacher: teacher, start_date: 3.months.ago.to_date, end_date: 1.month.ago.to_date),
      Factory.course.create(teacher: teacher, start_date: 1.month.ago.to_date, end_date: 1.month.from_now.to_date),
      Factory.course.create(teacher: teacher, start_date: 1.week.from_now.to_date, end_date: 3.months.from_now.to_date)
    ]
  end

  def create_students
    self.class.student_names.map do |full_name|
      Factory.student.create full_name: full_name
    end
  end

  class CourseGenerator < Struct.new(:course, :students)
    attr_accessor :studiers

    def generate
      self.studiers = create_studiers
      create_assignments
    end

    def create_studiers
      students.map do |student|
        Factory.studier.create student: student, course: course
      end
    end

    def create_assignments
      return unless course.current?

      create_assignment('Memorize Pi', 1.week.ago) do |assignment|
        create_submissions(assignment, handed_in_at: 5.days.ago, :graded_at => 3.days.ago)
      end

      create_assignment('Analyze a Poem', 2.days.ago) do |assignment|
        create_submissions(assignment, handed_in_at: 1.day.ago)
      end

      create_assignment('Write a poem', 1.week.ago) do |assignment|
        create_submissions(assignment, hand_in: false)
      end

      create_assignment('Critique Great Gatsby', 3.days.from_now)
      create_assignment('Final Essay', 2.weeks.from_now)
    end
    
    def create_assignment(name, due_at)
      Factory.assignment.create(name: name, due_at: due_at, course: course).tap do |assignment|
        yield(assignment) if block_given?
      end
    end

    def create_submissions(assignment, attributes = {})
      attributes.reverse_merge! assignment: assignment
      studiers.each do |studier|
        Factory.composition.create(attributes.reverse_merge(studier: studier))
      end
    end
  end

    #   if composition_attributes
    #     composition_attributes.reverse_merge! assignment: assignment
    #     studiers.each do |studier|
    #       Factory.composition.create(composition_attributes.reverse_merge(studier: studier))
    #     end
    #   end
    # 
    #   assignment
    # end

end