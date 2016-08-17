int num = 50;
int[] x = new int[num];
int[] y = new int[num];
int idx = 0;

void setup() {
  size(480, 480);
  noStroke();
  fill(255, 102);
}


void draw() {
  background(0);
  x[idx] = mouseX;
  y[idx] = mouseY;
  idx = (idx + 1) % num;
  for (int i = 0; i < num; i++) {
    int pos = (idx + i) % num;
    float r = i / 2.0;
    ellipse(x[pos], y[pos], r, r);
  }
}

void mouseDragged() {
}
