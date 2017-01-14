class Pad {

    private PVector location = new PVector(0,width/2);
    public final float fat = 20, h = 100;

    public Pad (float _x) {
        this.location.x = _x;
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
        if (keyPressed) {
            if (keyCode == UP) {
                this.locate(-3);
            }
        }
    }
    private void movePadDManually() {
        if (keyPressed) {
            if (keyCode == DOWN) {
                this.locate(3);
            }
        }
    }

    public void AImove(Ball a) {
        if (a.getY() > this.location.y) {
            this.locate(+3);
        }
        if (a.getY() < this.location.y) {
            this.locate(-3);
        }
    }
}
