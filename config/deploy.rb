lock "~> 3.17.0"

set :application, "deviser-club"
set :repo_url, "git@github.com:Bishwas-py/deviser-club.git"

set :deploy_to, "/home/ubuntu/deviser-club"

set :branch, "main"

append :linked_files, "config/database.yml", 'config/master.key'

append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "tmp/webpacker", "public/system", "vendor/bundle"

set :keep_releases, 3
set :keep_assets, 3

set :db_local_clean, true
set :db_remote_clean, true

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end
  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'
end
