require_relative "number"
class NumberButton < Number
	def initialize(x,y,image, value)
		super(x,y,image,value)
		@image_x = image
	end
	def clicked_on?(cursor)
		if Gosu::distance(@x, @y, cursor.x, cursor.y) < 50 then
			return true
		end
	end
	def clicked_on
		temp = "assets/#{@value}_100_gold.png"
		@image = Gosu::Image.new(temp,{})
	end
	def unclick
		@image = Gosu::Image.new(@image_x, {})
	end

end