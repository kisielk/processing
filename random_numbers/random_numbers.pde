float radius = 5;
int DONE_PAUSE = 15;

class Chaser {
  PVector pos;
  PVector next;
  PVector vel;

  Chaser(float x, float y) {
    pos = new PVector(x, y);
    next = pos;
    vel = new PVector(0, 0);
  }

  boolean Update() {
    pos.add(vel); 
    if (next.dist(pos) < 1.0) {
      vel = new PVector(0, 0); 
      return true;
    }
    return false;
  }

  void Draw(PGraphics p) {
    p.fill(0, 0);
    p.ellipse(next.x, next.y, radius * 2, radius * 2);
    p.stroke(40);
    p.fill(0, 128);
    p.ellipse(pos.x, pos.y, radius * 2, radius * 2);
  }

  float X() {
    return pos.x;
  }

  void SetNext(float x, float y) {
    this.next = new PVector(x, y);
    this.vel = new PVector(0, (next.y - pos.y) / 60);
  }
}

ArrayList<Chaser> chasers = new ArrayList<Chaser>();
int done_cycles = 0;
PGraphics pg;

void Init() {
  float x = radius * 2;
  while (x < width - radius * 2) {
    chasers.add(new Chaser(x, height / 2));
    x += radius * 4;
  }
}

void setup() {
  size(480, 480, P2D);
  pg = createGraphics(width, height);
  Init();
}

void draw() {
  pg.beginDraw();
  pg.background(255, 30);
  int done = 0;
  for (Chaser chaser : chasers) {
    if (chaser.Update()) {
      done++;
    }
    chaser.Draw(pg);
  }
  pg.endDraw();
  image(pg, 0, 0);

  if (done == chasers.size()) {
    done_cycles++;
    if (done_cycles == DONE_PAUSE) {
      for (Chaser chaser : chasers) {
        chaser.SetNext(chaser.X(), random(height/2) + height/4);  
      }
    }
  } else {
    done_cycles = 0;
  }
}

void mouseClicked() {
  chasers.clear();
  Init();
}
