
class CustomGrid < Gosu::Grid 
  def initialize(window, bit_size, code_length )
    super(window)
    @code = Array.new
    @bit_size = bit_size
    @code_length = code_length
    gridAssembly(@bit_size, @code_length)
  end

  def gridAssembly( bit_size, code_length)
    main_grid = Array.new
    if (bit_size == 3)
     @cells.push(IconCell.new(self,0,0,'assets/4_100.png'))
     @cells.push(IconCell.new(self,1,0,'assets/2_100.png'))
     @cells.push(IconCell.new(self,2,0,'assets/1_100.png'))
    else
     @cells.push(IconCell.new(self,0,0,'assets/8_100.png')) 
     @cells.push(IconCell.new(self,1,0,'assets/4_100.png'))
     @cells.push(IconCell.new(self,2,0,'assets/2_100.png'))
     @cells.push(IconCell.new(self,3,0,'assets/1_100.png'))

    end
    
    for i in 0..(code_length - 1)
      if (bit_size == 3) 
        r = rand(0...7);
        main_grid.push(three_bit(r));
      else
        r= rand(0...15);
        main_grid.push(four_bit(r));
      end
      @code.push(r);
    end

    for i in 0..(main_grid.length() -1)
      for j in 0..(main_grid[i].length() -1)
        if (main_grid[i][j] == 0)
          @cells.push(IconCell.new(self,j,i +1, 'assets/empty_cell_100.png'))
        end
        if (main_grid[i][j] == 1)
          @cells.push(IconCell.new(self,j,i + 1, 'assets/star100.png'))
        end
      end
    end
  end


  def three_bit(n)
    all_three = [
    [0,0,0],
    [0,0,1],
    [0,1,0],
    [0,1,1],
    [1,0,0],
    [1,0,1],
    [1,1,0],
    [1,1,1]
    ]
    return all_three[n];
  end 

  def four_bit (n)
    all_four = [
    [0,0,0,0],
    [0,0,0,1],
    [0,0,1,0],
    [0,0,1,1],
    [0,1,0,0],
    [0,1,0,1],
    [0,1,1,0],
    [0,1,1,1],
    [1,0,0,0],
    [1,0,0,1],
    [1,0,1,0],
    [1,0,1,1],
    [1,1,0,0],
    [1,1,0,1],
    [1,1,1,0],
    [1,1,1,1]
    ]
    return all_four[n];
  end

  def draw
    @cells.each do |cell|
      cell.draw
    end
  end
  def code
    @code
  end

end