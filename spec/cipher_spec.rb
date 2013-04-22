require 'minitest/spec'
require 'minitest/autorun'
require_relative '../lib/cipher'

describe solitaire do
	it 'must detect if it must encode or decode input' do
		solitaire("CLEPK HHNIY CFPWH FDFEH").must_equal 'YOURCIPHERISWORKINGX'
		solitaire("Your cipher is working").must_equal 'CLEPK HHNIY CFPWH FDFEH'
	end
	
	
end
