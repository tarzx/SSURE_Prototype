import controlP5.*;

class Duration {
  int time;
  float xPos = 0;
  float yPos = 0;
  
  Duration(float _x, float _y) {
    xPos = _x;
    yPos = _y;
    time = 0;
  }
  
  void restart() {
    time = 0;
  }
  
  void run() {
    printDuration();
    time++;
  }
  
  void pause() {
    printDuration();
  }  
  
  void printDuration() {
    noStroke();
    fill(0);
    rect(xPos, yPos, width, 20);
    fill(255);
    textSize(20);
    String st = nf((time/360000),2) + ":" + 
                nf(((time/6000)%60),2) + ":" + 
                nf(((time/100)%60),2) + ":" +
                nf((time%100),2);
    text("Duration: " + st, xPos, yPos+20);
  }
}

class Distance {
  int move, lastX;
  float xPos = 0;
  float yPos = 0;
  
  Distance(float _x, float _y) {
    xPos = _x;
    yPos = _y;
    move = 0;
    lastX = 0;
  }
  
  void restart() {
    move = 0;
    lastX = 0;
  }
  
  void run() {
    printDistance();
    move += abs(mouseX-lastX);
    lastX = mouseX;
  }
  
  void pause() {
    printDistance();
  }  
  
  void printDistance() {
    noStroke();
    fill(0);
    rect(xPos, yPos, width, 20);
    fill(255);
    textSize(20);
    text("Distance: " + String.valueOf(move/100), xPos, yPos+20);
  }
}

class LineGraph {
 
   int[] xvals;
   int[] yvals;
   float xPos = 0;
   float yPos = 0;
 
   LineGraph(float _x, float _y) {
     xPos = _x;
     yPos = _y;
     xvals = new int[width];
     yvals = new int[width];
   }
   
   void restart() {
     xvals = new int[width];
     yvals = new int[width];
   }
  
   void run() {
    for(int i = 1; i < width; i++) { 
      xvals[i-1] = xvals[i]; 
      yvals[i-1] = yvals[i];
    } 
    
    // Add the new values to the end of the array 
    xvals[width-1] = mouseX; 
    yvals[width-1] = mouseY;
    
    drawLine();
  }
  
  void pause() {
    drawLine();
  }
  
  void drawLine() {
    for(int i=1; i<width; i++) {
      stroke(255,0,0);
      point(xPos + i, yPos + height/12.8 + xvals[i]/4);
      stroke(0,255,0);
      point(xPos + i, yPos + height/12.8 + yvals[i]/6.4);
    }
  }
}

class BarGraph {
 
   int[] xvals;
   int size = 5;
   float xPos = 0;
   float yPos = 0;
 
   BarGraph(float _x, float _y) {
     xPos = _x;
     yPos = _y;
     xvals = new int[width/5];
   }
   
   void restart() {
     xvals = new int[width/5];
   }
  
   void run() {
    for(int i = 1; i < width/5; i++) { 
      xvals[i-1] = xvals[i]; 
    } 
    
    // Add the new values to the end of the array 
    xvals[width/5-1] = mouseX; 
    
    drawLine();
  }
  
  void pause() {    
    drawLine();
  }
  
  void drawLine() {
    for(int i=1; i<width/5; i++) {
      fill(0,0,255);
      stroke(255);
      rect(xPos + i*5, yPos + height/3.2-xvals[i]/2, size, xvals[i]/2);
    }
  }
}

class Pace {
  boolean isRun;
  boolean isRight;
  int numPace=0;
  float xPos = 0;
  float yPos = 0;
  
  Pace(float _x, float _y) {
    xPos = _x;
    yPos = _y;
    isRun = false;
    isRight = false;
  }
  
  void restart() {
    isRun = false;
    isRight = false;
    numPace = 0;
  }
  
  void run() {
    isRun = true;
    countPace();
    drawPace();
    printPace();
  }
  
  void pause() {
    isRun = false;
    drawPace();
    printPace();
  }
  
  void countPace() {
    boolean last = isRight;
    if(mouseX%100 < 50) {
      isRight = false;
    } else { 
      isRight = true; 
    }
    if(last != isRight) { numPace++; }
  }
  
  void printPace() {
    
    fill(255);
    textSize(14);
    text("Pace:", xPos + width/2-30, yPos + 50);
    textSize(72);
    text(String.valueOf(numPace), xPos + width/2-30, yPos + 120);
  }
  
