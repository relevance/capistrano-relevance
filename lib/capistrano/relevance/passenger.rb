require 'capistrano/relevance/base'

Capistrano::Configuration.instance(:must_exist).load do
  namespace :deploy do
    task :start do ; end
    task :stop do ; end
    task :restart, :roles => :app, :except => {:no_release => true} do
      run "#{try_sudo} touch #{File.join(current_path, 'tmp', 'restart.txt')}"
    end
  end
end
