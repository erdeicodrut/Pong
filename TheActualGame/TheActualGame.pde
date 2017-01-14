Ball ball;
Pad padL,padR;

void setup() {
    size(displayWidth, displayHeight);
    background(51);
    ball = new Ball(width/2,height/2);
    padL = new Pad(40.0);
    padR = new Pad(width - 40.0);
}

void draw() {
    showingStuff();
    movingStuff();
    collisions();
    showScore();
}

void showingStuff() {
    background(51);
    ball.show();
    padL.show();
    padR.show();
}

void movingStuff() {
    ball.move();
    if (mouseX < width/2)
        padL.move();
    if (mouseX > width/2)
        padR.move();
}

void collisions() {
    ball.checkCollision(padL);
    ball.checkCollision(padR);
    ball.checkWallCollision();
    if (ball.checkWallCollisions() == -1) {
        padL.scoreInc();
        resetGame();
        ball.velocity.x = -5;
    }
    if (ball.checkWallCollisions() == 1) {
        padR.scoreInc();
        resetGame();
        ball.velocity.x = 5;

    }
}

void showScore() {
    fill(255);
    // textMode(CENTER);
    int scoreL = padL.getScore();
    int scoreR = padR.getScore();
    String textToPrint = scoreL + "   " + scoreR;
    textSize(32);
    text(textToPrint, width/2 - 34.5, height/2);
    strokeWeight(4);
    stroke(255);
    line(width/2,height,width/2,0);
}

void resetGame() {
    ball = new Ball(width/2,height/2);
}