  void drawPace() {
    if(isRun) {
      if (isRight) {
        fill(100);
        stroke(255);
        rect(xPos + width/4 - 40, yPos + 40, 30, 60);
        rect(xPos + width/4 - 40, yPos + 110, 30, 30);
        fill(200);
        stroke(255);
        rect(xPos + width/4 + 10, yPos + 50, 30, 60);
        rect(xPos + width/4 + 10, yPos + 120, 30, 30);
      } else {
        fill(200);
        stroke(255);
        rect(xPos + width/4 - 40, yPos + 40, 30, 60);
        rect(xPos + width/4 - 40, yPos + 110, 30, 30);
        fill(100);
        stroke(255);
        rect(xPos + width/4 + 10, yPos + 50, 30, 60);
        rect(xPos + width/4 + 10, yPos + 120, 30, 30);
      }
    } else {
      fill(100);
      stroke(255);
      rect(xPos + width/4 - 40, yPos + 40, 30, 60);
      rect(xPos + width/4 - 40, yPos + 110, 30, 30);
      rect(xPos + width/4 + 10, yPos + 50, 30, 60);
      rect(xPos + width/4 + 10, yPos + 120, 30, 30);
    }
  }
}

class ButtonBox {
  
  float xPos = 0;
  float yPos = 0;      // Position of square button
  int rectwidth = 0; 
  int rectheight = 0;  // Diameter of rect
  color rectColor;
  color rectHighlight;
  boolean rectOver = false;
  
  ButtonBox(float _x, float _y) {
    xPos = _x;
    yPos = _y;
    rectColor = color(0);
    rectHighlight = color(50);
  }
  
  void run() {
    update();
    
    if (rectOver) {
      fill(rectHighlight);
    } else {
      fill(rectColor);
    }
    stroke(255);
    rect(xPos, yPos, rectwidth, rectheight);
    
  }
  
  void update() {
    if ( overRect(xPos, yPos, rectwidth, rectheight) ) {
      rectOver = true;
    } else {
      rectOver = false;
    }
  }
  
  boolean overRect(float x, float y, int width, int height)  {
    if (mouseX >= x && mouseX <= x+width && 
        mouseY >= y && mouseY <= y+height) {
      return true;
    } else {
      return false;
    }
  }
}

class ButtonLine extends ButtonBox {
  ButtonLine(float _x, float _y) {
    super(_x, _y);
    rectwidth = 60;
    rectheight = 40;
  }
  void run() {
    super.run();
    float[] xValues = new float[rectwidth];
    float[] yValues = new float[rectwidth];
    
    boolean isxFall = true;
    boolean isyFall = false;
    for(int i=0; i<rectwidth; i++) {
      if (i==0) {
        xValues[i] = rectheight/2;
        yValues[i] = rectheight/2;
      } else {
        if (isxFall && xValues[i-1] + 2 >= rectheight) {
          isxFall = false;
        } else if (!isxFall && xValues[i-1] - 4 <= 0) {
          isxFall = true;
        }
        xValues[i] = (isxFall) ? xValues[i-1] + 2 : xValues[i-1] - 4;
        if (isyFall && yValues[i-1] + 3 >= rectheight) {
          isyFall = false;
        } else if (!isyFall && yValues[i-1] - 5 <= 0) {
          isyFall = true;
        }
        yValues[i] = (isyFall) ? yValues[i-1] + 3 : yValues[i-1] - 5;
      }
    }
    
    for(int i=1; i<rectwidth; i++) {
      stroke(255,0,0);
      point(xPos + i, yPos + xValues[i]);
      stroke(0,255,0);
      point(xPos + i, yPos + yValues[i]);
    }
  }
}

class ButtonGraph extends ButtonBox {
  int size = 5;
  ButtonGraph(float _x, float _y) {
    super(_x, _y);
    rectwidth = 60;
    rectheight = 40;
  }
  void run() {
    super.run();
    float[] xValues = new float[rectwidth/size];
    
    boolean isxFall = true;
    for(int i=0; i<rectwidth/size; i++) {
      if (i==0) {
        xValues[i] = rectheight/2;
      } else {
        if (isxFall && xValues[i-1] + 2 >= rectheight) {
          isxFall = false;
        } else if (!isxFall && xValues[i-1] - 4 <= 0) {
          isxFall = true;
        }
        xValues[i] = (isxFall) ? xValues[i-1] + 2 : xValues[i-1] - 4;
      }
    }
    
    for(int i=0; i<rectwidth/size; i++) {
      fill(0,0,255);
      stroke(255);
      rect(xPos + i*5, yPos + rectheight-xValues[i], size, xValues[i]);
    }
  }
}

