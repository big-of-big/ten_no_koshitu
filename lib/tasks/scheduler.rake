namespace :logs do
  desc "天鳳の個室ログをダウンロード"
  task :private_room => :environment do
    Log.create!(Log.private_room_log)
  end
end

desc "ほげほげ"
task :hoge => :environment do
  puts "Updating feed..."
  puts "done."
end
