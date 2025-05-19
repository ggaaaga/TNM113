import oscP5.*;
import netP5.*;

OscP5 osc;
NetAddress supercollider;

float xpos1;
float xpos2;
float xpos3;
float xpos4;
int xpos1Inc = 1;
int xpos2Inc = 1;
int xpos3Inc = 1;
int xpos4Inc = 1;
float xpos1Step = 20;
float xpos2Step = 21;
float xpos3Step = 24;
float xpos4Step = 28;
float xpos1Xmax = 700;
float xpos1Xmin = 360;
float xpos2Xmax = 700;
float xpos2Xmin = 360;
float xpos3Xmax = 700;
float xpos3Xmin = 360;
float xpos4Xmax = 700;
float xpos4Xmin = 360;

float oldValue = 0;

int[] messageTimes = new int[4];
boolean error1Flag = true;
boolean error2Flag = true;
boolean error3Flag = true;
boolean error4Flag = true;

int messageTimeOut = 10000;

int oldLevelTime = 0;

int num = 924;
int range = 10;

float a = 0.0;
float b = 0.0;
float inc1 = TWO_PI/400.0;
float inc2 = TWO_PI/937.0;
float[] data = new float[num]; 
float dc = 0;
int heat = 0;
int heatCounter = 0;

color indicatorColor = color(0, 255, 0);
int indicatorCounter = 0;
boolean indicatorFlag = false;
boolean redFlag = false;
boolean orangeFlag = false;
boolean overheatFlag = true;
boolean bipolarFlag = true;
boolean unstableFlag = true;
boolean zeroFlag = true;
int overheatPos = 0;
int bipolarPos = 0;
int unstablePos = 0;
int zeroPos = 0;

PShape ledIndicator, ledIndicatorCore, ledIndicatorLight0, ledIndicatorLight1, ledIndicatorLight2;

int[] values = new int[6];
int level = 0;

String[] messages = {"Risk for overheating", "Bipolar capacity low", "Unstable output", "Zero target null"};
String[] errors = new String[0];
int[] messageCount = new int[0];


void setup() {
  size(1024, 768);

  osc = new OscP5(this, 12000);
  supercollider = new NetAddress("127.0.0.1", 57120);
  
  for(int i = 0; i < num; i++) {
    data[i] = 150;
  }
  
  ledIndicator = createShape(GROUP);
  ledIndicatorLight0 = createShape(ELLIPSE, 0, 0, 50, 50);
  ledIndicatorLight0.setFill(color(0, 255, 0, 33));
  ledIndicatorLight0.setStroke(false);
  ledIndicatorLight1 = createShape(ELLIPSE, 0, 0, 40, 40);
  ledIndicatorLight1.setFill(color(0, 255, 0, 33));
  ledIndicatorLight1.setStroke(false);
  ledIndicatorLight2 = createShape(ELLIPSE, 0, 0, 30, 30);
  ledIndicatorLight2.setFill(color(0, 255, 0, 33));
  ledIndicatorLight2.setStroke(false);
  ledIndicatorCore = createShape(ELLIPSE, 0, 0, 20, 20);
  ledIndicatorCore.setFill(color(0, 255, 0));
  ledIndicatorCore.setStroke(1);
  ledIndicator.addChild(ledIndicatorLight0);
  ledIndicator.addChild(ledIndicatorLight1);
  ledIndicator.addChild(ledIndicatorLight2);
  ledIndicator.addChild(ledIndicatorCore); 
  
  xpos1 = width/2;
  xpos2 = width/2;
  xpos3 = width/2;
  xpos4 = width/2;
}

void draw() {
  background(150);
  
  values = calcutateValues();

  checkLevels();
  drawGUI();
  
  drawMonitorData();
  setIndicatorColor();
  drawIndicator();
  
  checkErrors();
  displayErrors();
  
  if ((messageTimes[0] > 0) && (millis() - messageTimes[0] > messageTimeOut)){
    messageTimes[0] = 0;
    error1Flag = true;
  }
  if ((messageTimes[1] > 0) && (millis() - messageTimes[1] > messageTimeOut)){
    messageTimes[1] = 0;
    error2Flag = true;
  }
  if ((messageTimes[2] > 0) && (millis() - messageTimes[2] > messageTimeOut)){
    messageTimes[2] = 0;
    error3Flag = true;
  }
  if ((messageTimes[3] > 0) && (millis() - messageTimes[3] > messageTimeOut)){
    messageTimes[3] = 0;
    error4Flag = true;
  }
  
  drawLines();
  drawBars();
  
  //sendLevel();
}

