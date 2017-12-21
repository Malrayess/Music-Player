import processing.sound.*;

//CS10 Music Player

//Variables go here  

boolean play = false;
boolean pressed = false;
int currentSong = 0;
int totalSongs = 12;
SoundFile[] song = new SoundFile[totalSongs];
String[] songNames = {"Mesut Kurtis - Adnani", "Mesut Kurtis - Alhamdu Lillah", "Mesut Kurtis - Assalatu Wassalamu", "Mesut Kurtis - Ataytu Bithanbi", "Mesut Kurtis - Burdah", "Mesut Kurtis - Convey My Greetings", "Mesut Kurtis - Du'aa", "Mesut Kurtis - Farha", "Mesut Kurtis - Ghar Hira", "Mesut Kurtis - Rouhi Fidak", "Mesut Kurtis - Tabassam (Smile)", "Mesut Kurtis - Ya Man Bihali"};

int songDurationM = 0; //how many minutes long the song is
int songDurationS = 0; //how many seconds long the song is, excluding minutes

float songStartMillis = 0; //used to find how far into the song the program is
int currentTimeM = 0; //how many minutes into the song the program is
int currentTimeS = 1; //how many seconds into the song the program is, excluding minutes

String songDurationDisplay = "0:00"; //used to display the length of the song
String currentTimeDisplay = "0:00"; //used to display how far into the song the program is

int playX = 275;
int playY = 250;

int prevX = 175;
int prevY = 250;

int nextX = 375;
int nextY = 250;

int screenX = 550/4;
int screenY = 300/4;

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

  fill(#FFFFFF);
  rect (screenX, screenY, 275, 100); //screen

  fill(#645A5B);
  seg = createFont("BritannicBold-48.vlw", 17.0); //assigns the font
  textFont(seg, 17);

  checkSongDuration();

  text(str(currentSong + 1) + songNames[currentSong], screenX, screenY + 43);//screen text
  text(songDurationDisplay, screenX + 241, screenY + 76); //length of song
  text(currentTimeDisplay, screenX, screenY + 76); //how far along into song
  text("-", screenX + 139, screenY + 76); //draws - between time values

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

  //Volume bar
  strokeWeight(4);
  stroke(0);
  line (volLineX, volLineY, volLineX, volLineY - 80);
  fill(255);
  line (volLineX, volLineY, volDotX, volDotY);
  noStroke();
  ellipse(volDotX, volDotY, 13, 13);

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

void playPauseMusic() { //function to play and pause the music when the play button is pressed
  if (play) { //if the music is supposed to be playing
    songStartMillis = millis() - (currentTimeS) * 1000;
    song[currentSong].jump(currentTimeS + (currentTimeM * 60));
    checkSongDuration();
  } else { //if the music is supposed to be stopped
    song[currentSong].stop(); //stops the music
  }
}

void endOfSong() {
if (currentSong == songs.length - 1) { //if the current song is the last one in the playlist
    currentSong = 0; //goes back to first song
  } else {
    currentSong += 1; //goes to next song
  }
  songs[currentSong].play(); //plays the song
  checkSongDuration();
  currentTimeM = 0; //these three lines of code are used to setup the program to count how far into the song the program is
  currentTimeS = 1;
  songStartMillis = millis();
}

void nextSong() { //function that goes to the next song when the next song button is pressed
  songs[currentSong].stop(); //stops the current song
  if (currentSong == songs.length - 1) { //check playPauseMusic() and endOfSong()
    currentSong = 0;
  } else {
    currentSong += 1;
  }
  songs[currentSong].play();
  checkSongDuration();
  currentTimeM = 0;
  currentTimeS = 1;
  songStartMillis = millis();
  play = true; //used so that the program can go to the next song if a song isn't playing
}

void draw() {
  if (mousePressed) {
    buttonPress();
  } else {
    pressed = false; //pressed boolean makes the code above run only once when the mouse is pressed
  }
  if (((songDurationM <= currentTimeM) && (songDurationS <= currentTimeS - 1)) && (play)) { //if the program is at the end of the song
    endOfSong();
  }
  checkSongTime(); //calls function to check how far along the song is
}

void buttonPress() {
  if (((mouseX > playX) && (mouseX < playX + 50)) && ((mouseY > playY) && (mouseY < playY + 50)) && !(pressed)) { //if the mouse pressed the play pause button
    if (play) {
      play = false;
    } else {
      play = true;
    }
    playPauseMusic();
    pressed = true;
  } else if (((mouseX > nextX) && (mouseX < nextX + 50)) && ((mouseY > nextY) && (mouseY < nextY + 50)) && !(pressed)) { //if the mouse pressed the next song button
    nextSong();
    pressed = true;
  } else if (((mouseX > prevX) && (mouseX < prevX + 50)) && ((mouseY > prevY) && (mouseY < prevY + 50)) && !(pressed)) { //if the mouse pressed the previous song button
    prevSong();
    pressed = true;
  } else if (((mouseX > volDotX - 12) && (mouseX < volDotX + 12)) && ((mouseY > volDotY - 12) && (mouseY < volDotY + 12))) { //if the mouse is using the volume slider
    volChange();
  }
}