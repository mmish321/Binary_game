class IconCell < Gosu::Grid::Cell
  def initialize(window, row, column, picture)
  	super(window, row, column)
  	@picture = picture
  end
  def z
    1
  end
  def size
    object.width 
  end
  def object
  	@object = Gosu::Image.new(@picture,{})
  end

end
