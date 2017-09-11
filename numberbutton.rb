class NumberButton
	def initialize(x, y, image, number)
		@x = x
		@y = y
		@image = Gosu::Image.new(image, {})
		@number = number
		@image_x = image
	end

	def draw
		@image.draw(@x, @y, 1)
	end

	def number
		@number
	end

	def clicked_on?(cursor)
		if Gosu::distance(@x, @y, cursor.x, cursor.y) < 100 then
			return true
		end
	end
	def clicked_on
		@image = Gosu::Image.new('assets/star100.png',{})
	end
	def unclick
		@image = Gosu::Image.new(@image_x, {})
	end

end