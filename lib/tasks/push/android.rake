namespace :push do
  namespace :android do
    desc 'Register new app with given credentials: rake push:register'
    task create: [:environment] do
      app = Rpush::Gcm::App.new
      app.name = 'android'
      app.auth_key = ENV['key']
      app.connections = 1
      app.save!
    end

    task destroy: [:environment] do
      app = Rpush::Gcm::App.find_by_name('android')
      app.destroy!
    end
  end
end
