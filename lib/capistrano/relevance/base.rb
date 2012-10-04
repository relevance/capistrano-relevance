unless Capistrano::Configuration.respond_to?(:instance)
  abort "capistrano requires Capistrano 2"
end
