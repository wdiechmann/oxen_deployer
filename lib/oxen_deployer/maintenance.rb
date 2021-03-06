require 'oxen_deployer'

##
# See the following documents for recipes:
#
# * http://clarkware.com/blog/2007/1/5/custom-maintenance-pages
# * http://blog.nodeta.fi/2009/03/11/stopping-your-rails-application-with-phusion-passenger/
#

namespace :oxen do
  namespace :maintenance do

    desc "Turn on the maintenance web page"

    remote_task :on, :roles => [:web] do
      run "cp -f #{shared_path}/config/maintenance.html #{shared_path}/system/"
    end

    desc "Turn off the maintenance web page"

    remote_task :off, :roles => [:web] do
      run "rm -f #{shared_path}/system/maintenance.html"
    end
  end
end
