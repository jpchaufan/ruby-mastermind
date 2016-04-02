require 'colorize'

module Helpers

	def generate_code args
		numrange = args.fetch(:numrange)
		codelength = args.fetch(:codelength)
		x = ''
		codelength.times {x += (rand(numrange)+1).to_s}
		x
	end

	def validate_code check
		good = 0
		check.each { |x|
			good += 1 if x >= 1 && x <= numrange
		  }
		good == codelength ? true : false
	end

	def str_to_num_ary string
		if string.class != Array
			x = string.split('')
			output = []
			x.each do |digit|
				output << digit.to_i
			end
			output
		else
			string
		end		
	end

	def num_ary_to_str ary
		if ary.class != String
			output = ''
			ary.each do |digit|
				output += digit.to_s
			end
			output
		else
			ary
		end
	end

	def option? command
		cmd = command.downcase
		if cmd == 'exit' or cmd == 'quit'
			puts 'Goodbye...'
			exit
		elsif cmd == 'help'
			help_text
		elsif cmd == 'options' or cmd == 'option'
			ask_options
		elsif cmd == 'restart'
			setup
		end
	end

	def ask_options
		puts "Computer thinking is: #{@thinking_speed}".light_black
		puts "What should it be? (type 'fast' or 'slow'".light_black
		cmd = gets.chomp
		if cmd == 'fast'
			@thinking_speed = 'fast'
		elsif cmd == 'slow'
			@thinking_speed = 'slow'
		else 
			puts "Did not change anything.".light_black
		end

		puts "Computer process showing?: #{@show_process}".light_black
		puts "Should it be showing? (type 'yes' or 'no'".light_black
		cmd = gets.chomp
		if cmd == 'yes'
			@show_process = 'yes'
		elsif cmd == 'no'
			@show_process = 'no'
		else 
			puts "Did not change anything.".light_black
		end

		puts "Changes will be made next game".light_black
		puts

	end

	def code_details
		puts "Code is #{codelength} numbers long, using numbers 1-#{numrange}"
	end

	def help_text
		puts "#"
		puts
		puts 'Welcome to mastermind! A game about cracking codes.'
		puts 
		puts 'How To Play:'.red
		puts 'The secret code is 4 numbers long, and each number can be 1 through 6'
		puts 'so the code could be 2166'
		puts 'if you guess 4125...'
		puts 'you would get back that the number 1 was correct,'
		puts 'and also that 2 was semi-correct (because it is in the code, but in the wrong place)'
		puts 'and by elimination, you could know that 4 and 5 are not in the code'
		puts
		puts 'Summary:'.red
		puts 'the code is 4 numbers, each 1-6'
		puts 'hit means a guess was the right number'
		puts 'semi-hit means a guess was the right number but in the wrong position'
		puts 'miss means a number is not in the code'
		puts
		puts 'Other Commands:'.blue
		puts "'exit', 'help', 'options'".blue
		puts
	end

	def puts_mastermind
	 puts '    ___  ___   ___   ___  ____ ____ __   _  __   _ _   __ __  '
	 puts '   /   \\/   \\ /   \\ /  __\\_  _|  __| _ \\/ \\/  \\ | |  \\|  |  \\ '
	 puts '  /          \\  _  \\_:. `.| | | __||   /       \\| |      | | | '
	 puts ' /___/\\__/\\___\\/ \__\\____/|_| |____|_\_\\_/\\/\\_\_|_|_|\\___|__/  '
	end

	def loading_dots
		10.times do
			print '.'.cyan
			sleep 0.15
		end
	end

end