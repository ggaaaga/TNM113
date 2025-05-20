import oscP5.*;
import netP5.*;

OscP5 osc;
NetAddress supercollider;

PImage base, wall, night, closed, evening, happy;
PImage p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10;

int p0Tint = 0;
int p1Tint = 0;
int p2Tint = 0;
int p3Tint = 0;
int p4Tint = 0;
int p5Tint = 0;
int p6Tint = 0;
int p7Tint = 0;
int p8Tint = 0;
int p9Tint = 0;
int p10Tint = 0;

int numberOfPersons = 0;
int previousNumberOfPersons = 0;
int[] arrayOfPersons = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};

int tintLevel = 0;
int eveningTint = 0;
int happyTint = 255;
int happyCount = 0;

int[] p0Times = {8, 30, 10, 40, 17, 45, 22, 12};
int[] p1Times = {8, 35, 10, 00, 18, 45, 22, 30};
int[] p2Times = {8, 45, 10, 20, 16, 10, 22, 20};
int[] p3Times = {9, 00, 10, 50, 16, 20, 22, 03};

int[] p4Times = {11, 00, 13, 50, 18, 20, 22, 35};
int[] p5Times = {10, 10, 14, 10, 19, 00, 22, 07};
int[] p6Times = {10, 40, 13, 30, 20, 25, 22, 10};

int[] p7Times = {9, 30, 10, 40, 14, 45, 22, 20};
int[] p8Times = {10, 35, 12, 00, 15, 05, 22, 17};
int[] p9Times = {11, 05, 15, 25, 16, 00, 22, 10};
int[] p10Times = {10, 55, 15, 20, 21, 20, 22, 25};

String[] dayParts = {"Morning", "Lunch", "Afternoon", "Evening", "Happy hour", "Closed"};

int hour;
int minutes;
boolean timerFlag = true;
boolean running = false;

int previousTime = 0;
int waitingTime = 575;
int previousMinute = 1;
float temperature = 19.7;


int rectX, rectY;
int rectWidth = 120;
int rectHeight = 30;
color rectColor = color(100);
color rectHighlight = color(155);
boolean pauseOver = false;
boolean resetOver = false;
String buttonString, button2String;


void setup() {
  size(1024, 768);
  
  osc = new OscP5(this, 12000);
  supercollider = new NetAddress("127.0.0.1", 57120);
  
  base = loadImage("images/base.png");
  wall = loadImage("images/wall.png");
  night = loadImage("images/night.png");
  closed = loadImage("images/closed.png");
  evening = loadImage("images/evening.png");
  happy = loadImage("images/happy.png");
  p0 = loadImage("images/0.png");
  p1 = loadImage("images/1.png");
  p2 = loadImage("images/2.png");
  p3 = loadImage("images/3.png");
  p4 = loadImage("images/4.png");
  p5 = loadImage("images/5.png");
  p6 = loadImage("images/6.png");
  p7 = loadImage("images/7.png");
  p8 = loadImage("images/8.png");
  p9 = loadImage("images/9.png");
  p10 = loadImage("images/10.png");
  
  rectX = width / 2 - (rectWidth + 30);
  rectY = height / 2 - (rectHeight + 30);
}

void draw() {
  translate(width/2, height/2);
  imageMode(CENTER);
   
  overPause();
  overReset();

  if (running) {
    background(0);
    if (tintLevel >= 255) {
      tint(255, 255);
      image(closed, 0, 0);
      timerFlag = false;
    } else {
      tint(255, 255);
      image(base, 0, 0);
      tint(255, tintLevel);
      image(night, 0, 0);
      drawPeople();
      tint(255, 255);
      image(wall, 0, 0);
      tint(255, eveningTint);
      image(evening, 0, 0);
    }
    if (timerFlag && millis() - previousTime > waitingTime) {
      tintLevel++;
      hour = 8 + tintLevel / 17;
      minutes = int((((8 + tintLevel / 17.0) - hour) * 100) * 0.6);
      if (hour > 17) {
        if (eveningTint < 255) {
          eveningTint += 5;
        } else if (eveningTint > 255) {
          eveningTint = 255;
        };
      };
      previousTime = millis();
    }
    if ((hour >= 20) && (hour < 23)) {
      rotateHappy();
    };
    
    showClock();
    showTemperature();
    setPeoplesTint();
    happyCount++;
  } else {
    displayIntroText();
  }
  
  pushMatrix();
  if (pauseOver) {
    fill(rectHighlight);
  } else if (!running) {
    fill(rectColor);
    buttonString = "PLAY";
  } else {
    fill(rectColor);
    buttonString = "PAUSE";
  }
  rect(rectX, rectY, rectWidth, rectHeight, 20);
  fill(255);
  textSize(24);
  textAlign(CENTER);
  text(buttonString, 424, 347);
  popMatrix();
  pushMatrix();
  if (resetOver) {
    fill(rectHighlight);
  } else {
    fill(rectColor);
  }
  rect(rectX - 160, rectY, rectWidth, rectHeight, 20);
  fill(255);
  textSize(24);
  textAlign(CENTER);
  text("RESET", 424 - 160, 347);
  popMatrix();
}

