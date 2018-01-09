namespace :app do
  %w(start stop restart status).each do |command|
    desc "Application #{command.capitalize}"
    task command do
      on roles :app do
        sudo "#{command} #{fetch(:application)}"
      end
    end
  end
end
