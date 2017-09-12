require 'gosu/all'
require_relative "iconcell"
require_relative "grid"
require_relative "cursor"
require_relative "numberbutton"
require_relative "number"
require_relative "graphic"

class BinaryGame < Gosu::Window
 
  def initialize(bit_size, code_length)
    @cursor = Cursor.new
    @bit_size = bit_size
    @code_length = code_length
    @background_image = Gosu::Image.new("assets/clouds.jpg", {})
    @goal_image = Gosu::Image.new("assets/bear&honey.png", {})
    @grid = CustomGrid.new(self, @bit_size, @code_length)
    @code = @grid.code
    @buttons = Array.new
    @example_3image = Gosu::Image.new("assets/example_3bit.jpg", {})
    @example_4image = Gosu::Image.new("assets/example_4bit.png", {})
    @numbers = Array.new
    @dashes = Array.new
    if (bit_size == 3) 
      super(1200, 800, false)
      for i in 0...8
        if i <=3
          @buttons.push(NumberButton.new(400+(i*200), 550, "assets/#{1}_button.png", i))
        else
          @buttons.push(NumberButton.new(400 + ((i-4)*200), 700, "assets/#{1}_button.png", i))
        end
      end
      #for i in 0...code_length
        #x_pos = (! * i) + !
        #y_pos = (! * i) + !
        #@dashes.push(Graphic.new(x_pos, y_pos,"assets/dash.png"))
      #end
    end
    if (bit_size == 4) 
      super(1600, 800, false)
      for i in 0...17
        if i <=8
          @buttons.push(NumberButton.new(400+(i* 150), 525, "assets/#{1}_button.png", i))
        else
          @buttons.push(NumberButton.new(400 +((i-9)*150), 675, "assets/#{1}_button.png", i))
        end
      end
       #for i in 0...code_length
        #x_pos = (! * i) + !
        #y_pos = (! * i) + !
        #@dashes.push(Graphic.new(x_pos, y_pos,"assets/dash.png"))
      #end
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
        #if (@numbers.length() < @code_length)
          #if (@bit_size == 3)
            #x_pos = (! * @numbers.length()) + !
            #y_pos = (! * @numbers.length()) + !
            #@numbers.push(Number.new("assets/#{button.value}.png",x_pos, y_pos)) 
          #if (@bit_size == 4)
            #x_pos = (! * @numbers.length()) + !
            #y_pos = (! * @numbers.length()) + ! 
            #@numbers.push(Number.new("assets/#{button.value}.png",x_pos, y_pos)) 
          #end
        #else
          #temp = Array.new
          #for number in @numbers
            #temp.push(number.value)
          #end
          #if temp.eql?(@code)
            #@goal_image = Gosu::Image.new("assets"/!)
            #@buttons.clear
          #else
            #@numbers.clear
          #end
        #end
      else
        button.unclick
     end
    end
  end

 def draw
    #for number in @numbers
      #number.draw
    #end
    for button in @buttons
      button.draw
    end
    if @bit_size == 3
      @example_3image.draw(0,500,1)
      @goal_image.draw(350,0,1)
    else
      @example_4image.draw(0,500,1)
      @goal_image.draw(450,0,1)
    end
    @cursor.draw
    @background_image.draw(0,0,0)
    @grid.draw
  end

end

meep = BinaryGame.new(3,3)
meep.show