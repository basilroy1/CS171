PImage gamebackground;
int x;
int x1;
int y1;
int y;
int w;
int h;
int xdirection;
int ydirection;
int scoreLeft=0;
int scoreRight=0;
int winScore = 2;

int paddleXLeft;
int paddleYLeft;
int paddleW;
int paddleH;
int paddleSpeed;//paddle speed
int rectangleX;
int rectangleY;

int paddleXRight;
int paddleYRight;

boolean goingupLeft;
boolean goingdownLeft;

boolean goingupRight;
boolean goingdownRight;

import ddf.minim.*;
import ddf.minim.ugens.*;

Minim minim;
AudioOutput out;

AudioPlayer player;
AudioPlayer player1;
AudioPlayer player2;


void setup()
{
  size(500,500);
  gamebackground= loadImage("Game Background-14.png");
  background(0);
 
  
  minim = new Minim(this);
  player =minim.loadFile( "PacMan - Original.mp3");
  player1 =minim.loadFile( "Super Mario Bros. Music - Game Over.mp3");
  player2 =minim.loadFile( "Ding - Sound.mp3");
  player.play();
 
  out = minim.getLineOut();

  x=width/2;
  y=height/2;
  x1=width/2;
  y1=height/2;
  w=20;
  h=20;
  xdirection=2;
  ydirection=3;
  
  rectMode(CENTER);
  paddleXLeft = 13;
  paddleYLeft = height/2;
  
  paddleXRight = width-13;
  paddleYRight = height/2;
  
  rectangleX=6;
  rectangleY= 180;
   
  paddleW =30;
  paddleH=100;
  paddleSpeed = 5; //speed at which paddle goes up and dwon
  
}
void draw()
{
  background(0);
  image(gamebackground,0,0);
 
  drawBall();
  
  moveBall();
  
  ballBoundaries();
 
  drawPaddle();
 
  movePaddle();
 
  stopPaddle();
 
  ballbounceofPaddle();
 
  scoring();
 
  gameOver();
 
  restart();
  
  rectangles();
  stroke(170);
  fill(0,255,0);
  line(28,height,28,0);
  line(472,height,472,0);
  
}
  
void rectangles()
{
   fill(random(40,160));//,random(100,255),random(150,255));
 //  rect(x1,y1,rectangleX,rectangleY);
    rect(250,20,6,20);
    rect(250,50,6,20);
     rect(250,80,6,20);
      rect(250,110,6,20);
       rect(250,140,6,20);
        rect(250,170,6,20);
         rect(250,200,6,20);
          rect(250,230,6,20);
           rect(250,260,6,20);
            rect(250,290,6,20);
             rect(250,320,6,20);
              rect(250,350,6,20);
               rect(250,380,6,20);
                rect(250,410,6,20);
                 rect(250,440,6,20);
                  rect(250,470,6,20);
                   rect(250,500,6,20);
                    rect(250,530,6,20);
                   
   //if(x1-rectangleX/2<x1+rectangleX/2 && y1-rectangleY/2<y1+rectangleX/2)
   //{
   //  xdirection=-xdirection;
   //}
   
}

void gameOver()
{
  if(scoreLeft==winScore)
 { 
  
   player1.play();
   fill(255,255,0);
   text("GAME OVER",160,200);
   text("Click Here to Restart",120,240);
   player.loop();
 
}

 else if(scoreRight==winScore)
 {
    
    player1.play();
    fill(255,255,0);
    text("GAME OVER",160,200);
    text("Click Here to Restart",120,240);
    player.loop();
    
 }
}
 void restart()
 {
 if(mousePressed)
 {
   xdirection=xdirection;
   ydirection=ydirection;
   scoreLeft=0;
   scoreRight=0;

 }
}


