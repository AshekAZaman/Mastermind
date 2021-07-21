
/*
* ABOUT Mastermind is a code-breaking game in which one player chooses a code, and the other player
* tries to guess it. In this assignment, we’ll be creating a Mastermind game with the computer
* choosing the code. As the human player makes guesses, the computer will give feedback as to
* how close those guesses are. If you’re interested in learning more:
* https://en.wikipedia.org/wiki/Mastermind_(board_game)
*
*/

/* --------------------------------------- COLOR CONSTANTS -------------------------------------- */

final color RED = #FF0000, BLUE = #0000FF, GREEN = #00FF00 ,YELLOW = #FFFF00, ORANGE = #FFA500, PURPLE = #6A0DAD, BLACK = #000000,WHITE = #FFFFFF;

/* ------------------------------------------ CONSTANTS ----------------------------------------- */

final int REACT_HEIGHT = 50, REACT_WIDTH = 50;
final int NUM_COLORS = 6;
final int NUM_COLS = 4, NUM_ROWS = 12;
final int GRID_HEIGHT = 30, GRID_WIDTH = 30;
final int MESSAGE_HEIGHT = 50, MESSAGE_WIDTH = 220;
final int TOTAL_CELLS = NUM_ROWS * NUM_COLS;

/* ------------------------------------------ VARIABLES ----------------------------------------- */

int numGuesses = 0; // Stores the number of guesses in the game so far
String secretCode = ""; //Stores the secret code after being generated
int currentCell = 0; //Keep track of the current cell number and increment the variable each time a cell is colored in.
String userGuess = ""; // Store the number guessed by the user 
String hint = ""; // Store the hint after a guess
boolean gameOver = false; // true when game is over

/* ------------------------------------------ FUNCTIONS ----------------------------------------- */

boolean checkUserGuess(String guess) {
    
    /*
    * OBJECTIVE checkUserGuess()
    * This will check if the user’s guess of the secret 
    * code is correct. If the user has correctly guessed the
    * code this function should return true, otherwise return false.
    *
    */
    
    boolean matched = false;
    
    if (guess.equals(secretCode)) {
        matched = true;
        gameOver = true;
    }
    
    return matched;
} //checkUserGuess


void resetUserGuess() {
    
    /**
    * OBJECTIVE resetUserGuess()
    * Resetsthe user guess to empty string.
    *
    */
    
    userGuess = "";
    
} //resetUserGuess

void mousePressed() {
    
    /*
    * OBJECTIVE mousePressed()
    * In this function,it checks if the mouse was in one of the color selectors
    * (we have afunction for that!). If the mouse was in a color selector,it fills in the next 
    * available empty cell in the grid with the selected color.
    *
    */   
    
    if (gameOver!= true) {
        
        int colorChosen = findColor(mouseX, mouseY);
        color currentColor = RED;
        
        userGuess += "" + (colorChosen + 1);
        
        if (colorChosen == 0) {
            currentColor = RED;
        } else if (colorChosen ==  1) {
            currentColor = BLUE;
        } else if (colorChosen ==  2) {
            currentColor = GREEN;
        } else if (colorChosen == 3) {
            currentColor = YELLOW;
        } else if (colorChosen == 4) {
            currentColor = ORANGE;
        } else if (colorChosen == 5) {
            currentColor = PURPLE;
        }
        
        if (currentCell < TOTAL_CELLS) {
            if (userGuess.length() == secretCode.length()) {
                provideHint();
            }   
            
            changeColor(currentCell,currentColor);
        }
        
        currentCell++;    
        
        
        if (currentCell % secretCode.length()  ==  0) {                
            resetUserGuess();
            if (numGuesses < NUM_ROWS) {
                numGuesses++;
            }
        }
    } //if
    
} // mousePressed

