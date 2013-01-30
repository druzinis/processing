import processing.pdf.*;

PFont fontCaption = createFont(CaptionFont, 1);   
PFont fontSmText = createFont(SmTextFont, 1);  
PFont fontRegular = createFont(RegularFont, 1);  
PFont fontSubHead = createFont(SubHeadFont, 1);  
PFont fontDisplay = createFont(DisplayFont, 1);  

String[] words; 
float[] numOrig;
float[] num;
float[] numSpalva;
float iks; 
float ygrek;
float laipsnisSukimuisi;
float spindulys = aukstis / 2 - parastes;
float numi;
int[] strLength;

void setup() {
  noiseSeed(noiseSeed);
  randomSeed(randomSeed);
  hint(ENABLE_NATIVE_FONTS);
  size(int(round(plotis)), int(round(aukstis)), PDF, pavadinimas);
  background(255);
  stroke(remelioSpalva, remelioAlpha);
  strokeWeight(.25);
  noFill(); 
  rect(0, 0, plotis, aukstis);
  ellipse(plotis/2, aukstis/2, plotis - remelioParaste*2, aukstis - remelioParaste*2);
  noLoop();
  String[] lines = loadStrings(duomenys);
  int l = kiekZodziu==0 ? lines.length-1 : kiekZodziu; 
  num = new float[l];
  numOrig = new float[l];
  numSpalva = new float[l]; 
  words = new String[l];
  strLength = new int[l];
  if (colorMode == 'H') colorMode(HSB);
  textAlign(CENTER);

  for (int i = 1; i <= l; i++) {
    String[] piece = split(lines[i], '\t');
    numOrig[i-1] = float(piece[2]);
    num[i-1] = pow(float(piece[2]), laipsnis);  // laipsniai
    numSpalva[i-1] = pow(float(piece[2]), laipsnisSpalvai); 
    words[i-1] = piece[1];
    strLength[i-1] = piece[1].length();
  }
  
  float numMin = min(num);
  float numMax = max(num);
  
  float numSMin = min(numSpalva);
  float numSMax = max(numSpalva);
  
  int strLengthMax = max(strLength);
  
//  println("zodis  |  nuskaitytas dydis  |  perskaiciuotas dydis");

  for (int i = 0; i < num.length; i++) {  
//    if (verbose) print(String.format("%-30s %-5s", words[i], int(numOrig[i])) + "            ");
    if (verbose) print(words[i] + "  " + int(numOrig[i]) + "  ");
    
    if (manual) {
      switch(round(numOrig[i])) {
        case 1:
          if (size1min!=0) num[i] = random(size1min, size1max);
          break;
        case 2:
          if (size2min!=0) num[i] = random(size2min, size2max);
          break;
        case 3:
          if (size3min!=0) num[i] = random(size3min, size3max);
          break;
        case 4:
          if (size4min!=0) num[i] = random(size4min, size4max);
          break;
        case 5:
          if (size5min!=0) num[i] = random(size5min, size5max);
          break;
        case 6:
          if (size6min!=0) num[i] = random(size6min, size6max);
          break;
        case 7:
          if (size7min!=0) num[i] = random(size7min, size7max);
          break;
        case 8:
          if (size8min!=0) num[i] = random(size8min, size8max);
          break;
        case 9:
          if (size9min!=0) num[i] = random(size9min, size9max);
          break;
        case 10:
          if (size10min!=0) num[i] = random(size10min, size10max);
          break;
        default:
          numi = (num[i] - numMin) / ( numMax - numMin ) * (fontMax - fontMin) + fontMin; 
          num[i] = max(numi, size10max);
          break;
      }
    } else {
      num[i] = (num[i] - numMin) / ( numMax - numMin ) * (fontMax - fontMin) + fontMin; 
    }
        
    if (verbose) print(nfs(num[i], 0, 3) + ";  ");
    
    numSpalva[i] = numSpalva[i] - numSMin; 
    numSpalva[i] = numSpalva[i] / ( numSMax - numSMin ) * (maxAlpha - minAlpha); 
    numSpalva[i] = numSpalva[i] + minAlpha;
  }
}

void draw() {
    fill(0);
    if (orderly) {
      if (pieskRate) {
        float r = width - 2*parastes;
        float dist = r*(1 + sqrt(4*PI*num.length + 1))/(2*num.length)/2;
//        float dist = (r + sqrt(pow(r, 2)*(4*PI*num.length + 1)))/(2*num.length);
        int nwords = 0; 
        int ncircles = 1; 
         while (drawCircles(dist, ncircles, width/2, height/2, false, words, num) < num.length) ncircles++;
        println("\n\nratu " + ncircles + ", skersmuo " + dist*ncircles*2 + ", lapo krastine " + width + "\n"); 
        int drawn = drawCircles(dist, ncircles, width/2, height/2, true, words, num);
        if (verbose) println("\n" + drawn + " words drawn out of " + num.length);
      } else {
        int dist = floor(sqrt((width-parastes)*(height-parastes)/num.length));
        drawGrid(dist, width-2*parastes, width/2, height/2, words);
      }
    } else {
      
  for (int i = 0; i < num.length; i++) {
    
    float alph= (num[i] - fontMin) / (fontMax - fontMin) * (maxAlpha - minAlpha) + minAlpha;
    if (minAlpha < maxAlpha) alph = maxAlpha - alph;
    
    fill(0, alph);

    if (num[i] <= CaptionSize) {
      textFont(fontCaption, num[i]);
    } else if (num[i] <= SmTextSize) {
      textFont(fontSmText, num[i]);
    } else if (num[i] <= RegularSize) {
      textFont(fontRegular, num[i]);
    } else if (num[i] <= SubHeadSize) {
      textFont(fontSubHead, num[i]);
    } else textFont(fontRegular, num[i]); 
    
      if (pieskRate) {
        do {
          iks = random(-spindulys, spindulys);
          ygrek = random(-spindulys, spindulys);
        } while (dist(iks, ygrek, 0, 0) > spindulys);
        translate(plotis/2 + iks, aukstis/2 + ygrek);
        if (sukti) {
          laipsnisSukimuisi = random(0, 359);
          rotate(laipsnisSukimuisi);
        }
        text(words[i], 0, 0);
        if (sukti) rotate(-laipsnisSukimuisi);
        translate(-(plotis/2 + iks), -(aukstis/2 + ygrek));  
      } else {
        text(words[i], random(parastes, width-parastes), random(parastes, height-parastes));
      }
    }

  }
  exit();
}
