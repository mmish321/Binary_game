require 'gosu/all'
require_relative 'emptycell'
require_relative "iconcell"
require_relative "grid"


class GridGameExample < Gosu::Window
 
  def initialize(bit_size, code_length)
    if (bit_size == 3) 
      super(1200, 800, false)
    end
    if (bit_size == 4) 
      super(1600, 800, false)
    end
    @bit_size = bit_size
    @code_length = code_length
    @background_image = Gosu::Image.new("assets/clouds.jpg", {})
    @grid = CustomGrid.new(self, @bit_size, @code_length)
    puts @grid.code 
  end



  def draw
    @background_image.draw(0,0,0)
    @grid.draw
  end
end

meep = GridGameExample.new(4, 4)
meep.show