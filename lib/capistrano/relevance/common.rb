require 'capistrano/relevance/base'

Capistrano::Configuration.instance(:must_exist).load do
  set :user, 'deploy'
  set :use_sudo, false

  set :scm, :git
  set :deploy_via, :copy
  set(:deploy_to) { "/var/www/apps/#{application}" }

  default_run_options[:pty] = true # needed for Git password prompts
end