void showClock() {
  pushMatrix();
  String hourString = str(hour);
  String minutesString = str(minutes);
  textAlign(LEFT);
  textSize(56);
  fill(255);
  if (hourString.length() < 2) {
    hourString = "0" + hourString;
  }
  if (minutesString.length() < 2) {
    minutesString = "0" + minutesString;
  }
  text(hourString+":"+minutesString, -482, 354);
  showDayParts();
  popMatrix();
  sendTime();
}
int part = 0;
void showDayParts() {
  switch(hour) {
  case 8: 
    part = 0;
    break;
  case 11: 
    part = 1;
    break;
  case 13: 
    part = 2;
    break;
  case 17: 
    part = 3;
    break;
  case 20: 
    part = 4;
    break;
  case 23: 
    part = 5;
    break;
}
  
  text(dayParts[part], -332, 354);

}

void setPeoplesTint() {
  if ((p0Times[0] == hour && p0Times[1] <= minutes) || (p0Times[4] == hour && p0Times[5] <= minutes)) {
    p0Tint = 255;
    arrayOfPersons[0] = 1;
  } else if ((p0Times[2] == hour && p0Times[3] <= minutes) || (p0Times[6] == hour && p0Times[7] <= minutes)) {
    p0Tint = 0;
    arrayOfPersons[0] = 0;
  };
  if ((p1Times[0] == hour && p1Times[1] <= minutes) || (p1Times[4] == hour && p1Times[5] <= minutes)) {
    p1Tint = 255;
    arrayOfPersons[1] = 1;
  } else if ((p1Times[2] == hour && p1Times[3] <= minutes) || (p1Times[6] == hour && p1Times[7] <= minutes)) {
    p1Tint = 0;
    arrayOfPersons[2] = 0;
  };
  if ((p2Times[0] == hour && p2Times[1] <= minutes) || (p2Times[4] == hour && p2Times[5] <= minutes)) {
    p2Tint = 255;
    arrayOfPersons[2] = 1;
  } else if ((p2Times[2] == hour && p2Times[3] <= minutes) || (p2Times[6] == hour && p2Times[7] <= minutes)) {
    p2Tint = 0;
    arrayOfPersons[2] = 0;
  };
  if ((p3Times[0] == hour && p3Times[1] <= minutes) || (p3Times[4] == hour && p3Times[5] <= minutes)) {
    p3Tint = 255;
    arrayOfPersons[3] = 1;
  } else if ((p3Times[2] == hour && p3Times[3] <= minutes) || (p3Times[6] == hour && p3Times[7] <= minutes)) {
    p3Tint = 0;
    arrayOfPersons[3] = 0;
  };
  
  if ((p4Times[0] == hour && p4Times[1] <= minutes) || (p4Times[4] == hour && p4Times[5] <= minutes)) {
    p4Tint = 255;
    arrayOfPersons[4] = 1;
  } else if ((p4Times[2] == hour && p4Times[3] <= minutes) || (p4Times[6] == hour && p4Times[7] <= minutes)) {
    p4Tint = 0;
    arrayOfPersons[4] = 0;
  };
  if ((p5Times[0] == hour && p5Times[1] <= minutes) || (p5Times[4] == hour && p5Times[5] <= minutes)) {
    p5Tint = 255;
    arrayOfPersons[5] = 1;
  } else if ((p5Times[2] == hour && p5Times[3] <= minutes) || (p5Times[6] == hour && p5Times[7] <= minutes)) {
    p5Tint = 0;
    arrayOfPersons[5] = 0;
  };
  if ((p6Times[0] == hour && p6Times[1] <= minutes) || (p6Times[4] == hour && p6Times[5] <= minutes)) {
    p6Tint = 255;
    arrayOfPersons[6] = 1;
  } else if ((p6Times[2] == hour && p6Times[3] <= minutes) || (p6Times[6] == hour && p6Times[7] <= minutes)) {
    p6Tint = 0;
    arrayOfPersons[6] = 0;
  };
  
  if ((p7Times[0] == hour && p7Times[1] <= minutes) || (p7Times[4] == hour && p7Times[5] <= minutes)) {
    p7Tint = 255;
    arrayOfPersons[7] = 1;
  } else if ((p7Times[2] == hour && p7Times[3] <= minutes) || (p7Times[6] == hour && p7Times[7] <= minutes)) {
    p7Tint = 0;
    arrayOfPersons[7] = 0;
  };
  if ((p8Times[0] == hour && p8Times[1] <= minutes) || (p8Times[4] == hour && p8Times[5] <= minutes)) {
    p8Tint = 255;
    arrayOfPersons[8] = 1;
  } else if ((p8Times[2] == hour && p8Times[3] <= minutes) || (p8Times[6] == hour && p8Times[7] <= minutes)) {
    p8Tint = 0;
    arrayOfPersons[8] = 0;
  };
  if ((p9Times[0] == hour && p9Times[1] <= minutes) || (p9Times[4] == hour && p9Times[5] <= minutes)) {
    p9Tint = 255;
    arrayOfPersons[9] = 1;
  } else if ((p9Times[2] == hour && p9Times[3] <= minutes) || (p9Times[6] == hour && p9Times[7] <= minutes)) {
    p9Tint = 0;
    arrayOfPersons[9] = 0;
  };
  if ((p10Times[0] == hour && p10Times[1] <= minutes) || (p10Times[4] == hour && p10Times[5] <= minutes)) {
    p10Tint = 255;
    arrayOfPersons[10] = 1;
  } else if ((p10Times[2] == hour && p10Times[3] <= minutes) || (p10Times[6] == hour && p10Times[7] <= minutes)) {
    p10Tint = 0;
    arrayOfPersons[10] = 0;
  };
  int sum = 0;
  for (int i = 0; i < arrayOfPersons.length; i++) {
    sum += arrayOfPersons[i];
  };
  numberOfPersons = sum;
  if (numberOfPersons != previousNumberOfPersons) {
    sendNumberOfPersons();
    changeTemperature();
    previousNumberOfPersons = numberOfPersons;
  };
}

