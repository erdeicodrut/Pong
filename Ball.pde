class Ball {

    private PVector location = new PVector();
    private PVector velocity = new PVector();

    public final float fat = 20;

    private color colorBall = color(255);

    public float getY() {
        return this.location.y;
    }

    public Ball(float _x, float _y) {
        this.location.x = _x;
        this.location.y = _y;

        this.velocity.x = 5;
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
            if (this.location.y > _obj.location.y + _obj.h / 2) {
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
