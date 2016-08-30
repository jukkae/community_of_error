enum Mode {
  CHOOSE, PERFORM;
}

static Mode mode;
ArrayList<String> texts;
int chosenTextIndex = 0;

void setup() {
  size(640, 640);
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
  text(texts.get(chosenTextIndex), 30, 30);
}