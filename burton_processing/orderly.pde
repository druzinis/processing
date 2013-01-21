int drawCircles(float dist, int number, float centre_x, float centre_y, boolean draw, String[] words, float[] num) {
  int sum = 0; 
  for (int i = 1; i <= number; i++) {
    int force = 0; 
    if (i > number - 5 && i < number) force = round((words.length - sum) / 5); 
    sum += drawCircle(dist, dist*i, centre_x, centre_y, draw, subset(words, sum, words.length-sum), subset(num,sum, num.length-sum), force);
  }
  return(sum);
}

int drawCircle(float dist, float r, float centre_x, float centre_y, boolean draw, String[] words, float[] num, int force) {
  int number = min(round(TWO_PI*r/dist), words.length);
  if (force != 0) number = force;
  float angle = TWO_PI / number;
  if (draw) {
    for  (int i = 0; i < number; i++) {
      
    fill(0, min(maxAlpha, (num[i] - fontMin) / (fontMax - fontMin) * (maxAlpha - minAlpha) + minAlpha));

    if (num[i] <= CaptionSize) {
      textFont(fontCaption, num[i]);
    } else if (num[i] <= SmTextSize) {
      textFont(fontSmText, num[i]);
    } else if (num[i] <= RegularSize) {
      textFont(fontRegular, num[i]);
    } else if (num[i] <= SubHeadSize) {
      textFont(fontSubHead, num[i]);
    } else textFont(fontRegular, num[i]); 
      
      text(words[i], sin(angle*i)*r + centre_x + random(triuksmas)-triuksmas/2, 
            cos(angle*i)*r + centre_y + random(triuksmas)-triuksmas/2);
    }  
  }
  return(number);
}

int drawGrid(float dist, float side, float centre_x, float centre_y, String[] words) {
  int number = round(side / dist);
  for (int i = 0; i <  number; i++) {
    for (int j = 0; j < number; j++) {
      text(words[i*number + j], i*dist + centre_x-side/2 + random(triuksmas)-triuksmas/2, j*dist + centre_y-side/2 + random(triuksmas)-triuksmas/2);
    }
  }
  return(round(pow(number, 2)));
}