void drawBars() {
  float level1 = (150 - data[0]) * 0.25 + values[1] * values[5] / 25;
  float level2 = values[2] * values[5] / 20;
  float level3 = 10 + values[1] * values[3] / 5;
  float level4 = 25 * values[5] / (1 + values[3]);
  if (level1 > 350) {
    level1 = 350;
  }
  if (level2 > 350) {
    level2 = 350;
  }
  if (level3 > 350) {
    level3 = 350;
  }
  if (level4 > 350) {
    level4 = 350;
  }
  pushMatrix();
  colorMode(HSB, 255);
  color color1 = color(map(level1, 0, 350, 120, 0), 255, 255);
  color color2 = color(map(level2, 0, 350, 120, 0), 255, 255);
  color color3 = color(map(level3, 0, 350, 120, 0), 255, 255);
  color color4 = color(map(level4, 0, 350, 120, 0), 255, 255);
  noStroke();
  fill(color1);
  rect(350, 280, level1, 20);
  fill(color2);
  rect(350, 320, level2, 20);
  fill(color3);
  rect(350, 360, level3, 20);
  fill(color4);
  rect(350, 400, level4, 20);
  popMatrix();
}

void drawLines() {
  int heightOfBar = 50;
  int thin = 4;
  int thick = 16;
  
  pushMatrix();
  noStroke();
  fill(175);
  rect(xpos2, 56, thick, heightOfBar);
  rect(xpos4, 127, thick, heightOfBar);
  fill(75);
  rect(xpos1, 56, thin, heightOfBar);
  rect(xpos3, 127, thin, heightOfBar);
  
  xpos1 += xpos1Step/24 * xpos1Inc;
  xpos2 += xpos2Step/64 * xpos2Inc;
  xpos3 -= xpos3Step/24 * xpos3Inc;
  xpos4 -= xpos4Step/64 * xpos4Inc;
    
  if(xpos1 < xpos1Xmin)  { xpos1Inc = 1; xpos1Step = random(20) + 10; xpos1Xmax = 530 + random(170);}
  if(xpos1 > xpos1Xmax) { xpos1Inc = -1; xpos1Step = random(20) + 10; xpos1Xmin = 360 + random(170);}
  if(xpos2 < xpos2Xmin) { xpos2Inc = 1; xpos2Step = random(20) + 10; xpos2Xmax = 530 + random(170);}
  if(xpos2 > xpos2Xmax) { xpos2Inc = -1; xpos2Step = random(20) + 10; xpos2Xmin = 360 + random(170);}
  if(xpos3 < xpos3Xmin)  { xpos3Inc = -1; xpos3Step = random(20) + 10; xpos3Xmax = 530 + random(170);}
  if(xpos3 > xpos3Xmax) { xpos3Inc = 1; xpos3Step = random(20) + 10; xpos3Xmin = 360 + random(170);}
  if(xpos4 < xpos4Xmin) { xpos4Inc = -1; xpos4Step = random(20) + 10; xpos4Xmax = 530 + random(170);}
  if(xpos4 > xpos4Xmax) { xpos4Inc = 1; xpos4Step = random(20) + 10; xpos4Xmin = 360 + random(170);}
  popMatrix();
}

