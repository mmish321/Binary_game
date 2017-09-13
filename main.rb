require 'gosu/all'
require_relative "iconcell"
require_relative "grid"
require_relative "cursor"
require_relative "numberbutton"
require_relative "number"
require_relative "graphic"
require "auto_click"

class BinaryGame < Gosu::Window
 
  def initialize(bit_size, code_length)
    @cursor = Cursor.new
    @bit_size = bit_size
    @code_length = code_length
    @background_image = Gosu::Image.new("assets/clouds.jpg", {})
    @goal_image = Gosu::Image.new("assets/bear&honey_400.png", {})
    @grid = CustomGrid.new(self, @bit_size, @code_length)
    @code = @grid.code
    @buttons = Array.new
    @example_3image = Gosu::Image.new("assets/example_400_400.png", {})
    @example_4image = Gosu::Image.new("assets/example_400_400.png", {})
    @numbers = Array.new
    @dashes = Array.new
    if (bit_size == 3) 
      super(1200, 800, false)
      for i in 0...8
        if i <=3
          @buttons.push(NumberButton.new(450+(i*200), 550, "assets/#{i}_100_blue.png", i))
        else
          @buttons.push(NumberButton.new(450 + ((i-4)*200), 700, "assets/#{i}_100_blue.png", i))
        end
      end
      for i in 0...4
        x_pos = (200* i) + 400
        y_pos = 450
        @dashes.push(Graphic.new(x_pos, y_pos,"assets/dash1.png"))
      end
      if code_length == 3
        @dashes.shift
      end
    end
    if (bit_size == 4) 
      super(1600, 800, false)
      for i in 0...16
        if i <=7
          @buttons.push(NumberButton.new(425+(i* 150), 525, "assets/#{i}_100_blue.png", i))
        else
          @buttons.push(NumberButton.new(425+((i-8)*150), 675, "assets/#{i}_100_blue.png", i))
        end
      end
       for i in 0...4
        x_pos = (200 * i) + 835
        y_pos = (390)
        @dashes.push(Graphic.new(x_pos, y_pos,"assets/dash1.png"))
      end
      if code_length == 3
        @dashes.shift
      end
    end 
  end
 
  def update
    if (Gosu::button_down? Gosu::MsLeft) then
      @cursor.click
    else
      @cursor.unclick
    end
    @cursor.change_x(mouse_x)
    @cursor.change_y(mouse_y)
    click = 0
    for button in @buttons
      if button.clicked_on?(@cursor) && (Gosu::button_down? Gosu::MsLeft) then
        button.clicked_on
      elsif button.clicked_on?(@cursor) && !(Gosu::button_down? Gosu::MsLeft) then
        button.unclick
        click +=1
      else
        button.unclick
     end
      if (click  == 1) 
        do_stuff(button)
      end
    end
    puts click
  end
 def do_stuff(button)
    if (@numbers.length() < @code_length)
      if (@bit_size == 3)
        x_pos = (200 * @numbers.length()) + 675
        y_pos = 400
        temp ="assets/" + button.value.to_s + "_blue_plain.png"
        @numbers.push(Number.new(x_pos, y_pos, temp, button.value)) 
      end
      if (@bit_size == 4)
        x_pos = (200* @numbers.length()) + 835
        y_pos = 380
        temp ="assets/" + button.value.to_s + "_blue_plain.png"
        @numbers.push(Number.new(x_pos, y_pos,temp,button.value)) 
      end
    else
      temp = Array.new
      for number in @numbers
        temp.push(number.value)
      end
      if temp.eql?(@code)
        @goal_image = Gosu::Image.new("assets/bear&honey_400_receiving.png",{})
        @buttons.clear
      else
        @numbers.clear
      end
    end
  end
 def draw
    for number in @numbers
      number.draw
    end
    for dash in @dashes
      dash.draw
    end
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