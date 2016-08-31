enum Mode {
  CHOOSE, PERFORM;
}

static Mode mode;
ArrayList<String> texts;
int chosenTextIndex;
int currentLine = 0;
int charIndex = 0;
int charSkip = 0;
int textSize = 32;
int delay = 20;
color bg = color(0);
color normal = color(255, 255, 255);
color highlight = color(255, 255, 0);

PImage logo;


void setup() {
  //size(640, 640);
  fullScreen();
  background(bg);
  rectMode(CENTER);
  textSize(textSize);
  mode = Mode.CHOOSE;
  
  texts = new ArrayList<String>();
  texts.add("I was unfaithful to my partner and that made me appreciate and respect my partner more, it made me not look too much at their defects, it made me spent more time together and I realised I deeply love my partner.");
  texts.add("I used to not clean my feet well when I was using the public swimming pool showers and that made me get a fungal infection, from then on when I shower I take special care in my feet and between my fingers, which made my health improve considerably.");
  texts.add("When I was 16 I was very rebellious, I was misbehaving all the time, so my mother decided to put me in a boarding school, at the beginning I hated it because I had to leave my city and my friends but then there I met loads of nice friends and I have wonderful memories of my time there in the boarding school.");
  texts.add("When I was young I was hanging out with the wrong people, I did stupid things, but I managed to get out of it and become a better person to the point of helping and volunteering in centres where they treat people with different kind of life problems.");
  texts.add("Once I lost my flight because I overslept so since then I’ve been very careful and I make sure I have at least two alarm clocks going when I have very important schedules.");
  texts.add("I was in a bad marriage with the wrong person but from that error I had two nice children.");
  texts.add("My error was to study photography, because I wasted a lot of time, but thanks to it I went to USA and discovered making porcelain.");
  texts.add("I didn’t like someone at the beginning when we met for the first time but in the end we became the best friends.");
  texts.add("I lied to my father when I was a teenager and the next day I thought I needed to tell him the truth, he didn’t like what I said to him but from then on he started to treat me as an adult and respect my decisions.");
  texts.add("I got a book by mistake from the library and then I discovered a new author that I really like now.");
  
  //TODO ok gifs won't work
  logo = loadImage("logo.png");
}

void draw() {
  switch(mode) {
  case CHOOSE:
    drawChoose();
    break;
  case PERFORM:
    drawPerform();
    break;
  }
}

void drawPerform() {
  background(bg);
  drawLogo();

  drawTwoLines(charSkip);

  if (charIndex < texts.get(chosenTextIndex).length()) {
    charIndex++;
    if ((charIndex) > (getNextTwoLines(chosenTextIndex, charSkip).length())) {
      charSkip += (charIndex - 2); //TODO why???
      charIndex = 0;
    }
  }
  if (charIndex + charSkip >= texts.get(chosenTextIndex).length()) {
    charIndex = 0;
    charSkip = 0;
    mode = Mode.CHOOSE;
  }
}

void drawTwoLines(int i) {

  String text = getNextTwoLines(chosenTextIndex, i);
  String[] lines = split(text, "\n");
  String line1 = lines[0];
  String line2 = "";
  if (lines.length > 1) line2 = lines[1];
  drawLine(line1, charIndex, (height - 128));
  drawLine(line2, charIndex - (line1.length()), (height - 64));

  delay(delay);
}

void drawLine(String line, int charIndex, int yDis) {
  if (charIndex > line.length()-1) charIndex = line.length() - 1;
  if (charIndex < 0) charIndex = 0; 
  String t = line.substring(0, charIndex);
  String u = line.substring(charIndex);
  fill(highlight);
  text(t, 64, yDis);
  float displacement = textWidth(t);
  fill(normal);
  text(u, 64 + displacement, yDis);
}

String getNextTwoLines(int textIndex, int startIndex) {
  String text = texts.get(textIndex);
  String t = "";
  String u = "";
  int i = startIndex;
  while ((textWidth(t) < width - 128) && (i < text.length())) {
    if (text.charAt(i) == '\n' && (trim(t).length() > 0)) {
      i++;
      break;
    }
    if (text.charAt(i) == ' ' || text.charAt(i) == '\n') {
      if (trim(t).length() > 0) t += text.charAt(i);
    } else t+= text.charAt(i);
    i++;
  }
  while ((textWidth(u) < width - 128) && (i < text.length())) {
    if (text.charAt(i) == '\n') {
      i++;
      break;
    }
    u += text.charAt(i);
    i++;
  }
  return t + "\n" + u;
}

void drawLogo() {
  //TODO placeholder for logo
  //rect(width/2, height/2, 256, 256);
  image(logo, width/2 - 128, height/2 - 128, 256, 256);
}

void drawChoose() {
  background(bg);
  for (int i = 0; i < texts.size(); i++) {
    text("Confession " + (i+1) + ": press " + ((i+1)%10), 30, 32 + (i*64));
  }
}

void keyTyped() {
  chosenTextIndex = Character.getNumericValue(key);
  mode = Mode.PERFORM;
}