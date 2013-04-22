require 'pry'

decrypt1 = "CLEPK HHNIY CFPWH FDFEH"
decrypt2 = "ABVAW LWZSY OORYK DUPVH"

input = String.new
input = ARGV[0].dup
#Reminders:  Array indexes start at 0
#Full deck indexes 0-53
#Clubs > Diamonds > Hearts > Spades
#Clubs = 1-13 ace to king
#Diamonds = +13
#Hearts = +26
#Spades = +39
#Either joker values at 53
#When cards must indicate letter Hearts and Spades = -26
#Jokers are never the first cards
#1.  Shuffle deck to key:  Our deck is unkeyed for the exercise
#2.  Joker A(val 53) down one cards
#3.  Joker B(val 54) down two
#4.  Triple cut around jokers:  exchange all cards above the top joker with cards under bottom joker
#5.  Count cut from last card:  Cut (last cards value) cards from top, insert before last card
#6.  Convert top card to value, count (top cards value) cards from top, next card is converted to output letter, this does not change deck.


def solitaire(input)

	def decode(msg)
	
	
	
		abc = ('A'..'Z').to_a
		alphaHash = Hash.new
		alphaHash.default = ""
		(1..54).to_a.each {|x| alphaHash[x] = (abc[x - 1])}
		abc.each {|x| alphaHash[abc.index(x) + 27] = x}
	
		msg.delete! ' '
		convertedMessage = Array.new
		msg.each_char {|letter| convertedMessage << alphaHash.key(letter)}
	
		#Create deck array to specific key
		deck = (1..54).to_a

		#Generate keys
		keys = Array.new
		jkr_a_idx = deck.index 53
		jkr_b_idx = deck.index 54
		convertedKeys = Array.new
	
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
			deck
			#Make the cuts
			topCut = deck.slice!(0...deck.index(topJoker))
			if bottomJoker != deck.last
				bottomCut = deck.slice!((deck.index(bottomJoker) + 1)..-1)
				deck.unshift bottomCut
				deck.flatten!
			end
			deck << topCut
			deck.flatten!
		
			#Count cut:  take last card's value, cut this many cards from top and insert before last card
			if deck.last == 53 or deck.last == 54
				countCut = deck.slice!(0...53)
			else 
				countCut = deck.slice!(0...deck.last)
			end
			deck.insert(deck.index(deck.last), countCut)
			deck.flatten!
		
		
		
			#Check if first card is Joker, if so, assign it value 53 if it does not already have that value
			if deck.first == 54
				if deck[53] != 53 and deck[53] != 54
					convertedKeys << alphaHash.key((alphaHash[deck[53]]))
				end
			else
				if deck[deck.first] != 53 and deck[deck.first] != 54
					convertedKeys << alphaHash.key((alphaHash[deck[deck.first]]))
				end
			end	
		end #while loop
	
		decodedMessage = String.new	
		 
		convertedMessage.each { |value|			
				if convertedKeys[decodedMessage.length] >= value
					decodedMessage << alphaHash[((value + 26) - convertedKeys[decodedMessage.length])]
				else
					decodedMessage << alphaHash[(value - convertedKeys[decodedMessage.length])]
				end				
						
			}	
	
		decodedMessage
	end  #decode
end

#puts decode(decrypt1)
#puts decode(decrypt2)

puts decode(input)



