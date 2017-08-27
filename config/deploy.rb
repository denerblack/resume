require 'mina/rails'
require 'mina/git'
# require 'mina/rbenv'  # for rbenv support. (https://rbenv.org)
require 'mina/rvm'    # for rvm support. (https://rvm.io)

# Basic settings:
#   domain       - The hostname to SSH to.
#   deploy_to    - Path to deploy into.
#   repository   - Git repo to clone from. (needed by mina/git)
#   branch       - Branch name to deploy. (needed by mina/git)

set :application_name, 'resume'
set :domain, '54.207.111.9'
set :deploy_to, '/home/deploy/apps/resume'
set :repository, 'https://github.com/denerblack/resume.git'#'git://...'
set :branch, 'master'
set :stage, 'production'

# Optional settings:
set :user, 'deploy'          # Username in the server to SSH to.
#   set :port, '30000'           # SSH port number.
#   set :forward_agent, true     # SSH forward_agent.

# shared dirs and files will be symlinked into the app-folder by the 'deploy:link_shared_paths' step.
# set :shared_dirs, fetch(:shared_dirs, []).push('somedir')
   set :shared_files, fetch(:shared_files, []).push('config/database.yml', 'config/secrets.yml', 'tmp/sockets')#, 'tmp/sockets/puma.sock')

# This task is the environment that is loaded for all remote run commands, such as
# `mina deploy` or `mina rake`.
task :environment do
  # If you're using rbenv, use this to load the rbenv environment.
  # Be sure to commit your .ruby-version or .rbenv-version to your repository.
  # invoke :'rbenv:load'

  # For those using RVM, use this to load an RVM version@gemset.
  invoke :'rvm:use', 'ruby 2.4.0@default'
end

# Put any custom commands you need to run at setup
# All paths in `shared_dirs` and `shared_paths` will be created on their own.
task :setup do
  # command %{rbenv install 2.3.0}
end

desc "Deploys the current version to the server."
task :deploy do
  # uncomment this line to make sure you pushed your local branch to the remote origin
  # invoke :'git:ensure_pushed'
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    on :launch do
      in_path(fetch(:current_path)) do
        invoke :'puma:restart'
        #command %{mkdir -p tmp/}
        #command %{touch tmp/restart.txt}
      end
    end
  end

  # you can use `run :local` to run tasks on local machine before of after the deploy scripts
  # run(:local){ say 'done' }
end

namespace :puma do
  current_path = fetch(:current_path)
  desc "Start the application"
  task :start do
    command 'echo "-----> Start Puma"'
    command "cd #{current_path} && RAILS_ENV=#{stage} && bin/puma.sh start", :pty => false
  end

  desc "Stop the application"
  task :stop do
    command 'echo "-----> Stop Puma"'
    command "cd #{current_path} && RAILS_ENV=#{stage} && bin/puma.sh stop"
  end

  desc "Restart the application"
  task :restart do #, :roles => :app, :except => { :no_release => true } do
    command 'echo "-----> Restart Puma"'
    command "cd #{current_path} && RAILS_ENV=#{fetch(:stage)} && bin/puma.sh restart"
  end
end

# For help in making your deploy script, see the Mina documentation:
#
#  - https://github.com/mina-deploy/mina/tree/master/docs