void drawPeople() {
  tint(255, p0Tint);
  image(p0, 0, 0);
  tint(255, p1Tint);
  image(p1, 0, 0);
  tint(255, p2Tint);
  image(p2, 0, 0);
  tint(255, p3Tint);
  image(p3, 0, 0);
  
  tint(255, p4Tint);
  image(p4, 0, 0);
  tint(255, p5Tint);
  image(p5, 0, 0);
  tint(255, p6Tint);
  image(p6, 0, 0);
  
  tint(255, p7Tint);
  image(p7, 0, 0);
  tint(255, p8Tint);
  image(p8, 0, 0);
  tint(255, p9Tint);
  image(p9, 0, 0);
  tint(255, p10Tint);
  image(p10, 0, 0);
}

void rotateHappy() {
  pushMatrix();
  happyTint = 255;
  tint(255, happyTint);
  rotate(4 * happyCount*TWO_PI/360);
  image(happy, 100, 0);
  popMatrix();
}

void showTemperature() {
  pushMatrix();
  textSize(56);
  fill(255);
  text(temperature+"°C", -482, 304);
  popMatrix();
  sendTemperature();
}
void changeTemperature() {
  temperature = 19 + round(sqrt(numberOfPersons) * 10) / 10.0;
}

void sendNumberOfPersons() {
  OscMessage msg = new OscMessage("/person");
  msg.add(numberOfPersons);
  osc.send(msg, supercollider);
}
void sendTime() {
  if (previousMinute != minutes) {
    OscMessage msg = new OscMessage("/time");
    msg.add(hour);
    msg.add(minutes);
    osc.send(msg, supercollider);
    previousMinute = minutes;
  };
}
void sendTemperature() {
  OscMessage msg = new OscMessage("/temperature");
  msg.add(temperature);
  osc.send(msg, supercollider);
}


void overPause()  {
  if (mouseX >= (width - rectWidth - 30) && mouseX <= (width - 30) && 
      mouseY >= (height - rectHeight - 30) && mouseY <= (height - 30)) {
    pauseOver = true;
  } else {
    pauseOver = false;
  }
}
void overReset()  {
  if (mouseX >= (width - rectWidth - 160) && mouseX <= (width - 160) && 
      mouseY >= (height - rectHeight - 30) && mouseY <= (height - 30)) {
    resetOver = true;
  } else {
    resetOver = false;
  }
}
void mousePressed() {
  if (pauseOver) {
    running = !running;
  } else if (resetOver) {
    p0Tint = 0;
    p1Tint = 0;
    p2Tint = 0;
    p3Tint = 0;
    p4Tint = 0;
    p5Tint = 0;
    p6Tint = 0;
    p7Tint = 0;
    p8Tint = 0;
    p9Tint = 0;
    p10Tint = 0;
    tintLevel = 0;
    eveningTint = 0;
    happyTint = 255;
    happyCount = 0;
    numberOfPersons = 0;
    temperature = 19.7;
    running = false;
    timerFlag = true;
  }
}

void displayIntroText() {
  pushMatrix();
  fill(0);
  textSize(24);
  textAlign(RIGHT);
  text("<PLAY> will start the animation.", width / 2 - 30, -50);
  text("When running, <PAUSE> will hault", width / 2 - 30, -20);
  text("the animation.", width / 2 - 30, 10);
  text("<RESET> will pause and reset the", width / 2 - 30, 70);
  text("animation the next time it starts.", width / 2 - 30, 100);
  popMatrix();
}
