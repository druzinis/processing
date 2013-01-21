import processing.pdf.*;

PFont fontCaption = createFont(CaptionFont, 1);   
PFont fontSmText = createFont(SmTextFont, 1);  
PFont fontRegular = createFont(RegularFont, 1);  
PFont fontSubHead = createFont(SubHeadFont, 1);  
PFont fontDisplay = createFont(DisplayFont, 1);  

String[] words; 
float[] num;
float[] numSpalva;
float iks; 
float ygrek;
float laipsnisSukimuisi;
float spindulys = aukstis / 2 - parastes;

void setup() 
{  
  hint(ENABLE_NATIVE_FONTS);
  size(int(round(plotis)), int(round(aukstis)), PDF, pavadinimas);
  background(255);
  stroke(remelioSpalva, remelioAlpha);
  strokeWeight(.25);
  noFill(); 
  rect(0, 0, plotis, aukstis);
  ellipse(plotis/2, aukstis/2, plotis, aukstis);
  noLoop();
  String[] lines = loadStrings(duomenys);
  int l = kiekZodziu;
  if (kiekZodziu==0) {l = lines.length-1;}; 
  num = new float[l];
  numSpalva = new float[l]; 
  words = new String[l];

  textAlign(CENTER);

  for (int i = 1; i <= l; i++) {
    String[] piece = split(lines[i], '\t');
    num[i-1] = pow(float(piece[2]), laipsnis);  // laipsniai
    numSpalva[i-1] = pow(float(piece[2]), laipsnisSpalvai); 
    words[i-1] = piece[1];
  }
  
  float numMin = min(num);
  float numMax = max(num);
  
  float numSMin = min(numSpalva);
  float numSMax = max(numSpalva);

  for (int i = 0; i < num.length; i++) {  
    num[i] = num[i] - numMin; 
    num[i] = num[i] / ( numMax - numMin ) * (fontMax - fontMin); 
    num[i] = num[i] + fontMin;
    
    if (verbose) print(words[i] + " " + num[i] + "; ");
    
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
         while (drawCircles(dist, ncircles, width/2, height/2, false, words, num) < num.length) {
          println("bandom ratus: " + ncircles);
          ncircles++;
        }
        println("tiek ratu " + ncircles + " ir toks skersmuo " + dist*ncircles*2 + " and width " + width); 
        int drawn = drawCircles(dist, ncircles, width/2, height/2, true, words, num);
        if (verbose) println(drawn + " words drawn out of " + num.length);
      } else {
        int dist = floor(sqrt((width-parastes)*(height-parastes)/num.length));
        drawGrid(dist, width-2*parastes, width/2, height/2, words);
      }
    } else {
      
  for (int i = 0; i < num.length; i++) {
    
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
  println("done");
}
