require 'gosu/all'
class DeadCell < Gosu::Grid::Cell
  def size
    object.width
  end

  private

  def object
    @object ||= Gosu::Image.new('assets/dead_cell.png', {})
  end
end

class GridGameExample < Gosu::Window
  def initialize
    super(540, 320, false)
    @grid = Gosu::Grid.new(self)
    @grid.default_cell = DeadCell.new(self, 0, 0)
  end

  def draw
    @grid.draw && sleep(0.05)
  end
end

meep = GridGameExample.new
meep.show