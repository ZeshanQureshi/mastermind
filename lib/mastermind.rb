class Mastermind
  
  @@masterKey = -1

  @@computerGuesses = []

  @@numberGuesses = 0

  @@gameOver = false
  
  def initialize()
    initialInput = displayRules().to_i

    if initialInput === 0
      print "\n"
      computerChosenKey()

      while !@@gameOver and @@numberGuesses < 12
        checkPlayerGuess("C")
      end

      checkWin()
    else 
      print "\n"
      playerChosenKey()

      while !@@gameOver and @@numberGuesses < 12
        checkPlayerGuess("P")
      end  
      
      checkWin()
    end
  end

  def displayColouredText(num)
    colouredNumber = ""

    for i in 0..3
      numText = " " + num.to_s[i] + " "
      case num.to_s[i]
        when "1"
          colouredNumber += "\e[41m#{numText}\e[0m"
        when "2"
          colouredNumber += "\e[44m#{numText}\e[0m"
        when "3"
          colouredNumber += "\e[42m#{numText}\e[0m"
        when "4"
          colouredNumber += "\e[43m#{numText}\e[0m"
        when "5"
          colouredNumber += "\e[46m#{numText}\e[0m"
        when "6"
          colouredNumber += "\e[45m#{numText}\e[0m"
      end
    end

    puts colouredNumber

  end
  
  def displayRules()
    print "\nWelcome to Mastermind! \n \n"
    print "How To Play: \n"
    print " - You will have 12 guesses to try to crack the code \n"
    print " - Correct digit but incorrect position: ○ \n"
    print " - Correct digit and the correct position: • \n \n"
    puts "Input 0 to play as code breaker else press any other key. \n \n"
    return playerInputChoice = gets
  end

  def inputPlayerGuess()
    print "Enter four digits between 1 and 6 (you have #{12 - @@numberGuesses} guess remaining): "
    playerGuess = gets.to_i()

    while (playerGuess.to_s().count("1-6") != 4 and playerGuess.instance_of? Fixnum)
      print "Please enter four valid digits between 1 and 6 (you have #{12 - @@numberGuesses} guess remaining): "
      playerGuess = gets.to_i()
    end

    return playerGuess
  end

  def computerRandomGuess()
    if @@numberGuesses.to_i() == 0
      return 1111
    elsif @@numberGuesses.to_i() == 1
      return 2222
    elsif @@numberGuesses.to_i() == 2
      return 3333
    elsif @@numberGuesses.to_i() == 3
      return 4444
    elsif @@numberGuesses.to_i() == 4
      return 5555
    elsif @@numberGuesses.to_i() == 5
      return 6666
    else
      chosenKey = @@computerGuesses.shuffle 
      return chosenKey.join.to_i()
    end
  end

  def checkPlayerGuess(playMode)
    if playMode == "C"
      playerGuess = inputPlayerGuess()
    else
      playerGuess = computerRandomGuess()
    end

    displayColouredText(playerGuess)

    correctNumWrongPlace = 0
    correctNumCorrectPlace = 0

    for i in 0..3
      if playerGuess.to_s.include? @@masterKey.to_s[i]
        correctNumWrongPlace += 1
      end
    end

    for i in 0..3
      if @@masterKey.to_s[i] == playerGuess.to_s[i]
        correctNumCorrectPlace += 1
      end
    end

    correctString = ""
    closeString = ""
    for i in 0..(correctNumCorrectPlace - 1)
      correctString += "•"
    end

    for i in 0..(correctNumWrongPlace - correctNumCorrectPlace - 1)
      closeString += "○"
    end

    puts correctString + "" + closeString

    if playMode == "P" && @@numberGuesses < 6
      for i in 0..(correctString.count("•") - 1)
        @@computerGuesses.push(@@numberGuesses + 1)
      end
    end

    if correctString == "••••"
      @@gameOver = true
    end

    @@numberGuesses += 1

  end

  def playerChosenKey()
    print "Enter four digits between 1 and 6: "
    chosenKey = gets.to_i()

    while (chosenKey.to_s().count("1-6") != 4 and chosenKey.instance_of? Fixnum)
      print "Please enter four valid digits between 1 and 6: "
      chosenKey = gets.to_i()
    end

    @@masterKey = chosenKey.to_i

  end

  def computerChosenKey()
    chosenKey = ""
    
    for i in 0..3
      chosenKey += (1 + rand(6)).to_s
    end

    @@masterKey = chosenKey.to_i
  end

  def checkWin()
    if @@gameOver == true
      puts "The code has been cracked!"
    else
      puts "Time is up! Code has not been cracked!"
      puts "Code was #{@@masterKey}"
    end
  end

end

playGame = Mastermind.new()