class ButtonPace extends ButtonBox {
  ButtonPace(float _x, float _y) {
    super(_x, _y);
    rectwidth = 60;
    rectheight = 40;
  }
  void run() {
    super.run();
    fill(255);
    textSize(22);
    text("PACE", xPos+2, yPos+rectheight-12);
  }
}

class ButtonPlay extends ButtonBox {
  ButtonPlay(float _x, float _y, boolean isSub) {
    super(_x, _y);
    rectwidth = (isSub) ? width/2 : width;
    rectheight = 100;
    rectColor = color(20,40,100);
    rectHighlight = color(40,70,150);
  }
  void run() {
    super.run();
    fill(255);
    triangle(xPos+rectwidth/2-30, yPos+20, 
             xPos+rectwidth/2-30, yPos+rectheight-20, 
             xPos+rectwidth/2+30, yPos+rectheight/2);
  }
}

class ButtonStop extends ButtonBox {
  ButtonStop(float _x, float _y) {
    super(_x, _y);
    rectwidth = width/2;
    rectheight = 100;
    rectColor = color(20,40,100);
    rectHighlight = color(40,70,150);
  }
  void run() {
    super.run();
    fill(255);
    rect(xPos+rectwidth/2-30, yPos+20, 
         60, 60);
  }
}

class ButtonPause extends ButtonBox {
  ButtonPause(float _x, float _y) {
    super(_x, _y);
    rectwidth = width/2;
    rectheight = 100;
    rectColor = color(20,40,100);
    rectHighlight = color(40,70,150);
  }
  void run() {
    super.run();
    fill(255);
    rect(xPos+rectwidth/2-30, yPos+20, 
         20, 60);
    rect(xPos+rectwidth/2+10, yPos+20, 
         20, 60);
  }
}

class ButtonRestart extends ButtonBox {
  ButtonRestart(float _x, float _y) {
    super(_x, _y);
    rectwidth = width;
    rectheight = 100;
    rectColor = color(20,40,100);
    rectHighlight = color(40,70,150);
  }
  void run() {
    super.run();
    noStroke();
    fill(255);
    ellipse(xPos+rectwidth/2, yPos+rectheight/2, 70, 70);
    if (rectOver) {
      fill(rectHighlight);
    } else {
      fill(rectColor);
    }
    ellipse(xPos+rectwidth/2, yPos+rectheight/2, 50, 50);
    triangle(xPos+rectwidth/2, yPos+rectheight/2, 
             xPos+rectwidth/2+40, yPos+rectheight/2-40, 
             xPos+rectwidth/2+40, yPos+rectheight/2);
    fill(255);
    triangle(xPos+rectwidth/2+20, yPos+rectheight/2, 
             xPos+rectwidth/2+30, yPos+rectheight/2-15, 
             xPos+rectwidth/2+40, yPos+rectheight/2);
  }
}

class Tracking{
  float xPos = 0;
  float yPos = 0;
  
  Tracking(float _x, float _y) {
    xPos = _x;
    yPos = _y;
  }
  
  void run() {
    textSize(18);
    text("Tracking",xPos+10,yPos);
    fill(200,200,20);
    rect(xPos+50, yPos+10, width-100, 180);
    fill(255,0,0);
    textSize(72);
    text("MAP", xPos+120, yPos+120);
  }
  
  void pause() {
    //pause
    textSize(18);
    text("Tracking",xPos+10,yPos);
    fill(200,200,20);
    rect(xPos+50, yPos+10, width-100, 180);
    fill(255,0,0);
    textSize(72);
    text("MAP", xPos+120, yPos+120);
  }
}

class Menu {
  float xPos = 0;
  float yPos = 0;
  int boxwidth, boxheight;
  char mode = 'C';
  color rectColor;
  color rectHighlight;
  boolean OverM1 = false;
  boolean OverM2 = false;
  String[] menu = {"Set Exernal Sensor", "Set Target"};
  
  NumBar p1, d1, dh, dm, ds;
  
  Menu(float _x, float _y) {
    xPos = _x;
    yPos = _y;
    boxwidth = width;
    boxheight = 50;
    rectHighlight = color(50);
    rectColor = color(20);
    
    p1 = new NumBar(true, xPos+150, yPos+120, 100, 0, 5000);
    d1 = new NumBar(true, xPos+150, yPos+150, 300, 0, 40000);
    dh = new NumBar(false, xPos+150, yPos+180, 0, 0, 99);
    dm = new NumBar(false, xPos+200, yPos+180, 1, 0, 59);
    ds = new NumBar(false, xPos+250, yPos+180, 0, 0, 59);
  }
  
