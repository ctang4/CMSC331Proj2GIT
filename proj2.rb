require 'wx'
include Wx

class Proj2 < App
  
  def on_init
    
    backgroundColour = Colour.new(51, 51, 51)
    windowSize = Size.new(500, 400)
    @mainFrame = Frame.new(nil, :title => 'Blockssssss', :size => windowSize)
    @mainFrame.set_background_colour(backgroundColour)
    
    mainSizer = BoxSizer.new(VERTICAL)
    
    logoSizer = BoxSizer.new(VERTICAL)
    @menuSizer = BoxSizer.new(VERTICAL)
    
    mainSizer.add(logoSizer, 0, ALIGN_CENTER, 2)
    mainSizer.add(@menuSizer, 0, ALIGN_CENTER, 2)
    
    #Ask about drawing!!
    logo = Bitmap.from_image(Image.new("images\\logo.jpg", BITMAP_TYPE_JPEG))
    #@mainFrame.paint {
    #  |dc|
    #  dc.draw_bitmap(logo, 10, 10, false) }
    
    #Prefered method of displaying images, imo
    logoButton = BitmapButton.new(@mainFrame, :bitmap => logo, :style => SUNKEN_BORDER) 
    logoSizer.add(logoButton, 0, ALIGN_CENTER, 2)
     
    displayMenu
    
    @mainFrame.set_sizer(mainSizer)
   
    @mainFrame.show()
    
  end
  
  def displayMenu
    
    #Make button graphics
    playButton = Button.new(@mainFrame, -1, "Play")
    infoButton = Button.new(@mainFrame, -1, "Instructions")
    quitButton = Button.new(@mainFrame, -1, "Quit")
    
    @menuSizer.add(playButton, 0, ALIGN_CENTER, 2)
    @menuSizer.add(infoButton, 0, ALIGN_CENTER, 2)  
    @menuSizer.add(quitButton, 0, ALIGN_CENTER, 2)
    
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
    
    #Display game instructions. Make it graphical.
    
    backButton = Button.new(@mainFrame, -1, "Back")
    
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
    playGame(levelListBox.get_string(level[0])) }
    @mainFrame.evt_button(backButton.get_id) { 
      @menuSizer.show(false)
      @menuSizer.clear()
      @menuSizer.layout()
      displayMenu }
      
    @menuSizer.layout

  end
  
  def playGame(filename)
    file = File.open("levels\\" + filename, "r")
    puts(filename)
    
    #Testing to read levels
    puts(File.read(file))
    data = File.read(file).split("")
    convertedData = ""
    
    for i in data
      if i == "x"
        convertedData.concat("W")
      elsif i == "o"
        convertedData.concat("F")
      elsif i == "1"
        convertedData.concat("P")
      elsif i == "2"
        convertedData.concat("B")
      elsif i == "3"
        convertedData.concat("G")
      else
        convertedData.concat(i)
      end
    end
    
    puts(convertedData)
    
  end
  
end

Proj2.new.main_loop