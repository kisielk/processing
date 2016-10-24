import megamu.mesh.*;
import processing.pdf.*;

float[][] points = new float[900][2];

color[] colors = {
  color(255, 255, 178),
  color(254, 217, 118),
  color(254, 178, 76),
  color(253, 141, 60),
  color(240, 59, 32),
  color(189, 0, 38),
};

void setup() {
  size(640, 960, PDF, "amberstatis.pdf");
  smooth(4);
  for (float[] point : points) {
     point[0] = random(width);
     point[1] = random(height);
  }
}

void strokeText(String msg, int x, int y) {
  int r = 2;
  fill(0);
  text(msg, x-r, y);
  text(msg, x, y-r);
  text(msg, x+r, y);
  text(msg, x, y+r);
  fill(255);
  text(msg, x, y);
}

void draw() {
  Voronoi myVoronoi = new Voronoi( points );
  MPolygon[] regions = myVoronoi.getRegions();
  stroke(0x77);
  strokeWeight(2);
  for (int i = 0; i < regions.length; i++) {
    float range = (min(dist(width, height, points[i][0], points[i][1]), width) / width) * colors.length - 1;
    color c = colors[colors.length - 1 - int(range)];
    fill(c);
    regions[i].draw(this);
  }
  textSize(180);
  textLeading(textDescent() * 4);
  strokeText("amber\nstasis", 10, 160);

  exit();
}