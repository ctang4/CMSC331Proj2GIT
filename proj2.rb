require 'wx'
include Wx

class Proj2 < App
  
  def on_init
    
    backgroundColour = Colour.new(51, 51, 51)
    windowSize = Size.new(500, 400)
    @mainFrame = Frame.new(nil, 1, :title => 'Blockssssss', :size => windowSize)
    @mainFrame.set_background_colour(backgroundColour)
    
    mainSizer = BoxSizer.new(VERTICAL)
    
    logoSizer = BoxSizer.new(VERTICAL)
    @menuSizer = BoxSizer.new(VERTICAL)
    
    mainSizer.add(logoSizer, 0, ALIGN_CENTER, 2)
    mainSizer.add(@menuSizer, 0, ALIGN_CENTER, 2)
    
    logo = Bitmap.from_image(Image.new("images\\logo.jpg", BITMAP_TYPE_JPEG))
    
    logoButton = BitmapButton.new(@mainFrame, :bitmap => logo, :style => SUNKEN_BORDER) 
    logoSizer.add(logoButton, 0, ALIGN_CENTER, 2)
     
    displayMenu
    
    @mainFrame.set_sizer(mainSizer)
   
    @mainFrame.show()
    
  end
  
  def displayMenu
    
    #Make button graphics
    
    playButton = BitmapButton.new(@mainFrame, -1, 
      :bitmap => Bitmap.new("images\\buttonPlay.bmp"), :style => SUNKEN_BORDER)
    infoButton = BitmapButton.new(@mainFrame, -1, 
      :bitmap => Bitmap.new("images\\backupButton.bmp"), :style => SUNKEN_BORDER)
    quitButton = BitmapButton.new(@mainFrame, -1, 
      :bitmap => Bitmap.new("images\\buttonQuit.bmp"), :style => SUNKEN_BORDER)
    
    @menuSizer.insert_spacer(-1, 20)
    @menuSizer.add(playButton, 0, ALIGN_CENTER, 2)
    
    tempSizer = BoxSizer.new(VERTICAL)
    tempSizer.add(infoButton, 0, ALIGN_CENTER, 2) 
    tempSizer.add(quitButton, 0, ALIGN_CENTER, 2)
    tempSizer.insert_spacer(-1, 20)
    
    @menuSizer.add(tempSizer, 0, ALIGN_CENTER, 2)
    
    @mainFrame.evt_button(playButton.get_id) { 
      @menuSizer.show(false)
      @menuSizer.clear()
      @menuSizer.layout() 
      levelSelect }
    @mainFrame.evt_button(infoButton.get_id) { 
      @menuSizer.show(false)
      @menuSizer.clear()
      @menuSizer.layout()
      instructions }
    @mainFrame.evt_button(quitButton.get_id) { 
      @mainFrame.destroy() }
    
    @menuSizer.layout
    
  end

  def instructions
    
    keySizer = GridSizer.new(2)
    #Display game instructions. Make it graphical.
    wButton = StaticBitmap.new(@mainFrame, :label => Bitmap.new("images\\wkey.bmp")) 
    keySizer.add(wButton, 0, ALIGN_CENTER | ALIGN_CENTER_VERTICAL, 2)
    
    wLabel = StaticText.new(@mainFrame, :label => "Moves forward\n")
    wLabel.set_foreground_colour(Wx::RED)
    keySizer.add(wLabel, 0, ALIGN_LEFT | ALIGN_CENTER_VERTICAL, 2)
    
    sButton = StaticBitmap.new(@mainFrame, :label => Bitmap.new("images\\skey.bmp")) 
    keySizer.add(sButton, 0, ALIGN_CENTER | ALIGN_CENTER_VERTICAL, 2)
    
    sLabel = StaticText.new(@mainFrame, :label => "Moves backward")
    sLabel.set_foreground_colour(Wx::RED)
    keySizer.add(sLabel, 0, ALIGN_LEFT | ALIGN_CENTER_VERTICAL, 2)
        
    aButton = StaticBitmap.new(@mainFrame, :label => Bitmap.new("images\\akey.bmp")) 
    keySizer.add(aButton, 0, ALIGN_CENTER | ALIGN_CENTER_VERTICAL, 2)
    
    aLabel = StaticText.new(@mainFrame, :label => "Moves left")
    aLabel.set_foreground_colour(Wx::RED)
    keySizer.add(aLabel, 0, ALIGN_LEFT | ALIGN_CENTER_VERTICAL, 2)
    
    dButton = StaticBitmap.new(@mainFrame, :label => Bitmap.new("images\\dkey.bmp")) 
    keySizer.add(dButton, 0, ALIGN_CENTER | ALIGN_CENTER_VERTICAL, 2)
    
    dLabel = StaticText.new(@mainFrame, :label => "Moves right")
    dLabel.set_foreground_colour(Wx::RED)
    keySizer.add(dLabel, 0, ALIGN_LEFT | ALIGN_CENTER_VERTICAL, 2)
    
    qButton = StaticBitmap.new(@mainFrame, :label => Bitmap.new("images\\qkey.bmp")) 
    keySizer.add(qButton, 0, ALIGN_CENTER | ALIGN_CENTER_VERTICAL, 2)
    
    qLabel = StaticText.new(@mainFrame, :label => "Quits the game")
    qLabel.set_foreground_colour(Wx::RED)
    keySizer.add(qLabel, 0, ALIGN_LEFT | Wx::ALIGN_CENTER_VERTICAL, 2)
    
    eButton = StaticBitmap.new(@mainFrame, :label => Bitmap.new("images\\ekey.bmp")) 
    keySizer.add(eButton, 0, ALIGN_CENTER | ALIGN_CENTER_VERTICAL, 2)
    
    eLabel = StaticText.new(@mainFrame, :label => "Grabs the block to move it")
    eLabel.set_foreground_colour(Wx::RED)
    keySizer.add(eLabel, 0, ALIGN_LEFT | ALIGN_CENTER_VERTICAL, 2)
    
    rButton = StaticBitmap.new(@mainFrame, :label => Bitmap.new("images\\rkey.bmp")) 
    keySizer.add(rButton, 0, ALIGN_CENTER | ALIGN_CENTER_VERTICAL, 2)
    
    rLabel = StaticText.new(@mainFrame, :label => "Resets the level")
    rLabel.set_foreground_colour(Wx::RED)
    keySizer.add(rLabel, 0, ALIGN_LEFT | Wx::ALIGN_CENTER_VERTICAL, 2)
        
    #ADD PLAYER, BLOCK, AND GOAL TO INSTRUCTIONS!
    
    backButton = Button.new(@mainFrame, -1, "Back")
    
    @menuSizer.add(keySizer,0,ALIGN_CENTER,2)
    @menuSizer.add(backButton, 0, ALIGN_CENTER, 2)
    
    @mainFrame.evt_button(backButton.get_id) { 
      @menuSizer.show(false)
      @menuSizer.clear()
      @menuSizer.layout()
      displayMenu }
      
    @menuSizer.layout()    
  end
  
  def levelSelect
    
    levelList = Dir.entries("levels")
    levelList.delete_if {|x| x == "." || x == ".."}
          
    levelListBox = ListBox.new(@mainFrame)
    levelListBox.set(levelList)    
    
    selectButton = Button.new(@mainFrame, -1, "Select")
    backButton = Button.new(@mainFrame, -1, "Back")
    
    @menuSizer.add(levelListBox, 0, ALIGN_CENTER, 2)
    @menuSizer.add(selectButton, 0, ALIGN_CENTER, 2)
    @menuSizer.add(backButton, 0, ALIGN_CENTER, 2)
    
    #Launch game window
    @mainFrame.evt_button(selectButton.get_id) {
      level = levelListBox.get_selections()
      loadGame(levelListBox.get_string(level[0])) }
    @mainFrame.evt_button(backButton.get_id) { 
      @menuSizer.show(false)
      @menuSizer.clear()
      @menuSizer.layout()
      displayMenu }
      
    @menuSizer.layout

  end
  
  def loadGame(filename)
    
    file = File.open("levels\\" + filename, "r")
    
    #Testing to read levels
    data = File.read(file).split
    convertedData = ""
    @numCols = Integer(data[0])
    @numRows = Integer(data[1])

    #Remove Row and Column data
    data.delete_at(0)
    data.delete_at(0) 
    
    gameSize = Size.new(53 * @numCols, 49 * @numRows)
    @gameFrame = Frame.new(nil, 2, :title => filename, :size => gameSize)
   
    @mapGrid = GridSizer.new(@numRows, @numCols, 0, 0)
    
    indexToAdd = 0
    @spaceIndex = Array.new
      
    for i in data
      if i == "x"
        @mapGrid.add(StaticBitmap.new(@gameFrame, indexToAdd, 
          :label => Bitmap.new("images\\wallBrown.bmp")), 0, EXPAND)
        indexToAdd += 1
      elsif i == "o"
        @mapGrid.add(StaticBitmap.new(@gameFrame, indexToAdd, 
          :label => Bitmap.new("images\\basicSquare.bmp")), 0, EXPAND)
        @spaceIndex.push(indexToAdd)
        indexToAdd += 1
      elsif i == "1"
        @mapGrid.add(StaticBitmap.new(@gameFrame, indexToAdd, 
          :label => Bitmap.new("images\\walkDown.bmp")), 0, EXPAND)
        @playerIndex = indexToAdd
        indexToAdd += 1
      elsif i == "2"
        @mapGrid.add(StaticBitmap.new(@gameFrame, indexToAdd, 
          :label => Bitmap.new("images\\wallGreen.bmp")), 0, EXPAND)
        @blockIndex = indexToAdd
        indexToAdd += 1      
      elsif i == "3"
        @mapGrid.add(StaticBitmap.new(@gameFrame, indexToAdd, 
          :label => Bitmap.new("images\\goalSquare.bmp")), 0,  EXPAND)  
        @goalIndex = indexToAdd
        @spaceIndex.push(indexToAdd)
        indexToAdd += 1      
      end
    end
        
    @mapGrid.layout
    
    gameSizer = BoxSizer.new(VERTICAL)
    gameSizer.add(@mapGrid, 0, ALIGN_CENTER|ALIGN_CENTER_VERTICAL, 0)
    @gameFrame.set_sizer(gameSizer)
    @gameFrame.fit
    @gameFrame.set_background_colour(Colour.new(0, 0, 0))
    
    @gameFrame.show()
    
    playGame(filename)
    
  end
  
  def playGame(filename)
    
    playerFacing = "s"
    playerGrabbing = false

    @gameFrame.evt_key_down { |ev| 
      if ev.get_key_code() == 69 #E - Grab
        
        if playerGrabbing == true
          playerGrabbing = false   
        elsif playerFacing == "n"
          if @playerIndex - @numCols == @blockIndex
            playerGrabbing = true
          end
        elsif playerFacing == "e"
          if @playerIndex + 1 == @blockIndex
            playerGrabbing = true
          end
        elsif playerFacing == "s"
          if @playerIndex + @numCols == @blockIndex
            playerGrabbing = true
          end
        elsif playerFacing == "w"
          if @playerIndex - 1 == @blockIndex
            playerGrabbing = true
          end
        end
        
      elsif ev.get_key_code() == 65 #A - West
        
        if playerGrabbing == false
          spaceAhead = canMove?("w", 0)
          playerFacing = "w"
          if spaceAhead
            @mapGrid.get_item(@playerIndex - 1).get_window().
              set_bitmap(Bitmap.new("images\\walkLeft.bmp"))
            @mapGrid.get_item(@playerIndex).get_window().
              set_bitmap(Bitmap.new("images\\basicSquare.bmp"))
            @spaceIndex.delete(@playerIndex - 1)
            @spaceIndex.push(@playerIndex)
            @playerIndex = @playerIndex - 1
          else
            @mapGrid.get_item(@playerIndex).get_window().
              set_bitmap(Bitmap.new("images\\walkLeft.bmp"))
          end
        elsif playerGrabbing == true && playerFacing == "w"
          spaceAhead = canMove?("w", 1)
          if spaceAhead
            @mapGrid.get_item(@playerIndex - 1).get_window().
              set_bitmap(Bitmap.new("images\\walkLeft.bmp"))
            @mapGrid.get_item(@blockIndex - 1).get_window().
              set_bitmap(Bitmap.new("images\\wallGreen.bmp"))
            @mapGrid.get_item(@playerIndex).get_window().
              set_bitmap(Bitmap.new("images\\basicSquare.bmp"))
            @spaceIndex.delete(@blockIndex - 1)
            @spaceIndex.push(@playerIndex)
            @playerIndex = @playerIndex - 1
            @blockIndex = @blockIndex - 1
           end
        elsif playerGrabbing == true && playerFacing == "e"
          spaceAhead = canMove?("w", 0)
          if spaceAhead
            @mapGrid.get_item(@playerIndex - 1).get_window().
              set_bitmap(Bitmap.new("images\\walkRight.bmp"))
            @mapGrid.get_item(@blockIndex - 1).get_window().
              set_bitmap(Bitmap.new("images\\wallGreen.bmp"))
            @mapGrid.get_item(@blockIndex).get_window().
              set_bitmap(Bitmap.new("images\\basicSquare.bmp"))
            @spaceIndex.delete(@playerIndex - 1)
            @spaceIndex.push(@blockIndex)
            @playerIndex = @playerIndex - 1
            @blockIndex = @blockIndex - 1
          end
        end
        
      elsif ev.get_key_code() == 83 #S - South
        
        spaceAhead = canMove?("s", 0)
        
        if playerGrabbing == false
          playerFacing = "s"
          if spaceAhead
            @mapGrid.get_item(@playerIndex + @numCols).get_window().
              set_bitmap(Bitmap.new("images\\walkDown.bmp"))
            @mapGrid.get_item(@playerIndex).get_window().
              set_bitmap(Bitmap.new("images\\basicSquare.bmp"))
            @spaceIndex.delete(@playerIndex + @numCols)
            @spaceIndex.push(@playerIndex)
            @playerIndex = @playerIndex + @numCols
          else
            @mapGrid.get_item(@playerIndex).get_window().
              set_bitmap(Bitmap.new("images\\walkDown.bmp"))
          end
        elsif playerGrabbing == true && playerFacing == "s"
          spaceAhead = canMove?("s", 1)
          if spaceAhead
            @mapGrid.get_item(@playerIndex + @numCols).get_window().
              set_bitmap(Bitmap.new("images\\walkDown.bmp"))
            @mapGrid.get_item(@blockIndex + @numCols).get_window().
              set_bitmap(Bitmap.new("images\\wallGreen.bmp"))
            @mapGrid.get_item(@playerIndex).get_window().
              set_bitmap(Bitmap.new("images\\basicSquare.bmp"))
            @spaceIndex.delete(@blockIndex + @numCols)
            @spaceIndex.push(@playerIndex)
            @playerIndex = @playerIndex + @numCols
            @blockIndex = @blockIndex + @numCols
           end
        elsif playerGrabbing == true && playerFacing == "n"
          spaceAhead = canMove?("s", 0)
          if spaceAhead
            @mapGrid.get_item(@playerIndex + @numCols).get_window().
              set_bitmap(Bitmap.new("images\\walkUp.bmp"))
            @mapGrid.get_item(@blockIndex + @numCols).get_window().
              set_bitmap(Bitmap.new("images\\wallGreen.bmp"))
            @mapGrid.get_item(@blockIndex).get_window().
              set_bitmap(Bitmap.new("images\\basicSquare.bmp"))
            @spaceIndex.delete(@playerIndex + @numCols)
            @spaceIndex.push(@blockIndex)
            @playerIndex = @playerIndex + @numCols
            @blockIndex = @blockIndex + @numCols
          end 
        end
        
      elsif ev.get_key_code() == 68 #D - East
             
        if playerGrabbing == false
          spaceAhead = canMove?("e", 0)
          playerFacing = "e"
          if spaceAhead
            @mapGrid.get_item(@playerIndex + 1).get_window().
              set_bitmap(Bitmap.new("images\\walkRight.bmp"))
            @mapGrid.get_item(@playerIndex).get_window().
              set_bitmap(Bitmap.new("images\\basicSquare.bmp"))
            @spaceIndex.delete(@playerIndex + 1)
            @spaceIndex.push(@playerIndex)
            @playerIndex = @playerIndex + 1
          else
            @mapGrid.get_item(@playerIndex).get_window().
              set_bitmap(Bitmap.new("images\\walkRight.bmp"))
          end
        elsif playerGrabbing == true && playerFacing == "e"
          spaceAhead = canMove?("e", 1)
          if spaceAhead
            @mapGrid.get_item(@playerIndex + 1).get_window().
              set_bitmap(Bitmap.new("images\\walkRight.bmp"))
            @mapGrid.get_item(@blockIndex + 1).get_window().
              set_bitmap(Bitmap.new("images\\wallGreen.bmp"))
            @mapGrid.get_item(@playerIndex).get_window().
              set_bitmap(Bitmap.new("images\\basicSquare.bmp"))
            @spaceIndex.delete(@blockIndex + 1)
            @spaceIndex.push(@playerIndex)
            @playerIndex = @playerIndex + 1
            @blockIndex = @blockIndex + 1
           end
        elsif playerGrabbing == true && playerFacing == "w"
          spaceAhead = canMove?("e", 0)
          if spaceAhead
            @mapGrid.get_item(@playerIndex + 1).get_window().
              set_bitmap(Bitmap.new("images\\walkLeft.bmp"))
            @mapGrid.get_item(@blockIndex + 1).get_window().
              set_bitmap(Bitmap.new("images\\wallGreen.bmp"))
            @mapGrid.get_item(@blockIndex).get_window().
              set_bitmap(Bitmap.new("images\\basicSquare.bmp"))
            @spaceIndex.delete(@playerIndex + 1)
            @spaceIndex.push(@blockIndex)
            @playerIndex = @playerIndex + 1
            @blockIndex = @blockIndex + 1
          end 
        end
        
      elsif ev.get_key_code() == 87 #W - North
        
        if playerGrabbing == false
          spaceAhead = canMove?("n", 0)
          playerFacing = "n"
          if spaceAhead
            @mapGrid.get_item(@playerIndex - @numCols).get_window().
              set_bitmap(Bitmap.new("images\\walkUp.bmp"))
            @mapGrid.get_item(@playerIndex).get_window().
              set_bitmap(Bitmap.new("images\\basicSquare.bmp"))
            @spaceIndex.delete(@playerIndex - @numCols)
            @spaceIndex.push(@playerIndex)
            @playerIndex = @playerIndex - @numCols
          else
            @mapGrid.get_item(@playerIndex).get_window().
              set_bitmap(Bitmap.new("images\\walkUp.bmp"))
          end
        elsif playerGrabbing == true && playerFacing == "n"
          spaceAhead = canMove?("n", 1)
          if spaceAhead
            @mapGrid.get_item(@playerIndex - @numCols).get_window().
              set_bitmap(Bitmap.new("images\\walkUp.bmp"))
            @mapGrid.get_item(@blockIndex - @numCols).get_window().
              set_bitmap(Bitmap.new("images\\wallGreen.bmp"))
            @mapGrid.get_item(@playerIndex).get_window().
              set_bitmap(Bitmap.new("images\\basicSquare.bmp"))
            @spaceIndex.delete(@blockIndex - @numCols)
            @spaceIndex.push(@playerIndex)
            @playerIndex = @playerIndex - @numCols
            @blockIndex = @blockIndex - @numCols
           end
        elsif playerGrabbing == true && playerFacing == "s"
          spaceAhead = canMove?("n", 0)
          if spaceAhead
            @mapGrid.get_item(@playerIndex - @numCols).get_window().
              set_bitmap(Bitmap.new("images\\walkDown.bmp"))
            @mapGrid.get_item(@blockIndex - @numCols).get_window().
              set_bitmap(Bitmap.new("images\\wallGreen.bmp"))
            @mapGrid.get_item(@blockIndex).get_window().
              set_bitmap(Bitmap.new("images\\basicSquare.bmp"))
            @spaceIndex.delete(@playerIndex - @numCols)
            @spaceIndex.push(@blockIndex)
            @playerIndex = @playerIndex - @numCols
            @blockIndex = @blockIndex - @numCols
           end
         end
        
      elsif ev.get_key_code() == 81 #Q - Quit
        @gameFrame.destroy()
        
      elsif ev.get_key_code() == 82 #R - Reset
        @gameFrame.destroy()
        loadGame(filename)
        
      end }
      
  end
  
  def canMove?(direction, spaces)
    
    
    if direction == "n"
      
      if(@playerIndex - (@numCols + @numCols * spaces) < 0)
        return false
      else
        if @spaceIndex.include?(@playerIndex - (@numCols + @numCols * spaces)) == true
          return true
        else
          return false
        end
      end
      
    elsif direction == "e"
      
      if @spaceIndex.include?(@playerIndex + 1 + spaces) == true
        return true
      else
        return false
      end
      
    elsif direction == "s"
      
      if @spaceIndex.include?(@playerIndex + (@numCols + @numCols * spaces)) == true
        return true
      else
        return false
      end
      
    elsif direction == "w"

      if(@playerIndex - (1 + spaces) < 0)
        return false
      else
        if @spaceIndex.include?(@playerIndex - (1 + spaces)) == true
          return true
        else
          return false
        end
      end
      
    else
      return false
      
    end
  end
  
end

Proj2.new.main_loop