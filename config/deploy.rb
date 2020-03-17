# config valid for current version and patch releases of Capistrano
lock "~> 3.12.0"

set :application, "discord-dashboard"
set :repo_url, "https://github.com/utyosu/discord-dashboard"
set :branch, ENV['BRANCH'] || "master"

set :bundle_jobs, 1
set :pty, true
set :use_sudo, false
set :deploy_via, :remote_cache
set :deploy_to, "/home/ops/#{fetch(:application)}"

set :linked_dirs, fetch(:linked_dirs, []).push(
  'log',
  'tmp/pids',
  'tmp/cache',
  'tmp/sockets',
  'vendor/bundle',
)

namespace :smashing do
  task :start do
    on roles(:app) do
      execute "cd #{release_path} && bundle exec smashing start -d"
    end
  end

  task :stop do
    on roles(:app) do
      execute "cd #{release_path} && bundle exec smashing stop"
    end
  end

  task :restart do
    on roles(:app) do
      invoke 'smashing:stop'
      invoke 'smashing:start'
    end
  end
end

after 'deploy:publishing', 'smashing:restart'
