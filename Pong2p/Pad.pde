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