# Load DSL and set up stages
require "capistrano/setup"

# Include default deployment tasks
require "capistrano/deploy"

require "capistrano/rbenv"

require "capistrano/bundler"
require "capistrano/rails"

set :rbenv_type, :user
set :rbenv_ruby, '2.7.0'


require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git

# require "capistrano/rails/assets"
# require "capistrano/rails/migrations"
# require "capistrano/passenger"

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
