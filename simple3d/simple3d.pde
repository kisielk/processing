void setup() {
  size(480, 480, P3D);
}

float xRotate = 0;
float yRotate = 0;
float boxSize = 100;
float boxMax = 150;
float boxMin = 50;
float boxDiff = 1;

void draw() {
  background(0);
  lights();
  pushMatrix();
  translate(width/2, height/2, 0);
  rotateX(xRotate);
  rotateY(yRotate);
  fill(200);
  stroke(0);
  box(boxSize);
  popMatrix();
  pushMatrix();
  translate(width/2, height/2, 0);
  noFill();
  stroke(255);
  rotateZ(15);
  rotateY(-2 * yRotate);
  rotateX(xRotate);
  sphere(200);
  popMatrix();

  xRotate += 0.01;
  yRotate += 0.01;
  boxSize += boxDiff;
  if (boxSize > boxMax || boxSize < boxMin) {
    boxDiff *= -1;
  }
}
