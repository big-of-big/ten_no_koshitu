rails_env = ENV['RAILS_ENV'] || :development
set :environment, rails_env

set :job_template, "/bin/zsh -l -c ':job'"
job_type :rake, "export PATH=\"$HOME/.rbenv/bin:$PATH\"; eval \"$(rbenv init -)\"; cd :path && RAILS_ENV=:environment bundle exec rake :task :output"

every 1.minute do
  begin
    rake "hello_world:hello"
  rescue => e
    raise e
  end
end
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
