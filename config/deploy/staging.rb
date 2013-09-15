role :app, "moznion.net"
role :db,  "moznion.net", {:primary=>true}
role :web, "moznion.net"

set :rails_env, "staging"