void changeColor(int cellNumber,color cellColor) {
    
    /*
    * OBJECTIVE changeColor()
    * This function will change the color of one cell in the grid. 
    * This function should accept two parameters: the cell number, and the color.
    * Assume that the cells in the grid are numbered starting from the top left corner 
    * to the bottom right. This will draw the cell as a rectangle filled with the given color. 
    *
    */
    
    int currentSerial = 0;
    boolean colorChanged = false;
    
    while(colorChanged!= true) {
        for (int i = NUM_ROWS - 1; i >= 0 && colorChanged!= true; i--) {
            for (int j = 0; j < NUM_COLS  && colorChanged!= true; j++) {
                if (currentSerial == cellNumber) {
                    fill(cellColor);
                    rect(width / 4 + (j * GRID_WIDTH),(height - height / 4)   - (i * GRID_HEIGHT), GRID_WIDTH, GRID_HEIGHT);            
                    colorChanged = true;
                    drawHint((height - height / 4)   - (i * GRID_HEIGHT));
                } //if          
                currentSerial++;
            } //for
        } //for
    } //while
    
} //changeColor

int findColor(int xCoor,int yCoor) {
    
    /*
    * OBJECTIVE findColor()
    * This function will check if a given point is within one 
    * of the color selector rectangles.This function should accept 
    * the x and y coordinates of thepoint as parameters, and
    * should return a color value.
    * If the point is within a colorselector:
    *    • concatenate the appropriate digit to the user’s guess, and
    *    • return the color value ofthat rectangle.
    * Otherwise, return a default color value of your choosing i.e is RED.
    *
    */    
    
    int colorNumber = 0;
    boolean conditionY = yCoor >= 0 && yCoor <= REACT_HEIGHT;
    boolean conditionX = xCoor > (width / 12 + (0 * width / 8)) && xCoor < ((width / 12 + (5 * width / 8)) + REACT_WIDTH);
    
    if (conditionY && conditionX) {       
        for (int i = 0; i < NUM_COLORS; i++) {
            boolean validX = (xCoor >= (width / 12 + (i * width / 8)) && xCoor <= (width / 12 + (i * width / 8) + REACT_WIDTH));
            if (validX) {
                colorNumber = i;
            }
        }
    } else {
        colorNumber = 0;
    }
    
    
    return colorNumber;
} //findColor

void generateCode() {
    
    /*
    * OBJECTIVE generateCode()
    * Generates a secret code that is NUM_COLS digits long. 
    * The allowable digits in the secret code should be
    * 1 up to the number of color selectors on your canvas.
    *
    */  
    
    if (NUM_COLS < NUM_COLORS) {
        for (int i = 0; i < NUM_COLS; i++) {
            int radomNum = (int)random(1, NUM_COLORS);
            secretCode += "" + radomNum;
        }
    } //if
    else{
        println("Code generation failed!");
    }
    
} //generateCode

void displayNumGuess() {
    
    /*
    * OBJECTIVE displayNumGuess()
    * Displays the current number of
    * guesses the user has made
    *
    */ 
    
    String message = "Num guesses: " + numGuesses;
    fill(WHITE);
    rect(width / 2 + width / 100 ,height - height / 6,MESSAGE_WIDTH,MESSAGE_HEIGHT);
    textSize(25);   
    fill(BLACK);
    text(message, width / 2 + width / 100 , height - height / 10); 
    
    
} // displayNumGuess

void drawGrid() {
    
    /*
    * OBJECTIVE drawGrid()
    * Draws grid with 4 columns and 10 rows
    *
    */     
    stroke(WHITE);
    fill(BLACK);
    for (int i = 0; i < NUM_ROWS; i++) {
        for (int j = 0; j < NUM_COLS; j++) {
            rect(width / 4 + (j * GRID_WIDTH),(height - height / 4)   - (i * GRID_HEIGHT), GRID_WIDTH, GRID_HEIGHT);            
        } //for
    } //for  
    
} //drawGrid

