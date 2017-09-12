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
		@image = Gosu::Image.new('assets/#{@number}_button_click.png',{})
	end
	def unclick
		@image = Gosu::Image.new(@image_x, {})
	end

end