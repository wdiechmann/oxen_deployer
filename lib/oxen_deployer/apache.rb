require 'oxen_deployer'

namespace :oxen do
  ##
  # Apache web server

  set :web_command, "apachectl"

  desc "(Re)Start the web servers"

  remote_task :start_web, :roles => :web  do
    run "#{web_command} restart"
  end

  desc "Stop the web servers"

  remote_task :stop_web, :roles => :web  do
    run "#{web_command} stop"
  end

  ##
  # Everything HTTP.

  desc "(Re)Start the web and app servers"

  remote_task :start do
    Rake::Task['oxen:start_app'].invoke
    Rake::Task['oxen:start_web'].invoke
  end

  desc "Stop the web and app servers"

  remote_task :stop do
    Rake::Task['oxen:stop_app'].invoke
    Rake::Task['oxen:stop_web'].invoke
  end
end
