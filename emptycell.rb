class EmptyCell < Gosu::Grid::Cell
  def size
    object.width
  end

  private
  
  def object
    @object ||= Gosu::Image.new('assets/empty_cell.png', {})
  end
end
