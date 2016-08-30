enum Mode {
  CHOOSE, PERFORM;
}

static Mode mode;
ArrayList<String> texts;
int chosenTextIndex = 1;
int currentLine = 0;
int charIndex = 0;
int textSize = 32;
int delay = 100;
color bg = color(0);
color normal = color(255, 255, 255);
color highlight = color(255, 255, 0);


void setup() {
  size(640, 640);
  background(bg);
  rectMode(CENTER);
  textSize(textSize);
  mode = Mode.CHOOSE;
  texts = new ArrayList<String>();
  texts.add("Hello, World!");
  texts.add("All in all it's just \nanother brick in the wall");
  texts.add("I was put in charge of the music playlist for my Grandfather's funeral, which consisted of quite beautiful classical and choir music selected by my Grandmother. I had everything set up in playlists on my Spotify account and felt a little nervous but prepared. I started to play the first playlist as people entered, but what I didn't realize is that the \"Up Next\" feature overrides the playlist feature, so instead of playing the next classical song in the playlist, my phone started to blare \"Born to Be Wild\". I heard it as I walked in and luckily cut it off, but not before I heard a few chuckles.");
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

  String text = texts.get(chosenTextIndex);
  text = getNextTwoLines(chosenTextIndex);
  String[] lines = split(text, "\n");
  String line1 = lines[0];
  String line2 = "";
  if (lines.length > 1) line2 = lines[1];
  drawLine(line1, charIndex, (height - 128));
  drawLine(line2, charIndex - (line1.length()), (height - 64));

  delay(delay);

  if (charIndex < text.length()) {
    if (currentLine == 0) {
      charIndex++;
    }
  } else {
    charIndex = 0;
    mode = Mode.CHOOSE;
  }
}

String getNextTwoLines(int index) {
  String text = texts.get(index);
  String t = "";
  String u = "";
  int i = 0;
  while((textWidth(t) < width - 64) && (i < text.length())) {
    t += text.charAt(i);
    i++;
  }
  while((textWidth(u) < width - 64) && (i < text.length())) {
    u += text.charAt(i);
    i++;
  }
  return t + "\n" + u;
}

void drawLine(String line, int charIndex, int yDis) {
  if (charIndex > line.length()-1) charIndex = line.length() - 1;
  if (charIndex < 0) charIndex = 0; 
  String t = line.substring(0, charIndex);
  String u = line.substring(charIndex);
  fill(highlight);
  text(t, 30, yDis);
  float displacement = textWidth(t);
  fill(normal);
  text(u, 30 + displacement, yDis);
}

void drawLogo() {
  //TODO placeholder for logo
  rect(width/2, height/2, 256, 256);
}

void drawChoose() {
  background(bg);
  text("Confession 0: press 0", 30, 64);
  text("Confession 1: press 1", 30, 128);
  text("Confession 2: press 2", 30, 192);
}

void keyTyped() {
  chosenTextIndex = Character.getNumericValue(key);
  mode = Mode.PERFORM;
}