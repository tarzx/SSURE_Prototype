import controlP5.*;

//Declare
//ControlP5 jControl;
//int rColor = 100, gColor=100, bColor =100;
LineGraph line;
BarGraph bar;
Pace pc;
ButtonLine btl;
ButtonGraph btg;
ButtonPace btp;
ButtonPlay bp;
ButtonStop bs;
ButtonPause bpa;
ButtonPlay bpp;
ButtonRestart brs;
Duration dt;
Distance ds;
Tracking tck;
Menu mn;
Result rt;

Information target;
Information actual;

char mode = 'P';
char work = 'I';

void setup() {
  size(400,640);
  
  //initialise
  //jControl = new ControlP5(this);
  background(0);
  
  //Slider s1 = jControl.addSlider("rColor", 0, 255, 100, 10, 10, 255, 30);
  //Slider s2 = jControl.addSlider("gColor", 0, 255, 100, 10, 110, 255, 30);
  //Slider s3 = jControl.addSlider("bColor", 0, 255, 100, 10, 210, 255, 30);
  fill(50);
  noStroke();
  rect(0, 0, width, 30);
  fill(255);
  textSize(24);
  text("SSURE", 10, 24);
  
  line = new LineGraph(0,30);
  bar = new BarGraph(0,30);
  pc = new Pace(0,30);
  dt = new Duration(20, 35+height/3.2);
  ds = new Distance(20,55+height/3.2);
  btl = new ButtonLine(width-80,60);
  btg = new ButtonGraph(width-80,110);
  btp = new ButtonPace(width-80,160);
  bp = new ButtonPlay(0,50+height/3.2, false);
  bs = new ButtonStop(width/2,90+height/3.2);
  bpa = new ButtonPause(0,90+height/3.2);
  bpp = new ButtonPlay(0,90+height/3.2, true);
  brs = new ButtonRestart(0,height-100);
  tck = new Tracking(0,220+height/3.2);
  mn = new Menu(0,150+height/3.2);
  target = new Information();
  actual = new Information();
}

void draw() {
  clearScreen();
  if(work == 'P') {
    if(mode == 'L') {
      line.run();
    } else if(mode == 'G') {
      bar.run();
    } else if(mode == 'P') {
      pc.run();
    } 
    dt.run();
    ds.run();
    tck.run();
    btl.run();
    btg.run();
    btp.run();
    bs.run();
    bpa.run();
  } else if(work == 'I') {
    dt.restart();
    ds.restart();
    line.restart();
    bar.restart();
    pc.restart();
    if(mode == 'L') {
      line.pause();
    } else if(mode == 'G') {
      bar.pause();
    } else if(mode == 'P') {
      pc.pause();
    } 
    btl.run();
    btg.run();
    btp.run();
    bp.run();
    mn.run();
  } else if(work == 'S') {
    //stop
    actual.setDuration(dt.time);
    actual.setDistance(ds.move);
    actual.setPace(pc.numPace);
    rt = new Result(0,30,actual, target);
    rt.run();
    brs.run();
  } else if(work == 'F') {
    if(mode == 'L') {
      line.pause();
    } else if(mode == 'G') {
      bar.pause();
    } else if(mode == 'P') {
      pc.pause();
    } 
    dt.pause();
    ds.pause();
    tck.pause();
    btl.run();
    btg.run();
    btp.run();
    bpp.run();
    bs.run();
  }
  //background(rColor,gColor,bColor);
}

void mousePressed() {
  if(btl.rectOver) {
    mode = 'L';
  } else if(btg.rectOver) {
    mode = 'G';
  } else if(btp.rectOver) {
    mode = 'P';
  } else if((work == 'P' || work == 'F') && bs.rectOver) {
    work = 'S';
  } else if(work == 'S' && brs.rectOver) {
    work = 'I';
  } else if(work == 'P' && bpa.rectOver) {
    work = 'F';
  } else if(work == 'F' && bpp.rectOver) {
    work = 'P';
  } else if(work == 'I' && bp.rectOver) {
    work = 'P';
    target.setDuration(mn.getDuration());
    target.setDistance(mn.getDistance());
    target.setPace(mn.getPace());
  } else if(work == 'I' && mn.OverM1) {
    if(mn.mode=='E') { 
      mn.mode = 'C'; 
    } else { 
      mn.mode = 'E'; 
    }
  } else if(work == 'I' && mn.OverM2) {
    if(mn.mode=='T') { 
      mn.mode = 'C';
    } else { 
      mn.mode = 'T'; 
    }
  } else if(work == 'I') {
    mn.setBar();
  }
}

void clearScreen() {
  fill(0);
  noStroke();
  rect(0, 30, width, height);
}

