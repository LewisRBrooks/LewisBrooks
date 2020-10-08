import processing.sound.*;
FFT fft;
SoundFile SongOne, SongTwo, SongThree;
String SongOneMeta = "[1] Elderbrook & Rudimental - Something About You", SongTwoMeta = "[2] George The Poet & Maverick Sabre - Follow The Leader", SongThreeMeta = "[3] ARTAN - Brok£n";
String currentSongMeta;
SoundFile currentSong;
boolean isPlaying;
int NUM_BANDS = 32;
float d;

void setup()
{
  size(1280, 720, P3D);
  loadSongs();

  fft = new FFT(this, NUM_BANDS);
  fft.input(currentSong);
}

void draw()
{
  background(30,30,120,220);
  fft.input(currentSong);
  fft.analyze();  
  playPause();
  translate(width/2, height/2, 0);
  rotateX(radians(-mouseY/5));
  rotateZ(radians(mouseX/4));
  translate(-200, -200, 0);
  visualizer();
}

void keyPressed()
{
  if (key == ' ')  // Toggle pause on or off.
  {
    if (isPlaying)
    {
      currentSong.pause();
      isPlaying = false;
    } else
    {
      currentSong.play();
      isPlaying = true;
    }
  }
  if (key == '1') {
    if (isPlaying) {
      currentSong.stop();
    }
    currentSong = SongOne;
    currentSong.play();
    isPlaying = true;
    currentSongMeta = SongOneMeta;
  }
  if (key == '2') {
    if (isPlaying) {
      currentSong.stop();
    }
    currentSong = SongTwo;
    currentSong.play();
    isPlaying = true;
    currentSongMeta = SongTwoMeta;
  }
  if (key == '3') {
    if (isPlaying) {
      currentSong.stop();
    }
    currentSong = SongThree;
    currentSong.play();
    isPlaying = true;
    currentSongMeta = SongThreeMeta;
  }
}

void loadSongs() {
  SongOne = new SoundFile(this, "Song1.wav");
  SongTwo = new SoundFile(this, "Song2.wav");
  SongThree = new SoundFile(this, "Song3.wav");
  currentSong = SongOne;
  currentSongMeta = SongOneMeta;
  currentSong.play();
  isPlaying = true;
}

void playPause() {
  String message;
  if (isPlaying)
  {
    message = "Playing [SPACE]";
  } else
  {
    message = "Paused [SPACE]";
  }
  text(message, 10, 20);
  text("Choose song via [1, 2, 3]", 10, height - 40);
  text("Current Song: " + currentSongMeta, 10, height - 20);
}

void visualizer() {
  stroke(0, 255, 255);
  fill(0, 200, 200);
  lights();
  for (int m=0; m<fft.spectrum.length; m=m+1)
  {
    for (float i=0; i<400; i = i + 20) {
      for (float j=0; j<400; j = j + 20) {
        //d = map(fft.spectrum[m], -0.001, 1, 1, 150);
        pushMatrix();
        translate(i, j, 0);
        box(15, 15, map(fft.spectrum[m]*0.4, -0.001, 1, 1, 150));
        popMatrix();
      }
    }
  }
}
