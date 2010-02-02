task :cron => :environment do
  Concerns::Tokenized.models.each(&:prune)
end