  int getPace() {
    return p1.value;
  }
  int getDistance() {
    return d1.value;
  }
  int getDuration() {
    return ((dh.value*360000)+(dm.value*6000)+(ds.value*100));
  }
  
  void run() {
    update();
    
    if(mode == 'C') {
      drawM1();
      drawM2();
    } else if(mode =='E') {
      drawM1();
      drawSetEx();
      drawM2();
    } else if(mode =='T') {
      drawM1();
      drawM2();
      drawSetTarget();
    }
  }
  
  void drawM1() {
    if (OverM1) {
      fill(rectHighlight);
    } else {
      fill(rectColor);
    }
    stroke(255);
    rect(xPos, yPos, width, boxheight);
    fill(255);
    textSize(30);
    text(menu[0],xPos+10,yPos+40);
  }
  
  void drawM2() {
    int gap=50;
    if(mode=='E') gap+=120;
    if (OverM2) {
      fill(rectHighlight);
    } else {
      fill(rectColor);
    }
    stroke(255);
    rect(xPos, yPos+gap, width, boxheight);
    fill(255);
    textSize(30);
    text(menu[1],xPos+10,yPos+40+gap);
  }
  
  void drawSetEx() {
    textSize(18);
    text("Searching...", xPos+10, yPos+80);
  }
  
  void drawSetTarget() {
    textSize(15);
    text("Pace", xPos+10, yPos+130);
    text("Distance", xPos+10, yPos+160);
    text("Duration", xPos+10, yPos+210);
    
    p1.setStep(10);
    p1.drawBar();
    
    d1.setStep(100);
    d1.drawBar();
    
    textSize(20);
    text(":", xPos+195, yPos+210);
    text(":", xPos+245, yPos+210);
    dh.drawBar();  
    dm.drawBar();
    ds.drawBar();
  }
  
  void setBar() {
    p1.setValue();
    d1.setValue();
    dh.setValue();
    dm.setValue();
    ds.setValue();
  }
  
  void update() {
    if ( overRect(xPos, yPos, boxwidth, boxheight) ) {
      OverM1 = true;
    } else {
      OverM1 = false;
    }
    int gap = 0;
    if(mode=='E') gap += 120;
    if ( overRect(xPos, yPos+boxheight+gap, boxwidth, boxheight) ) {
      OverM2 = true;
    } else {
      OverM2 = false;
    }
  }
  
  boolean overRect(float x, float y, int width, int height)  {
    if (mouseX >= x && mouseX <= x+width && 
        mouseY >= y && mouseY <= y+height) {
      return true;
    } else {
      return false;
    }
  }
}

class NumBar {
  float xPos = 0;
  float yPos = 0;
  int value;
  int start = 0;
  int end = 0;
  int gap = 0;
  int step = 1;
  char mode = 'U';
  boolean OverD = false;
  boolean OverI = false;
  
  NumBar(boolean isBar, float _x, float _y, int def, int _s, int _e) {
    xPos = _x;
    yPos = _y;
    value = def;
    start = _s;
    end = _e;
    if(isBar) mode = 'B';
  }
  
  void setStep(int _st) {
    step = _st;
  }
  
  void drawBar() {
    if(mode=='B') {
      gap = 100;
      noStroke();
      fill(150);
      triangle(xPos, yPos+5, xPos+10, yPos, xPos+10, yPos+10);
      triangle(xPos+gap, yPos+10, xPos+gap, yPos, xPos+10+gap, yPos+5);
      fill(255);
      textSize(14);
      text(String.valueOf(value), xPos+gap/2-10, yPos+10);
    } else if(mode=='U') {
      gap = 40;
      noStroke();
      fill(150);
      triangle(xPos+20, yPos, xPos, yPos+10, xPos+40, yPos+10);
      triangle(xPos, yPos+gap, xPos+40, yPos+gap, xPos+20, yPos+10+gap);
      fill(255);
      textSize(20);
      text(nf(value,2), xPos+7, yPos+gap-8);
    }
  }
  
  void setValue() {
    update();
    if(OverD) {
      if(value>start) value -= step;
    } else if (OverI) {
      if(value<end) value += step;
    }
  }
  
  void update() {
    OverD = false;
    OverI = false;
    if(mode=='B') {
      if ( overRect(xPos, yPos, 10, 10) ) {
        OverD = true;
        OverI = false;
      } else if ( overRect(xPos+gap, yPos, 10, 10) ) {
        OverD = false;
        OverI = true;
      }
    } else if(mode=='U') {
      if ( overRect(xPos, yPos, 40, 10) ) {
        OverD = true;
        OverI = false;
      } else if ( overRect(xPos, yPos+gap, 40, 10) ) {
        OverD = false;
        OverI = true;
      }
    }
  }
  
