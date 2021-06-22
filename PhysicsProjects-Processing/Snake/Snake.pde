Mover control;
Mover control_cuc;
float pos_initial_x;
float pos_initial_y;
float pos_cuc_x;
float pos_cuc_y;
PVector pos;
PVector vel;
PVector acc;
PVector pos_cuc;
PVector vel_cuc;
PVector acc_cuc;
int size = 60;
ArrayList<Float> x = new ArrayList<Float>();
ArrayList<Float> y = new ArrayList<Float>();
boolean gameOver = false;
PImage cuc;
PImage bg;
int points = 0;
int time = 0;
PVector location;
float acc_x;
float acc_y;

void setup(){
   size(900,900);
   cuc = loadImage("cuc.png");
   bg = loadImage("bg.jpg");
   pos_initial_x = random(60,840);
   pos_initial_y = random(60,840);
   pos_cuc_x = random(50,850);
   pos_cuc_y = random(50,850);
   x.add(pos_initial_x);
   y.add(pos_initial_y);
   pos = new PVector(width / 2, height / 2);
   vel = new PVector(0, 0);
   acc = new PVector(0, 0);
   control = new Mover(pos,vel,acc);
   vel_cuc = new PVector(0, 0);
   acc_x = random(-0.8,0.8);
   acc_y = random(-0.8,0.8);
   acc_cuc = new PVector(acc_x,acc_y);
}

void draw() {
    bg.resize(900, 900);
    background(bg);
    time = 60 - millis()/1000;
    if (time == 0) {
      gameOver = true;
    }
    if (!gameOver) {
      cuc.resize(50, 50);
      pos_cuc = new PVector(pos_cuc_x, pos_cuc_y);
      control_cuc = new Mover(pos_cuc,vel_cuc,acc_cuc,60);
      location = control_cuc.moveWorm();
      image(cuc, location.x, location.y);
      pos = control.followMouse();
      textSize(26);
      fill(255);
      text("Food: " + points, 20, 20, width - 20, 60);
      text("Time: " + time, 20, 60, width - 20, 60);
      fill(56, 168, 50);
      for (int i = 0; i < x.size(); i++) {
        ellipse(x.get(i), y.get(i), size, size);
      }
      if (frameCount % 8 == 0) {
        x.add(0, pos.x);
        y.add(0, pos.y);
        if (pos.x >= location.x && pos.x <= location.x + 50 && pos.y >= location.y && pos.y <= location.y + 50) {
          pos_cuc_x = random(50,850);
          pos_cuc_y = random(50,850);
          acc_x = random(-0.8,0.8);
          acc_y = random(-0.8,0.8);
          acc_cuc = new PVector(acc_x,acc_y);
          points++;
        } else {
          x.remove(x.size()-1);
          //y.remove(x.size()-1);
        }
      }
    } else {
      fill(218, 247, 166);
      rect(225, 225, 450, 450);
      fill(0);
      textSize(46);
      text("Time is out!", 315, 355, width - 20, 60);
      textSize(30);
      text("You have eaten " + points + " worms", 270, 550, width - 20, 60);
    }  
}
