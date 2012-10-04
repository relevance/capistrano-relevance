require 'capistrano/relevance/base'

Capistrano::Configuration.instance(:must_exist).load do
  after 'deploy:update_code', 'deploy:migrate'
end
