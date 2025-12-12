Table table;

int columns = 10;
int rows = 10;
int cellW, cellH;

color furColour;

void setup() {
  size(800, 600);
  table = loadTable("Dear Data Meow Database.csv", "header");
  cellW = width / columns;
  cellH = height / rows;
  println("Rows loaded: " + table.getRowCount());
}

void draw() {
  background(255);
  int i = 0;
  for (TableRow row : table.rows()) {

    String catName = row.getString("Cat");
    int day = row.getInt("Day of Observation");
    String time = row.getString("Time of day of meow");
    String location = row.getString("Location of meow");
    String length = row.getString("Length of meow");
    String reason = row.getString("Reason?");

    int column = i % columns;
    int rowIndex = i / columns;
    int x = column * cellW + cellW/2;
    int y = rowIndex * cellH + cellH/2;

    // Position cats by day and index
    //  int x = 100 + (day * 100);
    //  int y = 100 + (i * 60 % height);

    drawCat(x, y+20, day, time, location, length, reason, catName);

    i++;
  }
}

void drawCat(int x, int y, int day, String time, String location, String length, String reason, String name) {

  //fur colour depending on the time of day
  if (time.equals("Morning")) furColour=color(255, 223, 128);
  else if (time.equals("Noon")) furColour = color(128, 200, 255);
  else if (time.equals("Evening")) furColour = color(255, 128, 200);
  else if (time.equals("Night")) furColour = color(80, 80, 160);

  //draws cat face and fills with fur colour
  fill(furColour);
  ellipse(x, y, 60, 60); 

  // Eyes
  fill(day*5);
  ellipse(x-15, y-10, 10, 10);
  ellipse(x+15, y-10, 10, 10);

  // Mouth which changes depending on reason for meow
  stroke(0);
  if (reason.equals("Food")) line(x-10, y+15, x+10, y+15); // straight mouth
  else if (reason.equals("Pets")) arc(x, y+10, 20, 10, 0, PI); // smile
  else if (reason.equals("Annoyed")) arc(x, y+15, 20, 10, PI, TWO_PI); // frown
  else if (reason.equals("Go outside")) {
    line(x-10, y+15, x, y+20);
    line(x, y+20, x+10, y+15);
  }

  // Ears change shape depending on the location
  fill(furColour);
  if (location.equals("Kitchen")) {
    triangle(x-30, y-10, x-15, y-45, x-5, y-30);
    triangle(x+30, y-10, x+15, y-45, x+5, y-30);
  } else if (location.equals("Bedroom")) {
    rect(x-20, y-45, 10, 25);
    rect(x+12, y-45, 10, 25);
  } else if (location.equals("Lounge")) {
    circle(x-20, y-27, 20);
     circle(x+20, y-27, 20);
  } else if (location.equals("Study")) {
    ellipse(x-20, y-29, 15, 25);
    ellipse(x+20, y-29, 15, 25);
  }

  // Tail based on length of meow
  if (length.equals("Long")) {
    line(x+22, y+20, x+40, y+20);
    line(x+40, y+20, x+40, y-5);
  } else line(x+22, y+20, x+40, y+20);

  // Label (this broke and im too tired to fix)
  fill(0);
  textAlign(CENTER);
  text(name, x, y+40);
}
