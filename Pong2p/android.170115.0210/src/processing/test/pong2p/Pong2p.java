package processing.test.pong2p;

import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Pong2p extends PApplet {

Ball ball;
Pad padL,padR;

public void setup() {
    
    background(51);
    ball = new Ball(width/2,height/2);
    padL = new Pad(40.0f);
    padR = new Pad(width - 40.0f);
}

public void draw() {
    showingStuff();
    movingStuff();
    collisions();
    showScore();
}

public void showingStuff() {
    background(51);
    ball.show();
    padL.show();
    padR.show();
}

public void movingStuff() {
    ball.move();
    if (mouseX < width/2)
        padL.move();
    if (mouseX > width/2)
        padR.move();
}

public void collisions() {
    ball.checkCollision(padL);
    ball.checkCollision(padR);
    ball.checkWallCollision();
    if (ball.checkWallCollisions() == -1) {
        padL.scoreInc();
        resetGame();
        ball.velocity.x = -20;
    }
    if (ball.checkWallCollisions() == 1) {
        padR.scoreInc();
        resetGame();
        ball.velocity.x = 20;

    }
}

public void showScore() {
    fill(255);
    // textMode(CENTER);
    int scoreL = padL.getScore();
    int scoreR = padR.getScore();
    String textToPrint = scoreL + "   " + scoreR;
    textSize(32);
    text(textToPrint, width/2 - 34.5f, height/2);
    strokeWeight(4);
    stroke(255);
    line(width/2,height,width/2,0);
}

public void resetGame() {
    ball = new Ball(width/2,height/2);
    padL.setPos(height/2 + padL.fat/2);
    padR.setPos(height/2 + padL.fat/2);
}
class Ball {

    private PVector location = new PVector();
    public PVector velocity = new PVector();

    public final float fat = 20;

    private int colorBall = color(255);

    public float getY() {
        return this.location.y;
    }

    public Ball(float _x, float _y) {
        this.location.x = _x;
        this.location.y = _y;

        this.velocity.x = 15;
        this.velocity.y = 0;
    }

    public void move() {
        this.location.add(this.velocity);
    }

    public void show() {
        fill (this.colorBall);
        ellipse (this.location.x, this.location.y, this.fat, this.fat);
    }

    public boolean colided(Pad _obj) {
        if (this.location.y <= _obj.location.y + _obj.h/2 &&
            this.location.y >= _obj.location.y - _obj.h/2 &&
            this.location.x == _obj.location.x) {
            return true;
        } else {
            return false;
        }
    }

    public void checkCollision(Pad _obj) {
        if (this.colided(_obj)) {
            this.velocity.x *= -1;
            float far = dist (this.location.x,this.location.y,_obj.location.x,_obj.location.y);
            if (this.location.y < _obj.location.y) {
                far *=-1;
            }
            if (far > 0) {
                this.velocity.y = map(far, 0, _obj.h, 0, 5);
            }
            if (far < 0) {
                this.velocity.y = map(far, -_obj.h, 0, 0, - 5);
            }
            // if (this.location.y < _obj.location.y + _obj.h / 2 )
            //     this.velocity.y = map(far, 0, _obj.h, 0, -5);
        }
    }

    public int checkWallCollisions() {
        if (this.location.x + fat / 2>= width ||
            this.location.x - fat / 2 <= 0) {
            this.velocity.x *= -1;
        }
        if (this.location.y + fat / 2>= height ||
            this.location.y - fat / 2<= 0) {
            this.velocity.y *= -1;
        }

        if (this.location.x - fat / 2<= 0) {
            return -1;
        }

        if (this.location.x + fat / 2 >= width) {
            return 1;
        }
        
        return 0;
    }
    public void checkWallCollision() {
        if (this.location.x + fat / 2>= width ||
            this.location.x - fat / 2 <= 0) {
            this.velocity.x *= -1;
        }
        if (this.location.y + fat / 2>= height ||
            this.location.y - fat / 2<= 0) {
            this.velocity.y *= -1;
        }
    }
}
class Pad {

    private int score = 0;

    private PVector location = new PVector(0,width/2);
    public final float fat = 20, h = height/5;

    public Pad (float _x) {
        this.location.x = _x;
    }
    
    public void setPos(float _y) {
        this.location.y = _y;
    }

    public void show() {
        fill(255);
        rectMode(CENTER);
        rect(this.location.x, this.location.y, this.fat, this.h);
    }

    private void locate(float _y) {

        if (this.location.y + this.h/2 >= height) {
            this.location.y -= 1;
        }
        else if (this.location.y - this.h/2 <= 0) {
            this.location.y += 1;
        }
        else this.location.y += _y;
    }

    public void move() {
        movePadUManually();
        movePadDManually();
    }

    private void movePadUManually() {
        if (mousePressed) {
            if (mouseY < height / 2) {
                this.locate(-15);
            }
        }
    }
    private void movePadDManually() {
        if (mousePressed) {
            if (mouseY > height / 2) {
                this.locate(15);
            }
        }
    }

    //public void AImove(Ball a) {
    //    if (a.getY() > this.location.y) {
    //        this.locate(+3);
    //    }
    //    if (a.getY() < this.location.y) {
    //        this.locate(-3);
    //    }
    //}
    
    

    public int getScore() { return score; }
    public void scoreInc() { score++; }
}
  public void settings() {  size(displayWidth, displayHeight); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Pong2p" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
