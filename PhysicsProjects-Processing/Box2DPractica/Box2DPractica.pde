import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*; 
import org.jbox2d.collision.shapes.*; 
import org.jbox2d.collision.shapes.Shape; 
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*; 
import org.jbox2d.dynamics.contacts.*;


Surface surf;
Box2DProcessing box2d;
Car car;

Rueda rueda;
PImage sky; 

void setup() {
  size(1100,800);

  box2d = new Box2DProcessing(this);
  //Incializa el mundo
  box2d.createWorld();
  //Carga una imagen para luego utilizar de fondo
  sky = loadImage("sky.png");
  sky.resize(1100,800);
  
  //Inicializamos nuestras dos clases
  surf=new Surface();
  car=new Car();
}

void draw() {
    background(sky);
    //ponemos tiempo en el mundo box2d para que se muevan los objetos dinamicos
    box2d.step();
    //ponemos gravedad en el mundo box2d
    box2d.setGravity(0, -10);
    
    //Mostramos el suelo y el coche en el mundo
    surf.display();
    car.displayWholeCar();
    
  
}
