#!/usr/bin/env ruby

project_name = Dir.pwd
#project_name = ""
puts "What do you need (select an option)"
puts "1 - Run the project"
puts "2 - Initialize a new Instance"
puts "3 - Build a new Instance"
puts "4 - Docker compose down"
puts "0 - Run Exit"
puts '\n'
puts "Input your choice:"

option = gets.chomp

case option
when "1"
	exec "docker-compose run -p 3000:3000 resume /bin/bash"
when "2"
	exec "docker-compose run resume /bin/bash"
when "3"
	exec "docker rm -f resume"
	exec "docker-compose build"
when "4"
	exec "docker-compose down"
else
	exit;
end
