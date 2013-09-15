project_name = "photogenic"

listen "/u/apps/" + project_name + "/shared/sockets/unicorn.sock"
pid "/u/apps/" + project_name + "/shared/pids/unicorn.pid"
stderr_path "/u/apps/" + project_name + "/shared/log/unicorn_stderr.log"

worker_processes 4
working_directory '/u/apps/' + project_name + "/current"
timeout 30
preload_app true

before_fork do |server, worker|
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.connection.disconnect!
  end
  old_pid = "/u/apps/" + project_name + "/shared/pids/unicorn.pid.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

after_fork do |server, worker|
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection
  end
end
