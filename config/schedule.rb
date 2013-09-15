set :environment, :development
set :output, {:error => 'log/error.log', :standard => 'log/cron.log'}

every 12.hour do
  runner "Tasks::AutoRemove.execute"
end