void checkErrors() {
  if (errors.length < 3) {
    float biValue = ((values[2] + 1) / (values[3] + 1) * random(3));
    if ((biValue > 24) && (bipolarFlag) && (error1Flag)) {
      error1Flag = false;
      messageTimes[0] = millis();
      errors = append(errors, messages[1]);
      sendMessage(messages[1]);
      bipolarPos = errors.length - 1;
      bipolarFlag = false;
      messageCount = append(messageCount, 150);
    } 
    if ((values[2] < 60) && (values[2] > 20) && (unstableFlag) && (error2Flag)) {
      error2Flag = false;
      messageTimes[1] = millis();
      errors = append(errors, messages[2]);
      sendMessage(messages[2]);
      unstablePos = errors.length - 1;
      unstableFlag = false;
      messageCount = append(messageCount, 150);
    } 
    if ((level == 3) && (overheatFlag) && (error3Flag)) {
      error3Flag = false;
      messageTimes[2] = millis();
      errors = append(errors, messages[0]);
      sendMessage(messages[0]);
      overheatPos = errors.length - 1;
      overheatFlag = false;
      messageCount = append(messageCount, 150);
    }
    if ((values[1] <= 30) && (values[1] > 0) && (zeroFlag) && (error4Flag)) {
      error4Flag = false;
      messageTimes[3] = millis();
      errors = append(errors, messages[3]);
      sendMessage(messages[3]);
      zeroPos = errors.length - 1;
      zeroFlag = false;
      messageCount = append(messageCount, 150);
    }
  }
  if (errors.length > 0) {
    for (int i = 0; i < messageCount.length; i++) {
      messageCount[i] -= 1;
      if (messageCount[i] < 0) {
        if ((bipolarPos == i) && (!bipolarFlag)) {
          removeFromArray(i);
          bipolarFlag = true;
        } 
        if ((unstablePos == i) && (!unstableFlag)) {
          removeFromArray(i);
          unstableFlag = true;
        } 
        if ((overheatPos == i) && (!overheatFlag)) {
          removeFromArray(i);
          overheatFlag = true;
        }
        if ((zeroPos == i) && (!zeroFlag)) {
          removeFromArray(i);
          zeroFlag = true;
        }
      }
    }
  }
}

void removeFromArray( int i ) {
    if (i < bipolarPos) {
      bipolarPos -= 1;
    }
    if (i < unstablePos) {
      unstablePos -= 1;
    }
    if (i < overheatPos) {
      overheatPos -= 1;
    }
    if (i < zeroPos) {
      zeroPos -= 1;
    }
  if (errors.length <= 1) {
    errors = shorten(errors);
    messageCount = shorten(messageCount);
  } else {
    arraycopy(errors, i + 1, errors, i, errors.length - 1);
    errors = shorten(errors);
    arraycopy(messageCount, i + 1, messageCount, i, messageCount.length - 1);
    messageCount = shorten(messageCount);
  }
  displayErrors();
}

void displayErrors() {
  pushMatrix();
  textSize(24);
  fill(0);
  for (int i = 0; i < errors.length; i++) { 
    if (errors[i] != null) {
      text(errors[i], 764, 320 + 40 * i);
    }
  }
  popMatrix();
}

int[] calcutateValues() {
  int max = round(abs(min(data)));
  int min = 150 - round(abs(max(data)));
  int pressure = arrayAverage();
  int friction = int(floor(sqrt(pressure)));
  int flow = int((friction + 1) / ((pressure + 1) / 376.0));
  if (heatCounter == 0) {
    heat = int((pressure * friction) / 10 + (level * 10));
  } else if (heatCounter >= 25) {
    heatCounter = -1;
  }
  heatCounter++;
  int[] toReturn = {max, min, pressure, friction, flow, heat};
  return toReturn;
}

void checkLevels() {
  if (data[0] < -90) {
    level = 3;
  } else if (data[0] < -75) {
    level = 2;
  } else if (data[0] < -65) {
    level = 1;
  } else {
    level = 0;
  }
}

void drawGUI() {
  pushMatrix();
  fill(225);
  stroke(10);
  strokeWeight(8);
  rect(30, 25, (width - 60), 410, 10);
  fill(50);
  rect(30, 455, (width - 60), 298, 10);
  textSize(44);
  fill(0);
  text("Status", 55, 100);
  text("Current", 780, 100);
  text("Messages", 760, 270);
  text("Meters", 360, 270);
  textSize(36);
  text("Moving max: " + values[0], 55, 150);
  text("Moving min: " + values[1], 55, 200);
  text("Pressure: " + values[2], 55, 250);
  text("Friction: " + values[3], 55, 300);
  text("Flow: " + values[4], 55, 350);
  text("Heat: " + values[5], 55, 400);
  strokeWeight(2);
  line(330, 40, 330, 420);
  line(720, 40, 720, 420);
  line(740, 200, 970, 200);
  line(350, 200, 700, 200);
  popMatrix();
  pushMatrix();
  textSize(20);
  text("-", 360, 122);
  textSize(18);
  text("+", 688, 122);
  text("0", 520, 122);
  strokeWeight(1);
  line(370, 116, 515, 116);
  line(535, 116, 680, 116);
  line(375, 112, 375, 120);
  for (int i = 0; i < 16; i++) {
    line(375 + 20 * i, 112, 375 + 20 * i, 120);
  }
  popMatrix();
}

