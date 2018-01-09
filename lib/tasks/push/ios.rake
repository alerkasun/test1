namespace :push do
  namespace :ios do
    desc 'Delete existing app: rake push:delete'
    task create: [:environment] do
      app = Rpush::Apns::App.new
      app.name = 'ios'
      app.certificate = File.read(ENV['sert_path'])
      app.environment = ENV['apns_env']
      app.password = ENV['password']
      app.connections = 1
      app.save!
    end

    task destroy: [:environment] do
      app = Rpush::Apns::App.find_by_name('ios')
      app.destroy!
    end
  end
end
