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
    @goal_image = Gosu::Image.new("assets/bear&honey_400.png", {})
    @grid = CustomGrid.new(self, @bit_size, @code_length)
    @code = @grid.code
    @buttons = Array.new
    @example_3image = Gosu::Image.new("assets/example_400_400.png", {})
    @example_4image = Gosu::Image.new("assets/example_400_400.png", {})
    @numbers = Array.new
    @dashes = Array.new
    if (bit_size == 3) 
      super(1200, 800, false, update_interval = 101)
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
      super(1600, 800, false, update_interval = 108)
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
    @cursor.click
    @cursor.change_x(mouse_x)
    @cursor.change_y(mouse_y)
    for button in @buttons
      if (@numbers.length() < @code_length) && button.click_on?(@cursor) && @cursor.click
        if (@bit_size == 3)
          if (@code_length == 4)
            x_pos = (200 * @numbers.length()) + 428
            y_pos = 400
          else
            x_pos = (200 * @numbers.length()) + 650
            y_pos = 400
          end
          temp ="assets/" + button.value.to_s + "_blue_plain.png"
          @numbers.push(Number.new(x_pos, y_pos, temp, button.value)) 
        end
        if (@bit_size == 4)
          if (@code_length == 4)
            x_pos = (200* @numbers.length()) + 860
            y_pos = 350
          else
            x_pos =(200* @numbers.length()) + 1020
            y_pos = 350
          end
          temp ="assets/" + button.value.to_s + "_blue_plain.png"
          @numbers.push(Number.new(x_pos, y_pos,temp,button.value)) 
        end
      elsif @numbers.length() == @code_length
        equal = true
        for i in 0...@code_length
          if (@numbers[i].value != @code[i])
            equal = false
          end
        end
        if equal
          @goal_image = Gosu::Image.new("assets/bear&honey_400_receiving.png",{})
          @buttons.clear
        end
      end
    end
  end


 def draw
    for number in @numbers
      number.draw
    end
    if @buttons.length() != 0  && @numbers.length() == @code_length
      @numbers.clear
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

meep = BinaryGame.new(4,4)
meep.show