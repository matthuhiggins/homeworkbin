task :cron => :environment do
  ActiveRecord::Tokenized.models.each(&:prune)
end