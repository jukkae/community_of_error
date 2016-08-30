enum Mode {
  CHOOSE, PERFORM;
}

static Mode mode;
ArrayList<String> texts;
int chosenTextIndex = 0;
int charIndex = 0;
int textSize = 32;
int delay = 100;
color normal = color(255, 255, 255);
color highlight = color(255, 255, 0);


void setup() {
  size(640, 640);
  textSize(textSize);
  mode = Mode.PERFORM;
  texts = new ArrayList<String>();
  texts.add("Hello, World!");
  texts.add("Another brick in the wall");
}

void draw() {
  switch(mode) {
    case CHOOSE:
      break;
    case PERFORM:
      drawPerform();
      break;
  }
}

void drawPerform() {
  String text = texts.get(chosenTextIndex);
  String t = text.substring(0, charIndex);
  String u = text.substring(charIndex);
  fill(highlight);
  text(t, 30, 30);
  float displacement = textWidth(t);
  fill(normal);
  text(u, (30 + displacement), 30);  
  
  delay(delay);
  if (charIndex < text.length()) charIndex++;
  else charIndex = 0;
}