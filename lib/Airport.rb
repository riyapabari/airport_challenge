require_relative 'Plane'
require_relative 'Weather'

class Airport

	attr_reader :terminal, :capacity

	DEFAULT_CAPACITY = 10

	def initialize(capacity = DEFAULT_CAPACITY)
		@terminal = []
		@capacity = capacity
	end

	def incoming_plane(plane, weather = Weather.new.state)
		fail "Cannot land! Airport full!" if full?
		fail "Cannot land! Too stormy!" if weather == :stormy
		if terminal.include? plane
			"#{plane} has already landed!"
		elsif plane.at_airport?
			"#{plane} has already landed elsewhere!"
		else
		plane.land
		terminal << plane if (!full? && weather == :sunny)
		"Terminal:#{terminal}"
		end
	end

	def departing_plane(plane, weather = Weather.new.state)
		fail "Cannot take off! Too stormy!" if weather == :stormy
		if terminal.include? plane
			plane.take_off
			terminal.delete(plane)
			"#{plane} is taking off!"
		else
			"#{plane} is not at terminal!"
		end
	end

		private
	
	def full?
		true if terminal.length >= capacity
	end

end