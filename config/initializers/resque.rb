rails_root = ENV['RAILS_ROOT'] || File.dirname(__FILE__) + '/../..'
rails_env = ENV['RAILS_ENV'] || 'development'

resque_config = YAML.load_file("#{Rails.root}/config/resque.yml")
Resque.redis = resque_config[rails_env]
Resque::Mailer.default_queue_name = 'scholarships'
