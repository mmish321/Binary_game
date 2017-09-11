class Cursor
	def initialize
		@image = Gosu::Image.new('assets/cursor.png', {})
		@x = 0
		@y = 0
		@clickimage = Gosu::Image.new('assets/cursor_click.png', {})
	end
    
    def change_x(num)
      @x = num
    end
    def click
    	@image = Gosu::Image.new('assets/cursor_click.png',{})
    end
    def unclick
    	@image = Gosu::Image.new('assets/cursor.png', {})
    end
    def change_y(num)
    	@y = num
    end
    def draw
    	@image.draw(@x,@y,2)
    end
    def x
    	@x
    end
    def y
    	@y
    end
end 
