class Rack::Attack
 throttle('req/ip', :limit => 200, :period => 5.minutes) do |req|
    req.ip # unless req.path.start_with?('/assets')
  end

  # 例: 同一IPアドレスからの/loginへのPOSTリクエストを10秒あたり5回までに制限
  throttle('login/ip', :limit => 5, :period => 10.seconds) do |req|
    if req.path == '/login' && req.post?
      req.ip
    end
  end

  throttle('signup/ip', :limit => 20, :period => 20.hours) do |req|
    if req.path == '/signup' && req.post?
      req.ip
    end
  end
end
