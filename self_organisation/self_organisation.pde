int num = 5;

float[][] coords = new float[num][2];

void setup() {
  size(400, 400);
  stroke(255, 255, 255);
  for (int i = 0; i < num; i++) {
    coords[i][0] = random(0, 400); 
    coords[i][1] = random(0, 400); 
  }
//  noLoop();
}
 
void draw() {
  background(0);
  for (int dot = 0; dot < num; dot++) {
    // need to calculate costs for nine pixels and set new coordinates
    float[][] costsAround = new float[3][3];
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        point(coords[dot][0], coords[dot][1]);
        costsAround[i][j] = totalCost(coords[dot][0] + i - 1, coords[dot][1] + j - 1, coords, num, dot);
        println(dot + " " + i + " " + j + " " + costsAround[i][j]);
      }
    }
    float minimum = min(min(costsAround[0]), min(costsAround[1]), min(costsAround[2]));
    println(minimum);
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (costsAround[i][j] == minimum) {
          coords[dot][0] += i - 1;
          coords[dot][1] += j - 1;
        }
      }
    }
  }
}

float cost(float own_x, float own_y, float other_x, float other_y) {
  float cost = 1 / (dist(own_x, own_y, other_x, other_y));
  return(cost);
}

float totalCost (float own_x, float own_y, float[][] coords, int num, int own_num) {
  float sum = 0; 
  for (int i = 0; i < num; i++) {
    if (i != own_num) sum += cost(own_x, own_y, coords[i][0], coords[i][1]);
  }
  sum += cost(own_x, own_y, 0, own_y) + cost(own_x, own_y, own_x, 0) + cost(own_x, own_y, width, own_y) + cost(own_x, own_y, own_y, height);
  return(sum);
}
