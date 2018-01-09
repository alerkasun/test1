namespace :admin do
  desc 'Creates admin account with given credentials: rake admin:create'
  task create: [:environment] do
    AdminUser.create! email: ENV['email'], password: ENV['password']
  end
end
