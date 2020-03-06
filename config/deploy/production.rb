role :app, %w{ops@gce}

server "gce", user: "ops", roles: %w[app]
