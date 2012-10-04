require 'capistrano/relevance/base'

Capistrano::Configuration.instance(:must_exist).load do
  # TODO As part of 'deploy:setup', automatically create "#{shared_path}/config"
  # TODO As part of before 'deploy:symlink_configs', copy database.example.yml if database.yml does not exist

  after 'deploy:finalize_update', 'deploy:symlink_configs'

  namespace :deploy do
    task :symlink_configs do
      shared_configs = File.join(shared_path,'config')
      release_configs = File.join(release_path,'config')
      run("ln -nfs #{shared_configs}/database.yml #{release_configs}/database.yml")
    end
  end
end
