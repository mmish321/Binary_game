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
      for i in 0...8
        if i <=3
          @buttons.push(NumberButton.new(400+(i*200), 500, "assets/#{1}_100.png", i))
        else
          @buttons.push(NumberButton.new(400 + ((i-4)*200), 650, "assets/#{1}_100.png", i))
        end
      end
    end
    if (bit_size == 4) 
      super(1600, 800, false)
      for i in 0...17
        if i <=8
          @buttons.push(NumberButton.new(400+(i* 150), 525, "assets/#{1}_100.png", i))
        else
          @buttons.push(NumberButton.new(400 +((i-9)*150), 675, "assets/#{1}_100.png", i))
        end
      end
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
    for button in @buttons
      if button.clicked_on?(@cursor) && (Gosu::button_down? Gosu::MsLeft) then
        button.clicked_on
      else
        button.unclick
     end
    end
  end

 def draw
    for button in @buttons
      button.draw
    end
    @cursor.draw
    @background_image.draw(0,0,0)
    @grid.draw
  end

end

meep = GridGameExample.new(4,4)
meep.show