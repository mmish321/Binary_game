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
        if (Gosu::button_down? Gosu::MsLeft) then
    	   @image = Gosu::Image.new('assets/cursor_click.png',{})
           return true
        else
            @image = Gosu::Image.new('assets/cursor.png', {})
           return false
        end
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