  boolean overRect(float x, float y, int width, int height)  {
    if (mouseX >= x && mouseX <= x+width && 
        mouseY >= y && mouseY <= y+height) {
      return true;
    } else {
      return false;
    }
  }
}

class Information {
  int pace;
  int distance;
  float speed;
  float avgpace;
  int duration;
  
  Information() {
    pace = 0;
    duration = 0;
    distance = 0;
  }
  
  void setPace(int _p) {
    pace = _p;
    setavgPace();
  }
  
  void setDistance(int _d) {
    distance = _d;
    setspeed();
  }
  
  void setDuration(int time) {
    duration = time; 
    setavgPace();
    setspeed();
  }
  
  void setavgPace() {
    if(duration/6000>0) {
      avgpace = pace/(duration/6000);
    } else {
      avgpace = 0;
    }
  }
  
  void setspeed() {
    if(duration/6000>0) {
      speed = distance/(duration/6000);
    } else {
      speed = 0;
    }
  }
}

class Result {
  float xPos = 0;
  float yPos = 0;
  Information actual, target;
  
  Result(float _x, float _y, Information act, Information tar) {
    xPos = _x;
    yPos = _y;
    actual = act;
    target = tar;
  }
  
  void run() {
    fill(255);
    stroke(255);
    textSize(15);
    text("Target", xPos+160, yPos+20);
    text("Actual", xPos+width/2+70, yPos+20);
    
    stroke(255);
    fill(0);
    rect(xPos,yPos+40,width, 30);
    rect(xPos,yPos+70,width, 30);
    rect(xPos,yPos+100,width, 30);
    rect(xPos,yPos+130,width, 30);
    rect(xPos,yPos+160,width, 30);
    
    fill(255);
    text("Duartion:", xPos+10, yPos+60);  
    text("Pace:", xPos+10, yPos+90);  
    text("Distance:", xPos+10, yPos+120);  
    text("Average Pace:", xPos+10, yPos+150);  
    text("Average Speed:", xPos+10, yPos+180);  
    
    //target
    String tdu = nf((target.duration/360000),2) + ":" + 
                nf(((target.duration/6000)%60),2) + ":" + 
                nf(((target.duration/100)%60),2) + ":" +
                nf((target.duration%100),2);
    text(tdu, xPos+160, yPos+60);  
    text(String.valueOf(target.pace), xPos+160, yPos+90);  
    text(String.valueOf(target.distance), xPos+160, yPos+120);  
    text(String.valueOf(target.avgpace), xPos+160, yPos+150);  
    text(String.valueOf(target.speed), xPos+160, yPos+180);  
    
    //actual
    String adu = nf((actual.duration/360000),2) + ":" + 
                nf(((actual.duration/6000)%60),2) + ":" + 
                nf(((actual.duration/100)%60),2) + ":" +
                nf((actual.duration%100),2);
    text(adu, xPos+width/2+70, yPos+60);  
    text(String.valueOf(actual.pace), xPos+width/2+70, yPos+90);  
    text(String.valueOf(actual.distance), xPos+width/2+70, yPos+120);  
    text(String.valueOf(actual.avgpace), xPos+width/2+70, yPos+150);  
    text(String.valueOf(actual.speed), xPos+width/2+70, yPos+180);  
    
    //meet
    if(target.duration>actual.duration) { fill(255,0,0); } else { fill(0,255,0); };
    rect(xPos+width-31,yPos+40,30, 30);    
    if(target.pace>actual.pace) { fill(255,0,0); } else { fill(0,255,0); };
    rect(xPos+width-31,yPos+70,30, 30);    
    if(target.distance>actual.distance) { fill(255,0,0); } else { fill(0,255,0); };
    rect(xPos+width-31,yPos+100,30, 30);    
    if(target.avgpace>actual.avgpace) { fill(255,0,0); } else { fill(0,255,0); };
    rect(xPos+width-31,yPos+130,30, 30);    
    if(target.speed>actual.speed) { fill(255,0,0); } else { fill(0,255,0); };
    rect(xPos+width-31,yPos+160,30, 30);    
    
    //line
    line(xPos+width/2+60,yPos, xPos+width/2+60,height);
    line(xPos+140,yPos, xPos+150,height);
    line(width-31,yPos, width-31,height);
  }
}
