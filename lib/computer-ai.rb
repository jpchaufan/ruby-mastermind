module Mastermind
	class ComputerAI
		include Helpers

		attr_accessor :current_guess, :accuracy, :no_pick, :wrong_spot, :show_process, :thinking_speed
		attr_reader :codelength, :numrange
		def initialize(args)
			print "Computer AI loading".cyan
			@codelength = args.fetch(:codelength)
			@numrange = args.fetch(:numrange)
			@thinking_speed = args.fetch(:thinking_speed)
			@show_process = args.fetch(:show_process)
			loading_dots
			puts
			puts "detecting code of length #{codelength} and range of 1-#{numrange}".cyan
			@current_guess = random_guess
			setup_thinking_arrays
		end


		def setup_thinking_arrays
			@no_pick = []
			@wrong_spot = []
			codelength.times {@wrong_spot << []}
		end

		def random_guess
			computer_thinking
			@current_guess = str_to_num_ary (generate_code({codelength: codelength, numrange: numrange}))
		end

		def receive_accuracy accuracy
			@accuracy = accuracy
			process_accuracy
		end

		def process_accuracy
			computer_thinking
			codelength.times do |x|
				if accuracy[x] == 'hit'
					puts "detecting hit!".blue
					sleep 0.2  if thinking_speed == 'slow'
				elsif accuracy[x] == 'semi-hit'
					puts "detecting semi-hit...".blue
					computer_thinking
					add_to_wrong_spot(current_guess[x], x)
					current_guess[x] = smart_guess x
				elsif accuracy[x] == 'miss'
					puts "detecting miss...".blue
					computer_thinking
					add_to_no_pick current_guess[x]
					current_guess[x] = smart_guess x
				end
			end
			puts "computer analysis complete".blue
		end

		def add_to_no_pick x
			@no_pick << x unless @no_pick.include? x
			puts "OK I am not picking #{x} again...".blue
			puts "#{no_pick.to_s}".red if show_process == 'yes'
		end

		def add_to_wrong_spot num, spot
			@wrong_spot[spot] << num
			puts "OK the number #{num} does not belong there...".blue
			puts "#{wrong_spot.to_s}".red if show_process == 'yes'
		end

		def smart_guess spot
			while true do
				# pick rand num. guess is good if:
				# guess is not a known miss
				# 
				guess = rand(numrange)+1
				break if !(no_pick.include? guess) and !(wrong_spot[spot].include? guess)
			end


			guess
		end

		def computer_thinking
			if thinking_speed == 'slow'
				sleep 0.15
				puts "The computer is thinking...".cyan
				sleep 0.15
				loading_dots
				puts
				sleep 0.15
			end
		end


	end

end