//  parametrai
float triuksmas = 5; 

void setup() {
  size(800, 800);
  background(51);
  noLoop();
  stroke(255, 255, 255);
}

void draw() {
  println("ispaisyta blyne " + drawCircles(10, 17, 200, 200)); 
  println("ispaisyta kvadrate " + drawGrid(10, 360, 600, 200));
  println("ispaisyta visiskai atsiktinai " + drawRandom(2000, 400, 600, 760, 380));
}

int drawCircles(float dist, int number, float centre_x, float centre_y) {
  int sum = 0; 
  for (int i = 1; i <= number; i++) {
    sum += drawCircle(dist, dist*i, centre_x, centre_y);
  }
  point(centre_x, centre_y);
  return(sum);
}

int drawCircle(float dist, float r, float centre_x, float centre_y) {
  int number = round(TWO_PI*r/dist);
  float angle = TWO_PI / number;
  for  (int i = 0; i < number; i++) {
//    point(sin(angle*i)*r + centre_x + random(1)*triuksmas-.5, cos(angle*i)*r + centre_y + random(1)*triuksmas-.5);
    point(sin(angle*i)*r + centre_x + random(triuksmas)-triuksmas/2, cos(angle*i)*r + centre_y + random(triuksmas)-triuksmas/2);
  }
  return(number);
}

int drawGrid(float dist, float side, float centre_x, float centre_y) {
  int number = round(side / dist);
  for (int i = 0; i <  number; i++) {
    for (int j = 0; j < number; j++) {
      point(i*dist + centre_x-side/2 + random(triuksmas)-triuksmas/2, j*dist + centre_y-side/2 + random(triuksmas)-triuksmas/2);
    }
  }
  return(round(pow(number, 2)));
}

int drawRandom(int num, float centre_x, float centre_y, float m_width, float m_height) {
  for (int i = 0; i < num; i++) {
    point(random(centre_x - m_width / 2, centre_x + m_width / 2), random(centre_y - m_height / 2, centre_y + m_height / 2));
  }
  return(num);
}
