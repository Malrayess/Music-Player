import processing.sound.*;

//CS10 Music Player

//Variables go here  

int totalSongs = 12;
SoundFile[] song = new SoundFile[totalSongs];
int indexSong = 0;
String[] songNames = {"Mesut Kurtis - Adnani", "Mesut Kurtis - Alhamdu Lillah", "Mesut Kurtis - Assalatu Wassalamu", "Mesut Kurtis - Ataytu Bithanbi", "Mesut Kurtis - Burdah", "Mesut Kurtis - Convey My Greetings", "Mesut Kurtis - Du'aa", "Mesut Kurtis - Farha", "Mesut Kurtis - Ghar Hira", "Mesut Kurtis - Rouhi Fidak", "Mesut Kurtis - Tabassam (Smile)", "Mesut Kurtis - Ya Man Bihali"};

boolean start = false;
boolean play = false;
boolean prev = false;
boolean next = false;

int playX = 275;//x coordinates for play button
int playY = 250;//y coordinates for play button

int prevX = 175;//x coordinates for prev button
int prevY = 250;//y coordinates for prev button

int nextX = 375;//x coordinates for next button
int nextY = 250;//y coordinates for next button

int screenX = 550/4;//x coordinates for screen
int screenY = 300/4;//y coordinates for screen

float volLineX = 50; //volume slider coordinates, floats to get volume information from them
float volLineY = 165;
float volDotX = 50;
float volDotY = 140;
float vol = 0.9; //current volume level, 0 - 1

PFont seg; //creates font

void setup () {
  size (550, 300); //frame size
  fill (#D80413);
  rect (0, 0, 550, 300); //background
  fill (#D80413);

  fill (0);
  rect(500, 0, 50, 50); //exit button 

  //Volume bar


  fill(#645A5B);
  ellipse (playX, playY, 100, 100); //play button
  fill(#D80413);
  ellipse (playX, playY, 75, 75); //play button

  fill(#645A5B);
  ellipse (prevX, prevY, 75, 75); //prev button
  ellipse (nextX, nextY, 75, 75); //skip button

  //triangle parts
  fill(#080808); 
  triangle (playX + 20, playY + 0, playX - 10, playY + 20, playX - 10, playY - 20); //play triangle part
  triangle (prevX - 20, prevY + 0, prevX + 10, prevY + 20, prevX + 10, prevY - 20); //prev triangle part
  triangle (nextX + 20, nextY + 0, nextX - 10, nextY + 20, nextX - 10, nextY - 20); //next triangle part

  song[0] = new SoundFile(this, "Mesut Kurtis - Adnani.mp3");
  song[1] = new SoundFile(this, "Mesut Kurtis - Alhamdu Lillah.mp3");
  song[2] = new SoundFile(this, "Mesut Kurtis - Assalatu Wassalamu.mp3");
  song[3] = new SoundFile(this, "Mesut Kurtis - Ataytu Bithanbi.mp3");
  song[4] = new SoundFile(this, "Mesut Kurtis - Burdah.mp3");
  song[5] = new SoundFile(this, "Mesut Kurtis - Convey My Greetings.mp3");
  song[6] = new SoundFile(this, "Mesut Kurtis - Du'aa.mp3");
  song[7] = new SoundFile(this, "Mesut Kurtis - Farha.mp3");
  song[8] = new SoundFile(this, "Mesut Kurtis - Ghar Hira.mp3");
  song[9] = new SoundFile(this, "Mesut Kurtis - Rouhi Fidak.mp3");
  song[10] = new SoundFile(this, "Mesut Kurtis - Tabassam (Smile).mp3");
  song[11] = new SoundFile(this, "Mesut Kurtis - Ya Man Bihali.mp3");
}

void draw() {
  if (start == false) {
    fill(#FFFFFF);
    rect (screenX, screenY, 275, 100); //screen

    fill(#645A5B);
    seg = createFont("BritannicBold-48.vlw", 17.0); //assigns the font
    textFont(seg, 17);
    text(songNames[indexSong], screenX + 3, screenY + 50); //song name

    strokeWeight(4);
    stroke(0);
    line (volLineX, volLineY, volLineX, volLineY - 80);
    fill(255);
    line (volLineX, volLineY, volDotX, volDotY);
    noStroke();
    ellipse(volDotX, volDotY, 13, 13);
  }

  if (mousePressed) {
    if (((mouseX > volDotX - 12) && (mouseX < volDotX + 12)) && ((mouseY > volDotY - 80) && (mouseY < volDotY + 80))) { //if the mouse is using the volume slider
      volChange();
    }
  }
}

void volChange() { //function to move the volume slider
  if ((mouseY > volLineY) && (mouseY < volLineY + 160)) { //move to mouseY as long as it doesn't go off of the line
    volDotY = mouseY;
  }
  vol = ((volDotY - volLineY) / 160); //sets the volume variable based on the position of the volume knob  
  song[indexSong].amp(vol);
}

void mousePressed() {
  if (mouseX>=500 && mouseX <=550 && mouseY>=0 && mouseY<=50) {  //exit button
    exit ();
  }

  if (mouseX>=playX-50 && mouseX<=playX+50 && mouseY>=playY-50 && mouseY<= playY+50) {
    if (play == false) {
      play = true;
      song[indexSong].play();//plays song
    } else {
      play = false;
      song[indexSong].stop();//stops song
    }
  }
  if (mouseX>=prevX-50 && mouseX<=prevX+50 && mouseY>prevY-50 && mouseY<=prevY+50) {
    if (prev == false) {  //prev song button
      if (indexSong<=0) {
        song[11].play();
      } else {
        song[indexSong].stop();
        indexSong = indexSong - 1;
        song[indexSong].play();
      }
    }
  }
  if (mouseX>=nextX-50 && mouseX<=nextX+50 && mouseY>nextY-50 && mouseY<=nextY+50) {
    if (next == false) {  //next song button
      if (indexSong>10) {
        indexSong = 0;
        song[indexSong].play();
      } else {
        song[indexSong].stop(); 
        indexSong = indexSong + 1;
        song[indexSong].play();
      }
    }
    println(indexSong);
  }
}