require File.expand_path(File.dirname(__FILE__) + "/environment")

rails_env = ENV["RAILS_ENV"] || :development
set :environment, rails_env

set :job_template, "/bin/zsh -l -c ':job'"

# cronのログの吐き出し場所
set :output, "#{Rails.root}/log/cron.log"

job_type :rake, "export PATH=\"$HOME/.rbenv/bin:$PATH\"; eval \"$(rbenv init -)\"; cd :path && RAILS_ENV=:environment bundle exec rake :task :output"

every 1.day, at: "3:30 pm" do
  rake "logs:private_room"
rescue => e
  raise e
end
