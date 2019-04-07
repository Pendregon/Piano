import ddf.minim.*;
import ddf.minim.ugens.*;

Minim minim;
AudioOutput out;

void setup(){
  size(350, 200);
  minim = new Minim(this);
  out = minim.getLineOut();
}

void draw(){
  drawPiano();
}

void drawPiano(){
  fill(255);
  for (int i=0;i<7;i++){
    rect(i*50,0,50,200);
    
  }
  fill(0);
  for (int i=0;i<6;i++){
    if(i<2 || i==3 || i==4 || i==5){
      rect(i*50+37.5,0,25,125);
      
    }
  } 
}

float notePressed(){
  if(mouseX > 37.5 && mouseX < 62.5 && mouseY < 125)return 277.183;
  else if(mouseX > 87.5 && mouseX < 112.5 && mouseY < 125)return 311.127;
  else if(mouseX > 187.5 && mouseX < 212.5 && mouseY < 125)return 369.994;
  else if(mouseX > 237.5 && mouseX < 262.5 && mouseY < 125)return 415.305;
  else if(mouseX > 287.5 && mouseX < 312.5 && mouseY < 125)return 466.164;
  else if(mouseX < 50)return  261.626;
  else if(mouseX < 100)return 293.665;
  else if(mouseX < 150)return 329.628;
  else if(mouseX < 200)return 349.228;
  else if(mouseX < 250)return 391.995;
  else if(mouseX < 300)return 440.000;
  else if(mouseX < 350)return 493.883;
  return 0.0;
}

void mousePressed(){
  out.playNote(0.0, 1.0, new SineInstrument(notePressed()));
}

class SineInstrument implements Instrument{
  Oscil wave;
  Line  ampEnv;
  
  SineInstrument( float frequency ){
    wave   = new Oscil( frequency, 0, Waves.SINE );
    ampEnv = new Line();
    ampEnv.patch( wave.amplitude );
  }
  void noteOn( float duration ){
    ampEnv.activate( duration, 0.5f, 0 );
    wave.patch( out );
  }
  void noteOff(){
    wave.unpatch( out );
  }
}
