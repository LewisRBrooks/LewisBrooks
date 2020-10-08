import processing.sound.*;
FFT fft;
SoundFile SongOne, SongTwo, SongThree;
String SongOneMeta = "[1] Elderbrook & Rudimental - Something About You", SongTwoMeta = "[2] George The Poet & Maverick Sabre - Follow The Leader", SongThreeMeta = "[3] ARTAN - Brok£n";
String currentSongMeta;
SoundFile currentSong;
boolean isPlaying;
int NUM_BANDS = 32;
float d;
float spin = 0;

void setup()
{
  size(1280, 720, P3D);
  loadSongs();

  fft = new FFT(this, NUM_BANDS);
  fft.input(currentSong);
}

void draw()
{
  background(30, 30, 120, 220);
  fft.input(currentSong);
  fft.analyze();  
  playPause();
  translate(width/2, height/2, 0);
  rotateX(radians(70));
  if (isPlaying) {
    if (currentSong == SongOne) {
      rotateZ(radians(spin = 2.5 + spin));
    }
    if (currentSong == SongTwo) {
      rotateZ(radians(spin = .7 + spin));
    }
    if (currentSong == SongThree) {
      rotateZ(radians(spin = 3.5 + spin));
    } else
      rotateZ(radians(spin));
  }
  println(spin);
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

void nowPlaying() {
}

void visualizer() {
  stroke(0, 255, 255);
  fill(0, 200, 200);
  lights();
  for (int m=0; m<fft.spectrum.length*0.4; m=m+1)
  {
    for (float i=0; i<400; i = i + 20) {
      for (float j=0; j<400; j = j + 20) {
        pushMatrix();
        translate(i, j, fft.spectrum[m]);
        box(15, 15, map(fft.spectrum[m], -0.001, 1, 1, 150));
        popMatrix();
      }
    }
  }
}
