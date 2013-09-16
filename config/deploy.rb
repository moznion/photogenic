require 'bundler/capistrano'

# bundle flagの削除
# http://takuyan.hatenablog.com/entry/20110121/1295571519
set :bundle_flags, "--quiet"

# ================================================================
# ROLES
# ================================================================

set :stages,        %w(production staging)
set :default_stage, "staging"
require 'capistrano/ext/multistage'

# ================================================================
# VARIABLES
# ================================================================

set :application,           "photogenic"
set :deploy_to,             "/u/apps/#{application}"
set :deploy_via,            :copy
set :repository,            "git@github.com:moznion/photogenic.git"
set :branch,                "master"
set :runner,                ""
set :scm,                   "git"
set :git_enable_submodules, true
set :shared_children,       %w(public/system log tmp/pids tmp/sockets)
set :use_sudo,              false
set :user,                  "deployer"
set :rake_tasks,            []
set :force_precompile,      false  # true to ensure assets:precompile

set :default_environment, {
  'RBENV_ROOT' => '/usr/local/rbenv',
  'PATH'       => "/usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH"
}

# ================================================================
# TEMPLATE TASKS
# ================================================================

# allocate a pty by default as some systems have problems without
default_run_options[:pty] = true
ssh_options[:forward_agent] = true
ssh_options[:auth_methods] = ["publickey"]
ssh_options[:keys] = [ENV['HOME'] + '/.ssh/id_rsa']

# set Net::SSH ssh options through normal variables
# at the moment only one SSH key is supported as arrays are not
# parsed correctly by Webistrano::Deployer.type_cast (they end up as strings)
[:ssh_port, :ssh_keys].each do |ssh_opt|
  if exists? ssh_opt
    logger.important("SSH options: setting #{ssh_opt} to: #{fetch(ssh_opt)}")
    ssh_options[ssh_opt.to_s.gsub(/ssh_/, '').to_sym] = fetch(ssh_opt)
  end
end

# ================================================================
# CLEAN UP
# ================================================================
set :keep_releases, 10
after "deploy:update", "deploy:cleanup"

# ================================================================
# CUSTOM RECIPES
# ================================================================
namespace :unicorn do
  desc "make config file"
  task :make_config_file, :roles => [:app] do
    require 'erubis'
    require 'tmpdir'

    upstart_path = File.join(Dir.tmpdir, 'upstart_unicorn.conf.erb')
    get("#{current_path}/config/upstart_unicorn.conf.erb", upstart_path)

    eruby = Erubis::Eruby.load_file upstart_path
    put eruby.evaluate(project_name: application, stage: stage),
        "/etc/init/#{application}.conf".strip
  end
end

after 'deploy:create_symlink', 'unicorn:make_config_file'

namespace :nginx do
  desc "make nginx site config"
  task :make_config_file, :roles => [:app] do
    require 'erubis'
    require 'tmpdir'

    dir = Dir.tmpdir
    config_path = File.join(dir, 'nginx.conf.erb')
    get("#{current_path}/config/nginx.conf.erb", config_path)

    eruby = Erubis::Eruby.load_file config_path
    put eruby.evaluate(project_name: application),
        "/usr/local/nginx/conf/sites-available/#{application}.conf"
  end
end

after 'deploy:create_symlink', 'nginx:make_config_file'

# initialize database.yml
namespace :deploy do

  namespace :db do

    desc <<DESC
Creates the database.yml configuration file in shared path.

By default, this task uses a template unless a template \
called database.yml.erb is found either is :template_dir \
or /config/deploy folders. The default template matches \
the template for config/database.yml file shipped with Rails.

When this recipe is loaded, db:setup is automatically configured \
to be invoked after deploy:setup. You can skip this task setting \
the variable :skip_db_setup to true. This is especially useful \
if you are using this recipe in combination with \
capistrano-ext/multistaging to avoid multiple db:setup calls \
when running deploy:setup for all stages one by one.
DESC
    task :setup, :except => { :no_release => true } do
      require 'erb'
      require 'tmpdir'

      location = fetch(:template_dir, "/u/templates") + '/database.yml.erb'
      template_path = File.join(Dir.tmpdir, 'upstart.conf.erb')
      get(location, template_path)

      config = ERB.new(File.read(template_path))

      run "mkdir -p #{shared_path}/db"
      run "mkdir -p #{shared_path}/config"
      put config.result(binding).gsub('production', stage.to_s),
          "#{shared_path}/config/database.yml"
    end

    desc <<-DESC
[internal] Updates the symlink for database.yml file to the just deployed release.
DESC
    task :symlink, :except => { :no_release => true } do
      run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    end
  end

  after "deploy:setup",           "deploy:db:setup"   unless fetch(:skip_db_setup, false)
  # precompile runs rake, so it needs a sound setting of database.yml
  before "deploy:assets:precompile", "deploy:db:symlink"
end

namespace :uploads do
  desc 'Creates the upload folders unless they exist and set permissions'
  task :setup, :expect => { :no_release => true } do
    dirs = uploads_dirs.map { |d| File.join(shared_path, d) }
    run "mkdir -p #{dirs.join(' ')} && chmod g+w #{dirs.join(' ')}"
  end

  desc 'Creates symlinks'
  task :symlink, :expect => { :no_release => true } do
    run "rm -rf  #{release_path}/public/resource"
    run "ln -nfs #{shared_path}/resource #{release_path}/public/resource"
  end

  desc 'initialize'
  task :register_dirs do
    set :uploads_dirs, %w(resource)
  end

  after       "deploy:finalize_update", "uploads:symlink"
  on :start,  "uploads:register_dirs"
end

namespace :deploy do
  task :start, :roles => :app do
    run "sudo restart #{application} || sudo start #{application}"
  end
  task :restart, :roles => :app do
    sudo "restart #{application}"
  end
  task :stop, :roles => :app do
    sudo "stop #{application}"
  end
end
