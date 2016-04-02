require_relative "round.rb"
require_relative "computer-ai.rb"

module Mastermind
	class Game
		include Helpers 
		attr_accessor :rounds_left, :round_result, :endgame, :thinking_speed, :show_process
		attr_reader :code, :codelength, :numrange, :whos_playing, :computerAI
		def initialize args={player: 'human', codelength: 4, guesses: 12, numrange: 6}
			@whos_playing = args.fetch(:player)
			@codelength = args.fetch(:codelength)
			@rounds_left = args.fetch(:guesses)
			@numrange = args.fetch(:numrange)
			@thinking_speed = args.fetch(:thinking_speed)
			@show_process = args.fetch(:show_process)
			code_generation_process
			@round_result

			if whos_playing == 'computer'
				@computerAI = ComputerAI.new({codelength: codelength, numrange: numrange, thinking_speed: thinking_speed, show_process: show_process})
			end

			run_round			
		end

		private

		def code_generation_process
			if whos_playing == 'human'
				@code = generate_code({codelength: codelength, numrange: numrange})
			else
				puts "Do you want to make a code? (type yes) or have one automatically generated? (just hit enter)"
				cmd = gets.chomp.downcase
				option? cmd
				if cmd == 'yes'
					puts "The code must be #{codelength} numbers long."
					puts "It must consist of the numbers 1 through #{numrange}."
					check = gets.chomp
					if validate_code(str_to_num_ary(check))
						puts "OK let's see how the computer does"
						@code = check
					else
						puts "That's not a valid code..."
						code_generation_process
					end
				elsif validate_code(str_to_num_ary(cmd))
					@code = cmd
				else
					@code = generate_code({codelength: codelength, numrange: numrange})
				end
			end
		end

		def run_round
			puts "Tries left: #{rounds_left}"
			current_round = Round.new({code: code, codelength: codelength, numrange: numrange, whos_playing: whos_playing, computerAI: computerAI})
			@round_result = current_round.round_result
			process_result round_result
		end

		def process_result result
			puts (whos_playing == 'human' ? "Your accuracy: #{result}" : "Computer's accuracy: #{result}").blue
			win_lose? result
			unless @endgame
				computerAI.receive_accuracy result if whos_playing == 'computer'
				@rounds_left -= 1
				run_round
			end
		end

		def win_lose? result
			hits = 0
			result.each do |x|
				hits += 1 if x == 'hit'
			end
			if hits == codelength
				puts "Computer guessed the code!" if whos_playing == 'computer'
				puts
				print '           Y'.red
				sleep 0.5
				print 'O'.green
				sleep 0.5
				print 'U'.blue
				sleep 0.5
				print ' '
				sleep 0.5
				print 'W'.red
				sleep 0.5
				print 'I'.yellow
				sleep 0.5
				print 'N'.light_black
				sleep 0.5
				print '!'.cyan
				sleep 0.5
				print '!'.magenta
				sleep 0.5
				puts '!'.blue
				sleep 0.5
				puts
				@endgame = 'win'
			elsif @rounds_left == 1
				puts "Computer did not guess the code..." if whos_playing == 'computer'
				puts "The code was: #{code}"
				puts 'YOU LOSE'.light_black
				@endgame = 'lose'
			end
		end
	end
end






