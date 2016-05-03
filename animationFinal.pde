
int sunPosY = 100;
int sunPosX = 100;
int sunChangeY = 2;
int sunChangeX = 2;
int color_num = 50;
int ROBOT_X = 50;
int buttPosY = 75; // position the behind
int buttChange = 1; //The rate at which we Twerk
int armPosY = 30;
int armChange = 5;
int handChange = 5;
int legPosX = 10;
int legChange = 5;
int neckPosY = 0;
int leftKnee;
int rightKnee;
int leftShoulder;
int rightShoulder;
int headY = -15;
int rHandX = 100;
int rHandY = 10;
int lHandX = 0;
int lHandY = 30;



void setup()
{
size (1500, 750);
smooth();
frameRate(15);
strokeWeight(1);
}

void draw() {
  strokeWeight(1);
  background(255 - (sunPosY/6)); // Background gets darker as sun moves lower
  sun();
  drawBackground();
  drawRobot();
  updateSun();
  if(sunPosY > height) {
    action();
  }
  else {
    update();
  }
}

//draw robot - uses all draw body part methods
void drawRobot() {
  fill(0);
  float mX = mouseX - ROBOT_X;
  translate(mX, 400);
  drawHead();
  drawBody();
  drawLeftArm();
  drawRightArm();
  drawLeftLeg();
  drawRightLeg();
  noFill();

}

//draws body
void drawBody() {
  noFill();
  pushMatrix();
  translate(200, 150);
  strokeWeight(50);
  bezier(0, neckPosY, 30, 25, 50, 75, 0, buttPosY);
  strokeWeight(1);
  popMatrix();
}

//draws head
void drawHead() {
 pushMatrix();
 //fill(0);
 translate(200, 100);
 bezier(0, 0, 10, 10, 10, 20, 0, 50);
 ellipse(0, headY, 60, 60);//head
 noFill();
 popMatrix();
}

//draws left arm
void drawLeftArm() {
  pushMatrix();
  noFill();
  strokeWeight(10);
  translate(100, 150);
  bezier(lHandX, lHandY, 15, 0 - armPosY, 30, -10, 100, 10);
  popMatrix();
}

//draws right arm
void drawRightArm() {
  pushMatrix();
  strokeWeight(10);
  translate(250, 140);
  bezier(0, 30, 50, armPosY, 30, 10, rHandX, rHandY);
  popMatrix();
}

//draws the left leg  
void drawLeftLeg() { 
  pushMatrix();
  translate(200, 250);
  bezier(0, 0, -15, 0, 30, 15, 10 - legPosX, 75);
  popMatrix();
}

//draws the rght leg
void drawRightLeg() { 
  pushMatrix();
  translate(230, 250);
  bezier(0, -5, -15, 0, 30, 15, legPosX, 75);
  popMatrix();
}


//Sets up the background
void drawBackground() {
  fill(130);
  rect(0, 600, 1500, 150);
  fill(203, 185, 41);
  rect(0, 670, 1500, 10);
  drawStreetLights();
}

//Does the butt drop and reup
void action() {
  if(rHandY > -40) {
    rHandY -= 2;
    rHandX -= 3;
    lHandY -= 2;
    lHandX += 2;
  }
  if(buttPosY > 72 && buttPosY < 120) {
    buttPosY += 2;
  }
  if(sunPosY < height + 4) {
    buttPosY = 75;
  }
}
//updates the movements of body parts
void update() {
  buttPosY += buttChange;
  armPosY += armChange;
  legPosX += legChange;
  rHandY += handChange;
  
  if (buttPosY > 83 || buttPosY < 73) {
    buttChange = -buttChange;
    buttPosY += buttChange;
  }
  if (armPosY > 60 || armPosY < 0) {
    armChange = -armChange;
    armPosY += armChange;
  }
  if (rHandY > 60 || rHandY < 0) {
   handChange = -handChange;
   rHandY += handChange;
  }
  if (legPosX > 30 || legPosX < -10) {
    legChange = -legChange;
    legPosX += legChange;
  }
}

// Create a sun like object that cycles through colors. Sun movies diagonally on screen.
//When going low enough backround gets darker
void sun() {
  pushMatrix();
  translate(sunPosX, sunPosY);
  
  for (float i = 0; i < 200; i++) {
    rotate(0.3);
    if (color_num == 200) {
      color_num = 0;
    }
    fill(255 - color_num, 100 - (color_num % 20), color_num);//swaps colors
    ellipse(-i, 0, 10, 10);
  } 
  color_num ++;
  noFill();
  popMatrix();
}

//Keeps the sun within the bounds of screen while moving.
//allows sun to go 100 further in the y direction to give sunset feel 
void updateSun() {
  sunPosX += sunChangeX;
  sunPosY += sunChangeY;
  
  if (sunPosY > (height + 100) || sunPosY < 0)
  {
    sunChangeY = -sunChangeY;
    sunPosY += sunChangeY;
  }
  if (sunPosX > width || sunPosX < 0)
  {
    sunChangeX = -sunChangeX;
    sunPosX += sunChangeX;
  }
}


// Draws streetlamps and streetlight in background
void streetLights(int x, int y) {
  pushMatrix();
  translate(x, y);
  rotate(radians(-25));
  fill(75);
  rect(45, 40, 100, 10);// middle/slanted section of light
  rotate(radians(25));
  rect(50, 15, 30, 400);//large pole of light
  rect(140, -30, 50, 25);//light box
  fill(252, 196, 110, sunPosY/6);//causes lights to be see through when suns up
  noStroke();
  triangle(135, 415, 165, -5, 230, 415); //street light
  noFill();
  popMatrix();
  stroke(1);
}

//Draws 5 stretlights in background
void drawStreetLights() { 
  for (int i = 20; i < 1500; i = i + 300) {
  streetLights(i, 200);
  }
}