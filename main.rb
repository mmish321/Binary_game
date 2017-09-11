require 'gosu/all'
require_relative "iconcell"
require_relative "grid"
require_relative "cursor"
require_relative "numberbutton"

class GridGameExample < Gosu::Window
 
  def initialize(bit_size, code_length)
    @cursor = Cursor.new
    @bit_size = bit_size
    @code_length = code_length
    @background_image = Gosu::Image.new("assets/clouds.jpg", {})
    @grid = CustomGrid.new(self, @bit_size, @code_length)
    @code = @grid.code
    @buttons = Array.new
    if (bit_size == 3) 
      super(1200, 800, false)

    end
    if (bit_size == 4) 
      super(1600, 800, false)
    end
   
   
  end

  def update
    if Gosu::button_down? Gosu::MsLeft then
      @cursor.click
    else
      @cursor.unclick
    end
    @cursor.change_x(mouse_x)
    @cursor.change_y(mouse_y)
    if @button1.clicked_on?(@cursor) && (Gosu::button_down? Gosu::MsLeft) then
      @button1.clicked_on
    else
      @button1.unclick
    end
  end





  def draw
    @cursor.draw
    @button1.draw
    @background_image.draw(0,0,0)
    @grid.draw
  end
end

meep = GridGameExample.new(3, 4)
meep.show