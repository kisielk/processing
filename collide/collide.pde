Box b1;
Box b2;

void setup() {
  size(480, 480, P2D);
  b1 = new Box(40, 48);
  b1.setVelocity(2, 0);
  b2 = new Box(240, 40);
}

void draw() {
  background(200);
  rectMode(CENTER);
  b1.update();
  b2.update();
  if (b1.collidesWith(b2)) {
    b1.setColor(255, 0, 0); 
  } else {
    b1.setColor(255, 255, 255);
  }
  b1.draw();
  b2.draw();
}

class Box {
  PVector pos;
  PVector vel;
  color col;
  int sz;

  Box(float x, float y) {
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    col = color(255, 255, 255);
    sz = 20;
  }

  void update() {
    pos.add(vel);
  }

  void setVelocity(float x, float y) {
    vel = new PVector(x, y);
  }

  void setColor(int r, int g, int b) {
    col = color(r, g, b);
  }

  void draw() {
    rectMode(CENTER);
    fill(col, 127);
    rect(pos.x, pos.y, sz, sz);
  }

  boolean collidesWith(Box b) {
    float b1x = pos.x - sz / 2;
    float b1y = pos.y - sz / 2;
    float b1s = sz;
    float b2x = b.pos.x - b.sz / 2;
    float b2y = b.pos.y - b.sz / 2;
    float b2s = b.sz;

    return (
        b1x + b1s >= b2x &&
        b1y + b1s >= b2y &&
        b1x <= b2x + b2s &&
        b1y <= b2y + b2s
        );
  }
}