void drawIndicator() {
  pushMatrix();
  translate(850, 150);
  shape(ledIndicator);
  popMatrix();
}

int arrayAverage() {
  int sum = 0;
  for (int i = 0; i < num; i++) {
    sum += (150 - data[i])/2;
  }
  return (sum / num);
}

void setIndicatorColor() {
  if (level == 3) {
    ledIndicatorCore.setFill(color(255, 100, 100));
    ledIndicatorLight0.setFill(color(255, 100, 100, 33));
    ledIndicatorLight1.setFill(color(255, 100, 100, 33));
    ledIndicatorLight2.setFill(color(255, 100, 100, 33));
    indicatorFlag = true;
    redFlag = true;
    indicatorCounter = 0;
    sendLevel();
  } else if ((level == 2) && (!redFlag)) {
    ledIndicatorCore.setFill(color(255, 155, 0));
    ledIndicatorLight0.setFill(color(255, 155, 0, 33));
    ledIndicatorLight1.setFill(color(255, 155, 0, 33));
    ledIndicatorLight2.setFill(color(255, 155, 0, 33));
    orangeFlag = true;
    indicatorFlag = true;
    indicatorCounter = 0;
    sendLevel();
  } else if ((level == 1) && (!redFlag) && (!orangeFlag)) {
    ledIndicatorCore.setFill(color(255, 255, 0));
    ledIndicatorLight0.setFill(color(255, 255, 0, 33));
    ledIndicatorLight1.setFill(color(255, 255, 0, 33));
    ledIndicatorLight2.setFill(color(255, 255, 0, 33));
    indicatorFlag = true;
    indicatorCounter = 0;
    sendLevel();
  }
  if (indicatorFlag) {
    indicatorCounter++;
    if (indicatorCounter >= 100) {
      ledIndicatorCore.setFill(color(0, 255, 0));
      ledIndicatorLight0.setFill(color(0, 255, 0, 33));
      ledIndicatorLight1.setFill(color(0, 255, 0, 33));
      ledIndicatorLight2.setFill(color(0, 255, 0, 33));
      redFlag = false;
      orangeFlag = false;
      indicatorFlag = false;
      sendLevel();
    }
  }
}

void drawMonitorData(){
  updateData();
  pushMatrix();
  colorMode(RGB, 255);
  for(int i=1; i<num; i++) {    
    float alphaVal = float(num - i)/num * 200 + 55;
    stroke(93, 255, 0, alphaVal);
    strokeWeight(1);
    line((width - 50) - i, data[i-1] + 595, (width - 50) - i, data[i] + 595);
  }
  popMatrix();
}

void updateData() {
  for(int i = num - 1; i > 0; i--) {
    data[i] = data[i-1];
  }

  a = a + inc1;
  b = b + inc2;
  data[0] = cos(a) * (20 * random(2));
  data[0] += cos(b) * (20 * random(2));
  data[0] += random(-2, 2) * random(8);
  
  float burst = random(1000);
  if (burst >= 990) {
    data[0] += random(50);
  } else if (burst <= 10) {
    data[0] -= random(50);
  };
  
  float dcRandom = random(10000);
  int[] offset = { -50, 50 }; 
  if (dcRandom >= 9900) {
    dc = offset[round(random(1))];
  } else if (dcRandom <= 100) {
    dc = 0;
  };
  data[0] += dc;
  float value = (oldValue * 0.8) + (data[0] * 0.2);
  sendData(150 - value);
  oldValue = value;
}

void sendMessage( String errorMessage) {
  OscMessage msg = new OscMessage("/error");
  msg.add(errorMessage);
  osc.send(msg, supercollider);
}

void sendData( float dataPoint ) {
  OscMessage msg = new OscMessage("/data");
  msg.add(dataPoint);
  osc.send(msg, supercollider);
}

void sendLevel() {
  OscMessage msg = new OscMessage("/level");
  msg.add(level);
  osc.send(msg, supercollider);
}
