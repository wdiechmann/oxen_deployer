require 'rubygems'
require 'thread'
require 'rake/remote_task'

$TESTING ||= false

##
# Deployer - Pragmatic application deployment automation,
# without mercy.
#
# Please read doco/getting_started.txt or http://rubyhitsquad.com/
#
# === Basic scenario:
#
# 1. rake deployer:setup   (first time only)
# 2. rake deployer:update
# 3. rake deployer:migrate (optional)
# 4. rake deployer:start

module OxenDeployer

  ##
  # This is the version of Deployer you are running.
  VERSION = "1.0.0"

  ##
  # Loads tasks file +tasks_file+ and various recipe styles as a hash
  # of category/style pairs. Recipes default to:
  #
  #     :app    => :passenger
  #     :config => 'config/deploy.rb'
  #     :core   => :core
  #     :scm    => :subversion
  #     :web    => :apache
  #
  # You can override individual values and/or set to nil to
  # deactivate. :config will get loaded last to ensure that user
  # variables override default values.
  #
  # And by all means, feel free to skip this entirely if it doesn't
  # fit for you. All it does is a fancy-pants require. Require
  # whatever files you need as you see fit straight from your
  # Rakefile. YAY for simple and clean!

  def self.load options = {}
    options = {:config => options} if String === options
    order = [:core, :type, :app, :config, :scm, :web]
    order += options.keys - order

    recipes = {
      :app    => :passenger,
      :type   => :rails,
      :config => 'config/deploy.rb',
      :core   => :core,
      :scm    => :subversion,
      :web    => :apache,
    }.merge(options)

    order.each do |flavor|
      recipe = recipes[flavor]
      next if recipe.nil? or flavor == :config
      begin
        require "Deployer/#{recipe}"
      rescue LoadError => e
        re = RuntimeError.new e.message
        re.backtrace = e.backtrace
        raise re
      end
    end

    set :skip_scm, false

    Kernel.load recipes[:config]
    Kernel.load "#{File.dirname(recipes[:config])}/deploy_#{ENV['to']}.rb" if ENV['to']
  end
end

class String #:nodoc:
  def cleanup
    if ENV['FULL'] then
      gsub(/\s+/, ' ').strip
    else
      self[/\A.*?\./]
    end
  end
end
