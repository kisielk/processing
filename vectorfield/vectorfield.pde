void setup() {
  size(480, 480, P2D);
  smooth(4);
}

int boxSize = 20;
float vectorLen = boxSize - 4;

void draw() {
  background(200);
  PVector mouse = new PVector(mouseX, mouseY);
  rectMode(CENTER);
  stroke(0);
  for (int x = boxSize / 2; x < width; x += boxSize) {
    for (int y = boxSize / 2;  y < height; y += boxSize) {
      PVector p = new PVector(x, y);
      PVector diff = PVector.sub(p, mouse).normalize().mult(vectorLen / 2);
      PVector p0 = PVector.sub(p, diff);
      PVector p1 = PVector.add(p, diff);
      line(p0.x, p0.y, p1.x, p1.y);
    }
  }
}
