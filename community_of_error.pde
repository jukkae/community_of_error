enum Mode {
  CHOOSE, PERFORM;
}

static Mode mode;
ArrayList<String> texts;
int chosenTextIndex = 1;
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
  texts.add("All in all it's just another brick in the wall");
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
  String t = text.substring(0, charIndex);
  String u = text.substring(charIndex);
  fill(highlight);
  text(t, 30, (height - 48));
  float displacement = textWidth(t);
  fill(normal);
  text(u, (30 + displacement), (height - 48));  
  
  delay(delay);
  if (charIndex < text.length()) charIndex++;
  else {
    charIndex = 0;
    mode = Mode.CHOOSE;
  }
}

void drawLogo() {
  //TODO placeholder for logo
  rect(width/2, height/2, 256, 256);
}

void drawChoose() {
  background(bg);
}

void keyTyped() {
  chosenTextIndex = Character.getNumericValue(key);
  mode = Mode.PERFORM;
}