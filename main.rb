require 'gosu'

class MyWindow < Gosu::Window
  def initialize
    super 640, 480
    self.caption = 'Binary_game'
  end
end

window = MyWindow.new
window.show