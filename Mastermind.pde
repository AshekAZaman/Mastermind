
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

/* ------------------------------------------ VARIABLES ----------------------------------------- */

int numGuesses = 0; // Stores the number of guesses in the game so far
String secretCode = ""; //Stores the secret code after being generated

/* ------------------------------------------ FUNCTIONS ----------------------------------------- */

int findColor(int xCoor, int yCoor) {
    
    /*
    * OBJECTIVE findColor()
    * This function will check if a given point is within one 
    * of the color selector rectangles. This function should accept 
    * the x and y coordinates of the point as parameters, and
    * should return a color value.
    * If the point is within a color selector:
    *    • concatenate the appropriate digit to the user’s guess, and
    *    • return the color value of that rectangle.
    * Otherwise, return a default color value of your choosing.
    *
    */    
    
    int colorNumber = 0;
    
    if (yCoor >= 0 && yCoor <= REACT_HEIGHT) {
        if (xCoor > (width / 12 + (0 * width / 8)) && xCoor < ((width / 12 + (5 * width / 8)) + REACT_WIDTH)) {
            for (int i = 0; i < NUM_COLORS; i++) {
                boolean validX = (xCoor >= (width / 12 + (i * width / 8)) && xCoor <= (width / 12 + (i * width / 8) + REACT_WIDTH));
                if (validX) {
                    colorNumber = i;
                }
            }
        }
    }
    
    return colorNumber;
}

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
    
    
} //displayNumGuess

void drawGrid() {
    
    /*
    * OBJECTIVE drawGrid()
    * Draws grid with 4 columns and 10 rows
    *
    */     
    stroke(WHITE);
    fill(BLACK);
    for (int i = 0; i < NUM_COLS; i++) {
        for (int j = 0; j < NUM_ROWS; j++) {
            rect(width / 4 + (i * GRID_WIDTH),(height - height / 4)   - (j * GRID_HEIGHT), GRID_WIDTH, GRID_HEIGHT);            
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
    
} //draw

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
    println(secretCode);
    
} //setup
