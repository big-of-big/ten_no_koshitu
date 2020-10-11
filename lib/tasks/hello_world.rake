namespace :hello_world do
  desc "テストです"
  task :hello => :environment do
    Team.create(name: "hoge", join_key: "hogekey")
  end

  desc "hogeです"
  task hoge: :environment do
    puts "hoge"
  end
end
