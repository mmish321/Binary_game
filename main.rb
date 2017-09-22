require 'gosu/all'
require_relative "iconcell"
require_relative "grid"
require_relative "cursor"
require_relative "numberbutton"
require_relative "number"
require_relative "graphic"


class BinaryGame < Gosu::Window
 
  def initialize()
    super(1600,800,false, update_interval = 101)
    @change = false
    @cursor = Cursor.new
    @bit_size = 0
    self.caption = "Binary Game"
    @code_length = 0
    @font = Gosu::Font.new(75)
    @background_image = Gosu::Image.new("assets/clouds.jpg", {})
    @num = rand(0...2)
    if @num == 0
      @goal_image = Gosu::Image.new("assets/bear&honey_400.png", {})
    else
      @goal_image = Gosu::Image.new("assets/spencer&carrot_400.png", {})
    end
    @buttons = Array.new
    @example_image = Gosu::Image.new("assets/example_400_400.png", {})
    @numbers = Array.new
    @dashes = Array.new
    @correct = false
    @buttons.push(NumberButton.new(600,500, "assets/3_100_blue.png",3))
    @buttons.push(NumberButton.new(850,500, "assets/4_100_blue.png",4))
    @choices= Array.new
    @grid 
    @code
  end

 
  def update
    refresh
    if !@change
      change?
    end
    cursor_movement
    check_input
  end


 def draw
    draw_font
    draw_button
    draw_number
    draw_dash
    bit_size_display
    clear
    draw_grid
    @cursor.draw
    @background_image.draw(0,0,0)
  end

  private
    def draw_font
      if !@change && @choices.length == 0
        @font.draw("Binary Game", 650,0,1,1.0,1.0,0xff_000000)
        @font.draw("Bit size?", 650,300,1,1.0,1.0,0xff_000000)     
      end
      if !@change &&  @choices.length() == 1
        @font.draw("Binary Game", 650,0,1,1.0,1.0,0xff_000000)
         @font.draw("Code Length?",600,300,1,1.0,1.0,0xff_000000)
      end
    end
    def cursor_movement
      @cursor.click
      @cursor.change_x(mouse_x)
      @cursor.change_y(mouse_y)
    end

    def draw_grid
      if @change
        @grid.draw
      end
    end

    def draw_number
      for number in @numbers
       number.draw
     end
    end

    def draw_button
        for button in @buttons
          button.draw
        end
    end

    def draw_dash
      if @change 
        for dash in @dashes
          dash.draw
        end
      end
    end

    def bit_size_display
      if @bit_size == 3 && @change
        @example_image.draw(0,500,1)
        @goal_image.draw(360,0,1)
      end
      if @bit_size == 4 && @change
        @example_image.draw(0,500,1)
        @goal_image.draw(460,0,1)
      end
    end

    def clear
      if @buttons.length() != 0 && @numbers.length() > 0  && @numbers.length() == @code_length
        @numbers.clear
      end
    end

    def check_input
      if @change 
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
                x_pos =(200* @numbers.length()) + 1070
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
              if @num == 0
                @goal_image = Gosu::Image.new("assets/bear&honey_400_receiving.png",{})
              else
                @goal_image = Gosu::Image.new("assets/spencer&carrot_400_no_key.png", {})
              end
             
              @buttons.clear
              @correct = true
            end
          end
        end
      else
        for button in @buttons
          if button.click_on?(@cursor) && @cursor.click
            @choices.push(button.value)
          end
        end
      end
   end

   def change?
    if @choices.length() == 2
        @buttons.clear
        @bit_size = @choices[0]
        @code_length = @choices[1]
        @grid = CustomGrid.new(self, @bit_size, @code_length)
        @code = @grid.code
        @choices.clear
        @change = true
    end
    if (@bit_size == 3) 
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
      if @code_length == 3
        @dashes.shift
      end
    end
    if (@bit_size == 4) 
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
      if @code_length == 3
        @dashes.shift
      end    
    end
   end

   def refresh
      if @correct == true && (Gosu::button_down? Gosu::KbReturn)
        initialize
      end
      if  (Gosu::button_down? Gosu::KbEscape)
        close
      end
   end

end

meep = BinaryGame.new
meep.show
