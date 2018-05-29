require "mysql"
require "micrate"
require "./src/env"

task :dbmigrate do
  Micrate::Cli.setup_logger
  Micrate::DB.connection_url = "mysql://#{ENV["MYSQL_USERNAME"]}:#{ENV["MYSQL_PASSWORD"]}@#{ENV["MYSQL_HOSTNAME"]}:#{ENV["MYSQL_PORT"]}/#{ENV["MYSQL_DATABASE"]}"
  Micrate::DB.connect do |db|
    Micrate.up(db)
  end
end