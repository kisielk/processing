float gravity = 0.2;
int min_radius = 3;


class Ball {
  PVector pos;
  PVector vel;
  int radius;
  color col;
  float mass;
  float elasticity;

  Ball(PVector pos, PVector vel) {
    this(pos, vel, 5);
  }

  Ball(PVector pos, PVector vel, int radius) {
    this.pos = pos;
    this.vel = vel;
    this.radius = radius;
    this.col = color(random(255), random(255), random(255));
    this.mass = 4 * PI / 3 * radius;
    this.elasticity = random(0.5, 0.9);
  }

  void update(float g) {
    vel.y += g;
    pos.add(vel);
    if (pos.y > (height - radius)) {
      pos.y = height - radius;
      vel.y = -vel.y * elasticity;
    }
    if (pos.y < radius) {
      pos.y = radius;
      vel.y = -vel.y * elasticity;
    }
    if (pos.x > width - radius) {
      pos.x = width - radius;
      vel.x = -vel.x * elasticity;
    }
    if (pos.x < radius) {
      pos.x = radius;
      vel.x = -vel.x * elasticity;
    }
  }

  void draw(PGraphics g) {
    int r2 = radius * 2;
    g.fill(col, 127);
    g.ellipse(pos.x, pos.y, r2, r2);
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
}

ArrayList<Ball> balls = new ArrayList<Ball>();

PGraphics current;
PGraphics last;

void setup() {
  size(480, 480, P2D);
  current = createGraphics(width, height, P2D);
  current.beginDraw();
  current.clear();
  current.endDraw();
  last = createGraphics(width, height, P2D);
  last.beginDraw();
  last.clear();
  last.endDraw();
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

  current.beginDraw();
  current.clear();
  current.tint(255, 200);
  current.image(last, 0, 0);
  current.tint(255, 255);
  for (Ball b : balls) {
    b.draw(current);
  }
  current.endDraw();
  image(current, 0, 0);
  last = current;
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