void scoring()
{
  fill(0);
  rect(100,30,180,30);
  fill(255,255,0);
  text("Player1",35,40,50);
  text(scoreLeft,30,100,50);
  
  
  fill(0);
  rect(400,30,180,30);
  fill(200,50,90);
  text("Player2",350,40,50);
  text(scoreRight,width-40,100,50);
    
  
}

void drawPaddle()
{
  textSize(30);

  fill(0,255,0);
  rect(paddleXLeft,paddleYLeft,paddleW,paddleH);
          //X          Y          width   height
  fill(0,0,255);
  rect(paddleXRight,paddleYRight,paddleW,paddleH);
  
  
}

void stopPaddle()
{
  // for stoping it from going upLeft
  if(paddleYLeft-paddleH/2<0)
  {
    paddleYLeft = paddleYLeft + paddleSpeed;
  }
  //for going down for left paddle
  if(paddleYLeft+paddleH/2>height)
  {
    paddleYLeft = paddleYLeft - paddleSpeed;
  }
  
  if(paddleYRight-paddleH/2<0)
  {
    paddleYRight = paddleYRight + paddleSpeed;
  }
  //for going down for right paddle
  if(paddleYRight+paddleH/2>height)
  {
    paddleYRight = paddleYRight - paddleSpeed;
  }
  
}

void ballbounceofPaddle()
{
  if(x -w/2 <paddleXLeft+paddleW/2 && y - h/2 <paddleYLeft+paddleH/2 && y + h/2 >paddleYLeft-paddleH/2  ) // ball bounces of the x value of paddle
  {
    player2.loop();
    fill(random(90,200));//,random(150,255),random(100,255));
    rect(paddleXLeft,paddleYLeft,paddleW,paddleH);
    xdirection=-xdirection;
  }
  
 else if(x +w/2 >paddleXRight-paddleW/2 && y - h/2 <paddleYRight+paddleH/2 && y + h/2 >paddleYRight-paddleH/2  ) // ball bounces of the x value of paddle
  {
    player2.loop(); // ding noise
    fill(random(40,150));//random(40,255),random(120,255));
    rect(paddleXRight,paddleYRight,paddleW,paddleH);
    xdirection=-xdirection;
  }
  
  
}
  
void movePaddle()
{
  if(goingupLeft)
  {
    paddleYLeft = paddleYLeft - paddleSpeed;
  }
  if(goingdownLeft) 
  {
  paddleYLeft = paddleYLeft + paddleSpeed;
}
  if(goingupRight)
  {
    paddleYRight = paddleYRight - paddleSpeed;
  }
  if(goingdownRight) 
  {
  paddleYRight = paddleYRight + paddleSpeed;
}
}

void drawBall()
{
  fill(255,0,0);
  ellipse(x,y,w,h);
}
void moveBall()
{
  x=x+xdirection;
  y=y+ydirection;
}

  void ballBoundaries()
{
      if(x>width-10)
  {
    
    xdirection=-xdirection;
    scoreLeft++;
  }
  
  else if(x<0 +10)
  {
   xdirection = -xdirection;
  scoreRight++;
  }
  if(y>height-10)
  {
    ydirection = -ydirection;
  }
  else if(y<0 +10)
  {
    ydirection=-ydirection;
  } 
}

void keyPressed()
{
  if(key== 'w' || key=='W')
  {
      
    goingupLeft=true;//moves up if pressed w or W
  }
  
   if(key== 's' || key=='S')
  {
 
    goingdownLeft=true;
  }
  
   if(keyCode==UP)
  {
    
    goingupRight=true;
  }
  
   if(keyCode==DOWN)
  {
          
    goingdownRight=true;
  }
  
  
}

void keyReleased()
{
   if(key== 'w' || key=='W')
  {
   
    goingupLeft=false;
  }
  
   if(key== 's' || key=='S')
  {
   
    goingdownLeft=false;
  }
  
  if(keyCode==UP)
  {
   
    goingupRight=false;
  }
  
   if(keyCode==DOWN)
  {
 
    goingdownRight=false;
  }
  
}
  