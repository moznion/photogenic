listen 3000 # by default Unicorn listens on port 8080
worker_processes 2 # this should be >= nr_cpus
dir=File.dirname(File.expand_path(__FILE__))+'/../'
pid(dir+"/tmp/pids/unicorn.pid")
stderr_path(dir+"/tmp/log/unicorn.log")
stdout_path(dir+"/tmp/log/unicorn.log")