void drawColorSelectors() {
    
    /*
    * OBJECTIVE drawColorSelectors()
    * 6 colorful rectangles in a
    * vertical line at the top of the canvas used as selectors
    *
    */ 
    
    for (int i = 0; i < NUM_COLORS; i++) {
        
        if (i == 0) {
            fill(RED);
        } else if (i == 1) {
            fill(BLUE);
        } else if (i == 2) {
            fill(GREEN);
        } else if (i == 3) {
            fill(YELLOW);
        } else if (i == 4) {
            fill(ORANGE);
        } else if (i == 5) {
            fill(PURPLE);
        }
        
        stroke(WHITE);
        rect(width / 12 + (i * width / 8), 0, REACT_HEIGHT, REACT_WIDTH);        
        
    } //for
    
} //drawColorSelectors

void draw() {
    
    /*
    * OBJECTIVE void draw() 
    * draw function for this program. 
    *
    */     
    
    displayNumGuess();   
    gameOver();
    
    
} //draw

void gameOver() {
    
    /*
    * OBJECTIVE gameOver()
    * the game ends (the user can not make
    * any more guesses) when either:
    *   •the correct code is guessed, or
    *   •the user runs out of guess/rows.
    *
    * This function draws a message to the canvas letting the player
    * know that they have won or lost. This message can be displayed
    * on top of everything else on the canvas.
    *
    */
    
    fill(WHITE);    
    textSize(25);   
    
    if (gameOver) {
        text("You're a Mastermind!", width / 2 - width / 4 , height / 2);         
    } else if (numGuesses >= NUM_ROWS) {
        text("You Lost!", width / 2 , height / 2 - height / 3);         
    }
    
} // gameOver

void setup() {
    
    /*
    * OBJECTIVE void setup() 
    * setup function for this program
    *
    */ 
    
    size(500,600);
    background(BLACK);
    drawColorSelectors();
    drawGrid();
    generateCode();
    println("The secretCode is: " + secretCode);    
    
} //setup

void drawHint(int yCoor) {
    
    /*
    * OBJECTIVE drawHint()
    * Draw the hint as text to the canvas near the row
    * containing the guess.
    *
    */
    
    if (userGuess.length() == secretCode.length()) {
        String message = hint;
        fill(WHITE);       
        textSize(GRID_WIDTH);     
        text(message, width / 2, yCoor + GRID_HEIGHT);       
        resetHint();        
    } //if
    
} //drawHint

void resetHint() {
    
    /*
    * OBJECTIVE resetHint()
    * reset the hint to the empty string
    *
    */
    
    hint = "";
    
} //resetHint

void provideHint() {
    
    /*
    * OBJECTIVE provideHint()
    * This will give the user some hints as to how close their 
    * guess is to the secret code. For each digit that the user has 
    * guessed correctly and in the correct position, the hint should be an ‘O’.
    * For each digit that the user has guessed correctly, but in
    * the wrong position, the hint should be an ‘X’.
    * If the user has not guessed any correct digits, the hint
    * should be a series of dashed lines.
    *
    */
    
    int correctGuess = 0;
    
    if (userGuess.length() == secretCode.length()) {
        for (int i = 0; i < secretCode.length(); i++) {
            if (secretCode.charAt(i) == userGuess.charAt(i)) {
                correctGuess++;
                hint += "O";
                
            } else {
                int counter = 0; boolean wrongPosition = false;
                
                while(counter < secretCode.length() && wrongPosition != true) {
                    if (userGuess.charAt(i) ==  secretCode.charAt(counter)) {
                        wrongPosition = true;
                    }
                    counter++;
                }
                
                if (wrongPosition) {
                    hint += "X";
                    correctGuess++;
                }
            }
        }
        
        if (correctGuess ==  0) {
            resetHint();
            for (int i = 0; i < secretCode.length(); i++) {
                hint += "-";
            }
        } else if (checkUserGuess(userGuess)) {
            resetHint();            
        }
    }
    
} //provideHint
