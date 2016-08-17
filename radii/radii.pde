void setup() {
  size(480, 480);
}

void draw() {
  background(0);
  stroke(255);
  int x0 = width/2;
  int y0 = height/2;
  translate(x0, y0);
  int rotation = mouseX;
  float rscale = ((mouseY + 1) * 10) / height;
  for (int i = 0; i < 360; i += 6) {
    pushMatrix();
    rotate(radians(i + rotation));
    line(0, 0, 0, i / rscale); 
    popMatrix();
  }
}
