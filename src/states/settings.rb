class SettingsState
    # Lägg till och ta bort skit

  def initialize(window)
    @window = window

    @vcr = Gosu::Font.new(@window, "res/vcr.ttf", 48)
    @nano = Gosu::Font.new(@window, "res/NANOTYPE.ttf", 36)

    @mouse = Gosu::Image.new("res/mouse.png")
    @car = Gosu::Image.load_tiles("res/cars.png", 24, 16)

    @music = Gosu::Song.new("res/The Endless.wav")

    @carPos = 0
    @toolTip = true

    @carID = 0

  #  @titleStr = @window.GetDialog(0)
  #  @startStr = @window.GetDialog(1)
  #  @exitStr = @window.GetDialog(2)

  end

  def Setup()
    @toolTip = true
  end

  def Update()
    # LOL, nuttin' here!
  end

  def Draw()

    # Draws white background using quad! (Hrmpf)
    Gosu::draw_quad(0, 0, 0xffffffff, 500, 0, 0xffffffff, 500, 500, 0xffffffff, 0, 500, 0xffffffff, 0)

    # Draws menu
    @vcr.draw("Pause", 10, 10, 0, 1, 1, 0xff_000000)
    @nano.draw("Continue", 60, 100, 0, 1, 1, 0xff_000000)
    @nano.draw("Quit to menu", 60, 150, 0, 1, 1, 0xff_000000)

    # Tooltip
    if @toolTip == true
      @nano.draw("(Arrow keys)", 10, 200, 0, 1, 1, 0xff_000000)
    end

    # Render car
    @car[@carID].draw(5, 105 + (50 * @carPos), 0, 2, 2)

    # Render cursor
    #@mouse.draw(@window.mouse_x, @window.mouse_y, 0, 2, 2)

  end

  def ButtonDown(id)

    # Moves car
    if id == 81 && @carPos == 0
      @carPos = 1
      GenerateCar()
    elsif id == 82 && @carPos == 1
      @carPos = 0
      GenerateCar()
    end
    if id == 82 or id == 81
      @toolTip = false
    end
    if id == 40
      if @carPos == 0
        @window.GetManager().ChangeState(6) # Continue game
      elsif @carPos == 1
        @window.GetManager().ChangeState(4) # Exiting game!
      end
    end
  end

  def GenerateCar()
    newNum = Random.rand(55)

    if newNum > 5 && newNum < 10 || newNum > 15 && newNum < 20 || newNum > 25 && newNum < 30 || newNum > 35 && newNum < 40 || newNum > 45 && newNum < 50
      newNum -= 4
    end

    @carID = newNum
  end
end
