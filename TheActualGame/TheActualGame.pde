Ball ball;
Pad padL,padR;

void setup() {
    size(500,500);
    background(51);
    ball = new Ball(width/2,height/2);
    padL = new Pad(40.0);
    padR = new Pad(width - 40.0);
}

void draw() {
    showingStuff();
    movingStuff();
    collisions();
}

void showingStuff() {
    background(51);
    ball.show();
    padL.show();
}

void movingStuff() {
    ball.move();
    padR.show();
    padL.move();
    padR.AImove(ball);
}

void collisions() {
    ball.checkCollision(padL);
    ball.checkCollision(padR);
    ball.checkWallCollision();
}

void showScore() {
    textMode(CENTER);
    int scoreL = padL.getScore();
    int scoreR = padR.getScore();
    String textToPrint = scoreL + " : " + scoreR;
    text(textToPrint, width/2, 30);
}