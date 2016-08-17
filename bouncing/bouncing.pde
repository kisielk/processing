float gravity = 0.2;
int min_radius = 3;

class Ball {
  PVector pos;
  PVector vel;
  int radius;
  color col;
  float mass;

  Ball(PVector pos, PVector vel) {
    this(pos, vel, 5);
  }

  Ball(PVector pos, PVector vel, int radius) {
    this.pos = pos;
    this.vel = vel;
    this.radius = radius;
    this.col = color(random(255), random(255), random(255));
    this.mass = 4 * PI / 3 * radius;
  }

  void update(float g) {
    vel.y += g;
    pos.add(vel);
    if (pos.y > (height - radius)) {
      pos.y = height - radius;
      vel.y = -vel.y * 0.9;
    }
    if (pos.y < radius) {
      pos.y = radius;
      vel.y = -vel.y * 0.9;
    }
    if (pos.x > width - radius) {
      pos.x = width - radius;
      vel.x = -vel.x * 0.9;
    }
    if (pos.x < radius) {
      pos.x = radius;
      vel.x = -vel.x * 0.9;
    }
  }

  void draw() {
    int r2 = radius * 2;
    fill(col, 127);
    ellipse(pos.x, pos.y, r2, r2);
  }

  boolean finished() {
    return (pos.y == height - radius) && (abs(vel.y) < 0.1);
  }

  boolean collidesWith(Ball b) {
    return PVector.sub(pos, b.pos).mag() < (radius + b.radius);
  }

  void resolveCollision(Ball b) {
    PVector x = PVector.sub(b.pos, pos).normalize();

    PVector v1 = vel;
    float x1 = x.dot(v1);
    PVector v1x = PVector.mult(x, x1);
    PVector v1y = PVector.sub(v1, v1x);
    x.mult(-1);
    float m1 = mass;

    PVector v2 = b.vel;
    float x2 = x.dot(v2);
    PVector v2x = PVector.mult(x, x2);
    PVector v2y = PVector.sub(v2, v2x);
    float m2 = b.mass;

    float totalMass = m1 + m2;
    PVector newVel1 = PVector.mult(v1x, (m1 - m2) / totalMass).add(PVector.mult(v2x, (2.0 * m2) / totalMass)).add(v1y);
    PVector newVel2 = PVector.mult(v1x , (2.0 * m1) / totalMass).add(PVector.mult(v2x, (m2 - m1) / totalMass)).add(v2y);

    this.vel = newVel1;
    this.pos.add(this.vel);
    b.vel = newVel2;
    b.pos.add(b.vel);
  }

  /*
  void resolveCollision(Ball b) {
    PVector delta = PVector.sub(pos, b.pos);
    float d = delta.mag();
    PVector mtd = PVector.mult(delta, ((r - b.r) - d) / d);

    float im1 = 1 / mass;
    float im2 = 1 / b.mass;
    float tim = im1 + im2;

    pos.add(PVector.mult(mtd, im1 / tim));
    b.pos.add(PVector.mult(mtd, im2 / tim));

    PVector v = PVector.sub(vel, b.vel);
    float vn = v.dot(PVector.normalize(mtd));

    // Already moving away from each other
    if (vn > 0) return;

    float i =
  }
  */
}

ArrayList<Ball> balls = new ArrayList<Ball>();

void setup() {
  size(480, 480);
}

void draw() {
  background(204);
  for (int i = balls.size() - 1; i >= 0; i--) {
    Ball b = balls.get(i);
    if (b.finished()) {
      balls.remove(i);
    } else {
      b.update(gravity);
    }
  }

  for (int i = 0; i < balls.size() - 1; i++) {
    Ball b = balls.get(i);
    for (int j = i + 1; j < balls.size(); j++) {
      Ball b0 = balls.get(j);
      if (b.collidesWith(b0)) {
        b.resolveCollision(b0);
      }
    }
  }

  for (Ball b : balls) {
    b.draw();
  }
}

Ball newRandomBall() {
  int x = mouseX;
  int y = mouseY;
  int px = pmouseX;
  int py = pmouseY;
  return new Ball(new PVector(x, y), new PVector(x - px, y - py), int(min_radius + random(10)));
}

void mouseDragged() {
  Ball b = newRandomBall();
  balls.add(b);
}

void mouseClicked() {
  Ball b = newRandomBall();
  balls.add(b);
}
