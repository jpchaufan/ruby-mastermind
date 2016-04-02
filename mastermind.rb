require_relative "lib/helpers.rb"
require_relative "lib/game.rb"

class MastermindGame
	include Mastermind
	include Helpers 

	attr_accessor :game, :wins, :losses, :thinking_speed, :show_process

	def initialize
		## Instructions ##
		@wins = 0
		@losses = 0
		@thinking_speed = 'slow'
		@show_process = 'no'

		puts ('#'*85).green
		puts
		puts_mastermind
		puts
		puts 'Mastermind'.underline.bold.red.center(80)
		puts
		help_text
		puts 'Ready to play?'
		puts ('#'*85).green
		puts 
		gameloop
	end

	def gameloop
		setup
	end

	private

	def replay
		puts "Play Again? (y/n)".green
		cmd = gets.chomp.downcase
		option? cmd
			case cmd
		when 'y', 'yes', 'ye', 'ya'
			gameloop
		when 'no', 'n'
			puts 'Thanks for playing'
			exit
		else
			replay
		end
	end
	
	def setup

		#human or computer player
		puts "Do you want the computer to play?".red
		puts "If yes, type 'yes'."
		puts "If you want to play, just hit enter"
		player_status = gets.chomp.downcase
		option? player_status
		if ['help', 'option', 'options'].include? player_status
			setup
		end
		player_status = (player_status == 'yes' ? 'computer' : 'human')
		if player_status == 'human'
			you_have = 'you have'
			you = 'you have'
		else
			you_have = 'the computer has'
			you = 'the computer have'
		end

		#difficulty settings
		print "Choose a difficulty: "
		print "easy".green
		print ", "
		print "medium".blue
		print ", "
		print "hard".red
		print ", "
		puts "custom".magenta
		cmd = gets.chomp.downcase
		option? cmd
		case cmd
		when 'easy'
			print 'Choosing '
			print 'easy'.green
			puts ' difficulty...'
			puts "Code is 4 digits long, #{you_have} 12 guesses, using numbers 1-6".light_black
			@game = Game.new({player: player_status, codelength: 4, guesses: 12, numrange: 6, thinking_speed: thinking_speed, show_process: show_process})
		when 'medium', 'med'
			print 'Choosing '
			print 'medium'.blue
			print ' difficulty...'
			puts "code is 5 digits long, #{you_have} 12 guesses, using numbers 1-7".light_black
			@game = Game.new({player: player_status, codelength: 5, guesses: 12, numrange: 7, thinking_speed: thinking_speed, show_process: show_process})
		when 'hard'
			print 'Choosing '
			print 'hard'.red
			puts ' difficulty...'
			puts "code is 6 digits long, #{you_have} 10 guesses, using numbers 1-8".light_black
			@game = Game.new({player: player_status, codelength: 6, guesses: 10, numrange: 8, thinking_speed: thinking_speed, show_process: show_process})
		when 'custom'

			#custom setting
			puts 'Set up your own game...'.magenta
			puts 'how long should the code be?'
			length = 0
			while true do
				length = gets.chomp.to_i
				break if length < 21 and length > 0 
				sleep 0.5
				puts 'pick a code length between 1 and 20'
			end

			tries = 0
			puts 'how many rounds should '+you+' to guess?'
			while true do
				tries = gets.chomp.to_i
				break if tries < 101 and tries > 1 
				puts 'pick a number of tries between 2 and 100'
			end

			range = 0
			puts "what range of digits should be used in the code? (e.g. 1-6, enter 6. or 1-9, enter 9)"
			while true do
				range = gets.chomp.to_i
				break if range < 10 and range > 1 
				puts 'pick a range limit between 2 and 9'
			end

			@game = Game.new({player: player_status, codelength: length, guesses: tries, numrange: range})
		else 
			setup 
		end
		keep_score
		replay
	end

	def keep_score
		@wins += 1 if @game.endgame == 'win'
		@losses += 1 if @game.endgame == 'lose'
		puts "Score:".green
		puts "Wins: #{wins}"
		puts "Losses: #{losses}"
	end
end

game_object = MastermindGame.new

