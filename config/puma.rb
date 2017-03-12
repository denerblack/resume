=begin
threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }.to_i
threads threads_count, threads_count
port        ENV.fetch("PORT") { 3000 }

environment ENV.fetch("RAILS_ENV") { "development" }

plugin :tmp_restart
=end

#!/usr/bin/env puma


environment ENV['RAILS_ENV'] || 'production'

daemonize true

pidfile "/var/www/resume/shared/tmp/pids/puma.pid"
stdout_redirect "/var/www/resume/esdb.cn/shared/tmp/log/stdout", "/home/ubuntu/apps/esdb.cn/shared/tmp/log/stderr"

threads 0, 16

bind "unix:///var/www/resume/esdb.cn/shared/tmp/sockets/puma.sock"
