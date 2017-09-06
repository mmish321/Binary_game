require 'gosu_grid'

class DeadCell < Gosu::Grid::Cell
  def size
    object.width
  end

  private

  def object
    @object ||= Gosu::Image.new(window, 'assets/dead_cell.png', true)
  end
end