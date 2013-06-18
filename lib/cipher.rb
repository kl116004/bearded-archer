require 'pry'



input = String.new
input = ARGV[0].dup

class Deck < Array
	def move(card, offset)
		index = self.index(card)
		new_index = index + offset
		self.delete(card)
		self.insert(new_index, card)		
	end
	
	def triple_cut_around(card1, card2)
	
	end
	
	def count_cut_last
	
	end
	
	def get_output_letter
	
	end
	
	def self.value_from_card(card)
	
	end	
end

def solitaire(input)

	def decode(msg)
		
		#Creates a hash with keys 1-54
		abc = ('A'..'Z').to_a
		alphaHash = Hash.new
		alphaHash.default = ""  
		(1..54).to_a.each {|x| alphaHash[x] = (abc[x - 1])}  #assigns 1-26 a letter in alphabetical order
		abc.each {|x| alphaHash[abc.index(x) + 27] = x}  #assigns letters in order to 27-52
																										 #All non-joker card values 1-52 can be resolved to their letter
	
		#Creates array in which each letter from msg is added as a number to the array, A = 1, B = 2 etc.
		msg.delete! ' '
		convertedMessage = Array.new
		msg.each_char {|letter| convertedMessage << alphaHash.key(letter)}
	
		#Create deck array, for this example in ascending numerical order; clubs, diamonds, hearts, spades
		deck = (1..54).to_a

		#Set indexes of two jokers
		jkr_a_idx = deck.index 53
		jkr_b_idx = deck.index 54
		
		convertedKeys = Array.new
		
		#This uses the solitaire cipher to generate the keys the message was encrypted with
		while convertedKeys.length < convertedMessage.length
				
			#Joker A down one card
			jkr_a_idx = deck.index 53
			jkr_a_idx += 1
		
			#check if it returns to front of deck
			if jkr_a_idx >= 54
				jkr_a_idx -= 54   #Reset index to beginning of deck
				jkr_a_idx += 1     #Joker can never be first card so it skips index 0
			end
		
			#Remove and insert Joker A at new index
			deck.delete(53)
			deck.insert(jkr_a_idx, 53)
		
		
			#Joker B down two cards
			jkr_b_idx = deck.index 54
			jkr_b_idx += 2
		
			#check if Joker B must return to front of deck
			if jkr_b_idx >= 54
				jkr_b_idx -= 54       #Reset index to beginning of deck
				jkr_b_idx += 1        #Joker can never be first card so it skips index 0.
			end
		
			#Remove and insert Joker B at new index
			deck.delete(54)
			deck.insert(jkr_b_idx, 54)
		
			#Triple cut around jokers, exchange cards above first joker with cards below second joker.
		
			#determine top and bottom jokers
			topJoker = deck.detect {|e| e == 53 or e == 54}
			if topJoker == 53
				bottomJoker = 54
			end
		
			if topJoker == 54
				bottomJoker = 53
			end
			
			#Make the cuts
			topCut = deck.slice!(0...deck.index(topJoker))
			if bottomJoker != deck.last			#if a joker is the last card, there is no bottom cut
				bottomCut = deck.slice!((deck.index(bottomJoker) + 1)..-1) #cuts cards after bottom joker to the last one
				deck.unshift bottomCut			#Inserts the bottomCut at the front
				deck.flatten!
			end
			deck << topCut
			deck.flatten!  #deck must be flattened as cuts are inserted as nested arrays
		
			#Count cut:  take last card's value, cut this many cards from top and insert before last card
			if deck.last == 53 or deck.last == 54			#Either joker's value is always 53
				countCut = deck.slice!(0...53)			#If either joker is the last card, we cut 53 cards
			else 
				countCut = deck.slice!(0...deck.last)
			end
			deck.insert(deck.index(deck.last), countCut)  #inserts the countCut before the last card
			deck.flatten!
		
		
		
			#Take first card's value, count this many cards, convert the facing card to a letter, this is the letter for the keystream
			if deck.first == 54  		#All jokers get value 53
				if deck[53] != 53 and deck[53] != 54			#If a joker is the facing card, there is no output to the keystream for this iteration
					convertedKeys << alphaHash.key((alphaHash[deck[53]])) #Any other facing card is converted to a letter, then back to numeric
				end
			else
				if deck[deck.first] != 53 and deck[deck.first] != 54  #Step is skipped if the facing card is a joker
					convertedKeys << alphaHash.key((alphaHash[deck[deck.first]]))
				end
			end	
		end #while loop
	
		decodedMessage = String.new	
		
		#Decodes the message
		#Both convertedMessage and convertedKeys are numeric values 1-26
		convertedMessage.each { |value|		
				#When decoding, subtract key from the encoded value for the decoded message
				if convertedKeys[decodedMessage.length] >= value  #If this operation is 0 or negative, add 26 to value
					decodedMessage << alphaHash[((value + 26) - convertedKeys[decodedMessage.length])]
				else
					decodedMessage << alphaHash[(value - convertedKeys[decodedMessage.length])]
				end						
			}	
	
		decodedMessage
	end  #decode
	
	puts decode(input)
end

puts solitaire(input)



