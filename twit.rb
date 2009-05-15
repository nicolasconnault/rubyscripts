#!/usr/bin/ruby
require 'rubygems'
require 'twitter'
require 'optparse'

# UI Application

$options = {}

class App
	def initialize(args)
		begin
			parse_options(args)
		rescue ArgumentError, OptionParser::ParseError => msg
			$stderr.print "Error: #{msg}\n"
			exit
		end
	end

	def parse_options(args)
		commands = [:update, :user_timeline, :list_friends, :list_followers, :make_friend]

		OptionParser.new do |opts|
			opts.banner = "Usage: twitter [options]"

			opts.on("-c", "--command COMMAND", commands) do |v|
				$options[:command] = v
			end

			opts.on("-m", "--message MESSAGE") do |v|
				$options[:message] = v
			end

			opts.on("-u", "--username USER") do |v|
				$options[:username] = v
			end

			opts.on("-p", "--password PASSWORD") do |v|
				$options[:password] = v
			end

			opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
				$options[:verbose] = v
			end

            opts.on("-i", "--id", "User Id") do |v|
				$options[:userid] = v
			end

			opts.on_tail("-h", "--help", "Show this message") do
				puts opts
				exit
			end
		end.parse!(args)

		case $options[:command]
            when :update
                raise ArgumentError, "Update needs a message" if not $options[:message]
            when :make_friend
                raise ArgumentError, "Make Friend needs a user id" if not $options[:userid]
		end
	end

	def run()
        auth = Twitter::HTTPAuth.new($options[:username], $options[:password])
        twitter = Twitter::Base.new(auth)

        case $options[:command]
            when :update
                print "update: %s\n" % [$options[:message]] if $options[:verbose]
                twitter.update($options[:message])
            when :user_timeline
                twitter.user_timeline.each do |mash|
                    mash.each do |var|

                    end
                end
            when :list_followers
                puts twitter.follower_ids
            when :list_friends
                puts twitter.friend_ids
            when :make_friend
                twitter.friendship_create($options[:userid])
		end
	end
end

app = App.new(ARGV)
app.run()
