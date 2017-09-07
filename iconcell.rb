class IconCell < Gosu::Grid::Cell
  def size
    object.width 
  end

  private

  def object
    @object ||= Gosu::Image.new('assets/star.png', {})
  end
end
