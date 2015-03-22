# config valid only for current version of Capistrano
lock '3.3.5'

set :application, 'sample_rails_app'
set :repo_url, 'git@github.com:robertjlooby/sample_rails_app.git'

set :deploy_to, '/var/www/sample_rails_app'

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('bin', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :puma do
  task :start do
    on roles(:all) do
      execute "cd #{release_path} && source $(rvm 2.0.0-p598 do rvm env --path) && bundle exec foreman export upstart /etc/init -a sample_rails_app -u rails -l log/rails/rails_app"
      execute "start sample_rails_app"
    end
  end
end
