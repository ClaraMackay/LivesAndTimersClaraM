-- Title: LivesAndTimers
-- Name: Clara Mackay
-- Course: ICS2O/3C
-- This program...

----------------------------------------------------------------------

-- hide the status bar
display.setStatusBar(display.HiddenStatusBar)

-- sets the background colour
display.setDefault("background", 16/255, 35/255, 104/255)

-----------------------------------------------------------------
--LOCAL VARIABLES
-----------------------------------------------------------------

-- create local variables
local questionObject
local correctObject
local incorrectObject
local numericField 
local randomNumber1
local randomNumber2
local userAnswer
local correctAnswer

-- create more local variables
local incorrectObject
local pointsObject
local points = 0
local formula

-- variables for the timer
local totalSeconds = 5
local secondsLeft = 5
local clockText
local countDownTimer

local lives = 3 
local heart1 
local heart2
local heart3
local heart4

-----------------------------------------------------------------
--LOCAL FUNCTIONS
-----------------------------------------------------------------

local function UpdateTime()
	-- decrement the number of seconds
	secondsLeft = secondsLeft - 1

	-- display the number of seconds left in the clock object
	clockText.text = secondsLeft .. ""

	if (secondsLeft == 0 ) then 
		-- reset the number of seconds left 
		secondsLeft = totalSeconds 
		lives = lives - 1 

		-- ***IF THERE ARE NO NUMBERS LEFT, PLAY A LOSE SOUND, SHOW A 
		-- "YOU LOSE" IMAGE AND CANCEL THE TIMER, REMOVE THE THIRD 
		-- HEART BY  MAKING IT INVISIBLE
		if (lives == 4) then 
			heart4.isVisible = false 
		elseif (lives == 3) then 
			heart3.isVisible = false
		elseif (lives == 2) then 
			heart2.isVisible = false
		elseif (lives == 1) then 
			heart1.isVisible = false
		end

		--*** CALL THE FUNCTION TO ASK A NEW QUESTION

	end
end

-- function that calls the timer 
local function StartTimer()
	-- create a countdown timer that loops infinitely 
	countDownTimer = timer.performWithDelay(1000, UpdateTime, 0)
end

local function AskQuestion()

	-- generate 2 random nuymbers between a max. and a min. number
	randomNumber1 = math.random(10, 20)
	randomNumber2 = math.random(10, 20)

	-- randomizes formulas from addition to multiplication to subtraction

	formula = math.random(0, 2)

if (formula == 0) then

	correctAnswer = randomNumber1 + randomNumber2

	-- create question in text object
	questionObject.text = randomNumber1 .. "+" .. randomNumber2 .. "="

		elseif (formula == 1) then

				-- calculates the correct answer
				correctAnswer = randomNumber1 * randomNumber2

				-- creates question in text object 
				questionObject.text = randomNumber1 .. " x " .. randomNumber2 .. "="

					elseif (formula == 1) then

						-- calculates the correct answer
						correctAnswer = randomNumber1 - randomNumber2

						-- creates question in text object 
						questionObject.text = randomNumber1 .. " - " .. randomNumber2 .. "="

		end
	end


local function HideCorrect()
	correctObject.isVisible = false

	AskQuestion()

end

local function HideIncorrect()
	incorrectObject.isVisible = false

	AskQuestion()

end

local function Points()
	--keeps track of the points 
	points = points + 1 
	pointsObject.text = "points = " .. points

end

function NumericFieldListener( event )
	-- User begins editing "numericField"
	if (event.phase == "began") then

		--clear text field
		event.target.text = ""

		elseif event.phase == "submitted" then

			-- when the answer is submitted (enter key is pressed) set user input to user's answer
			userAnswer = tonumber(event.target.text)

			-- if the users answer and the correct answer are the same:
			if (userAnswer == correctAnswer) then
				correctObject.isVisible = true

				-- calls points function
				Points()

				-- call the HideCorrect function after 4 seconds
				timer.performWithDelay(4000, HideCorrect)

			else 
				incorrectObject.isVisible = true 

				timer.performWithDelay(4000, HideInorrect)

		end
	end
end



--------------------------------------------------------------------------------
--OBJECT CREATION
--------------------------------------------------------------------------------
-- create the lives to display on the screen
heart1 = display.newImageRect("Images/heart.png", 90, 90)
heart1.x = display.contentWidth * 7 / 8
heart1.y = display.contentHeight * 1 / 7

heart2 = display.newImageRect("Images/heart.png", 90, 90)
heart2.x = display.contentWidth * 6 / 8
heart2.y = display.contentHeight * 1 / 7

heart3 = display.newImageRect("Images/heart.png", 90, 90)
heart3.x = display.contentWidth * 5 / 8
heart3.y = display.contentHeight * 1 / 7

heart4 = display.newImageRect("Images/heart.png", 90, 90)
heart4.x = display.contentWidth * 4 / 8
heart4.y = display.contentHeight * 1 / 7

-- displays a question ands sets the colour 
questionObject = display.newText("", display.contentWidth/4, display.contentHeight/2, "Georgia", 80)
questionObject:setTextColor(255/255, 255/255, 255/255)
display.isVisible = true

-- create the correct text object and make it invisible 
correctObject = display.newText("Correct!", display.contentWidth/2, display.contentHeight*2/3, "Georgia", 80)
correctObject:setTextColor(255/255, 255/255, 255/255)
correctObject.isVisible = false

-- create the correct text object and make it invisible 
incorrectObject = display.newText("Incorrect.", display.contentWidth/2, display.contentHeight*2/3, "Georgia", 80)
incorrectObject:setTextColor(255/255, 255/255, 255/255)
incorrectObject.isVisible = false

-- displays numeber of points 
pointsObject = display.newText("Points = 0", 90, 60, "Georgia", 40)
pointsObject:setTextColor(255/255, 255/255, 255/255)
pointsObject.isVisible = true

-- create numeric field
numericField = native.newTextField(display.contentWidth/2, display.contentHeight/2, 170, 100)
numericField.inputType = "number"

-- add the event listener for the numeric field
numericField:addEventListener("userInput", NumericFieldListener)

-------------------------------------------------------------------------------
--FUNCTION CALLS
-------------------------------------------------------------------------------

-- call the function to ask the question
AskQuestion()