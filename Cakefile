require "mysql"
require "micrate"
require "./src/env"

task :dbmigrate do

  user = String.build do |io|
    io <<  "#{ENV["MYSQL_USERNAME"]}"
    io << ":#{ENV["MYSQL_PASSWORD"]}" unless ENV["MYSQL_PASSWORD"].empty?
  end

  Micrate::Cli.setup_logger
  Micrate::DB.connection_url = "mysql://#{user}@#{ENV["MYSQL_HOSTNAME"]}:#{ENV["MYSQL_PORT"]}/#{ENV["MYSQL_DATABASE"]}"
  Micrate::DB.connect do |db|
    Micrate.up(db)
  end

end