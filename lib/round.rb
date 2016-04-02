module Mastermind
	class Round
		include Helpers 
		attr_accessor :round_result
		attr_reader :code, :codelength, :numrange, :whos_playing, :computerAI
		def initialize(args)
			@whos_playing = args.fetch(:whos_playing)
			@computerAI = args.fetch(:computerAI) if whos_playing == 'computer'
			@code = args.fetch(:code)
			@codelength = args.fetch(:codelength)
			@numrange = args.fetch(:numrange)
			whos_playing == 'human' ? take_guess : computer_guess
		end

		private

		def computer_guess
			guess = computerAI.current_guess
			proper_guess guess
		end

		def take_guess
			code_details
			puts 'Enter your guess:'
			guess = gets.chomp
			option? guess
			proper_guess guess
		end

		def proper_guess guess
			ary = str_to_num_ary guess

			if validate_code ary
				compare_guess ary
			else
				puts "Please guess #{codelength} numbers, 1-#{numrange}. (example: '#{generate_code({codelength: codelength, numrange: numrange})}')"
				take_guess
			end
		end

		def compare_guess guess
			code_ary = str_to_num_ary code
			puts (whos_playing == 'human' ? "Your guess: #{guess.to_s}" : "The computer's guess: #{guess.to_s}" ).magenta

			########################################
			#puts "The code: #{code_ary.to_s}"
			########################################

			status = Array.new(codelength, 'miss')

			codelength.times do |x|
				#check hits
				status[x] = 'hit' if code_ary[x] == guess[x]

				#check semi-hits
				if status[x] == 'miss'
					status[x] = 'semi-hit' if code_ary.include?(guess[x])
				end
			end
			@round_result = status
		end
	end
end






