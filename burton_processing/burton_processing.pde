/////////////////////////////////////////////////////////////////
// Settings
/////////////////////////////////////////////////////////////////

// Dydis
float plotis = 118 / 2.54 * 72;
float aukstis = 118 / 2.54 * 72;
//  pixels = x cm / 2.54cm/colį * 72 pixels/colis
float parastes = 5 / 2.54 * 72;

// Dydžių transformacija
float laipsnis = 0.2;
float laipsnisSpalvai = .5;

// Sukiniai
boolean sukti = false;

// Randomisation
boolean orderly = true; 
float triuksmas = 1 / 2.54 * 72; 

// Rate?
boolean pieskRate = true;

// Šriftai             
int fontMin = 50, fontMax = 100; 
int minAlpha = 255; 
/* nustato mažiausią teksto ryškumą
 0 - visiškai permatomas
 255 - nepermatomas */
int maxAlpha = 100;

float CaptionSize = 8.5; // nustato tikslų maksimalų 
                         // dydį šitam šriftui
String CaptionFont = "ArnoPro-Regular";

float SmTextSize = 10.9;
String SmTextFont = "ArnoPro-Regular";

float RegularSize = 14;
String RegularFont = "ArnoPro-Regular";

float SubHeadSize = 21.5;
String SubHeadFont = "ArnoPro-Regular";

String DisplayFont = "ArnoPro-Regular";

// Manual fontsizes
// jei sizeXmin=0, bys pritaikoma standartine transformacija;
// visi dydziai nustatomi ne mazesni nei size10max. 

float size1min = 1.5, size1max = 1.5;
float size2min = 3, size2max = 3;
float size3min = 3, size3max = 4;
float size4min = 4, size4max = 5;
float size5min = 5, size5max = 6;
float size6min = 7, size6max = 8.5;
float size7min = 9, size7max = 12;
float size8min = 12, size8max = 14;
float size9min = 14, size9max = 15;
float size10min = 15, size10max = 18;

// Input/Output
String duomenys =  "burton_all.txt";
String pavadinimas = "Burton_118x118_2-100pt_10px_0-2_25-200alpha_variantas1 bla.pdf";

// Rėmukas
int remelioSpalva = 200; 
int remelioAlpha = 255; 
float remelioParaste = 1 / 2.54 * 72;

// Profilaktika (ar spausdinti info i konsole?)
boolean verbose = true; 
int kiekZodziu = 250;
