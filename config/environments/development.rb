config.cache_classes = false
config.whiny_nils = true

config.action_controller.consider_all_requests_local = true
config.action_view.debug_rjs                         = true
config.action_controller.perform_caching             = false

config.action_mailer.raise_delivery_errors = false
config.action_mailer.default_url_options = {
  :host => 'localhost:3000',
  :only_path => false
}

config.gem 'factory_girl', :version => '1.2.3'
