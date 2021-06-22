import java.util.Scanner;
Attractor earth;
Mover satellite;
boolean choque;
ArrayList <PVector> recorrido = new ArrayList<PVector>();
PImage bg;
PFont f;
String typing = "";
String opcion = "";
PVector aux, init;

void setup() {
  size(900,900);
  bg = loadImage("Space.png");
  bg.resize(900,900);
  f = createFont("Arial", 16);
  
  // Aqui se introduce la posicion inicial del satelite. Si se quiere cambiar la velocidad esta en Control en la clase Mover, en su constructor
  init = new PVector(width/2 + 70, height/2 - 100);
  
  // La posicion de la Tierra esta ya predefinida pero se puede cambiar en la clase Attractor en Control.
  earth = new Attractor();
  satellite = new Mover(init.x, init.y);
  choque = false;
  opcion = null;
}

void keyPressed() {
  // Si la tecla que retorna está pulsada, guardamos string en opcion
  if (key == '\n' ) {
    opcion = typing;
    typing = ""; 
  } else {
    // Concatenamos string
    typing = typing + key; 
  }
}

void initialScreen() {
  // Creamos una pantalla donde podamos introducir la opcion que queremos
  background(bg);
  fill(255);
  rect(225, 225, 450, 250);
  fill(0);
  textSize(20);
  text("Enter your option(a,b,c): \nClick enter when you are ready", 240, 300); 
  textSize(25);
  // Aqui introducimos si es la opcion a, b o c y la guarda
  text("Input: " + typing, 350, 400, width - 20, 60);
}

// Procedimiento que dibuja el recorrido del satelite
void dibujarRecorrido() {
  // Creamos un vector auxiliar para guardarnos la localizacion del satelite en cada momento
  PVector pos;
  // Cada cierto tiempo añadimos esta posicion que guardamos en una lista de vectores
  if(frameCount % 20 == 0) {
    pos = satellite.location;
    recorrido.add(new PVector(pos.x + 25, pos.y + 25));
  }
  // Recorremos la lista de vectores y vamos printando circulos en esas posiciones
  for (int i = 0; i < recorrido.size(); i++) {
    fill(255);
    ellipse(recorrido.get(i).x, recorrido.get(i).y, 6, 6);
  }
}

// OPCION A: Movimiento de un satelite en orbita atraido por un planeta
void optionA() {
  // Guardamos el resultado de si tenemos un choque o no para luego gestionarlo
  choque = satellite.choque(earth);
  
  //Calculamos la fuerza de atraccion de la tierra hacia el satelite y la aplicamos.
  PVector f = earth.attract(satellite,choque);
  satellite.applyForce(f);
   
  // Si no hay choque seguimos actualizando la velocidad, si en este caso hubiese un choque, el satelite quedaria quieto
  if(!choque) {
    satellite.update(satellite.velocity);
  }
  // Mostramos todo   
  earth.display();
  satellite.display();
  dibujarRecorrido();
}

// OPCION B: Movimiento de un satelite en orbita circular atraido por un planeta
void optionB() {
  choque = satellite.choque(earth);
  // Calculamos lo mismo que en la opcion A, la fuerza de atraccion
  PVector f = earth.attract(satellite,choque);
  satellite.applyForce(f);
  
  // Si el satelite se encuentra en su posicion principal, calculamos la velocidad 
  // que tendria que tener en esa posicion para que la orbita que defina sea una circular
  if(satellite.location.x == init.x && satellite.location.y == init.y) {
    aux = satellite.guessVelocity(earth);
  }
  // Vamos actualizando la posicion en funcion de esta velocidad
  satellite.update(aux);
  
  // Mostramos todo
  earth.display();
  satellite.display();
  dibujarRecorrido();
}

// Funcion  que nos permite mostrar los datos que debemos en la opcion C
void displayInfo() {
  // Nos pasa un PVector con todas las soluciones guardadas en x, y ,z
  PVector solutions = earth.guessSolutions(recorrido);
  textSize(20);
  // Mostramos resultado de la excentricitat
  text("e: " + solutions.x, 0, 800); 
  textSize(20);
  text("Tindrem les dades reals de l'orbita un cop acabi de fer una volta completa", 100, 40);
  // Mostramos resultado de la distancia minima
  text("Rmin:  " + solutions.y + "px", 0, 830);
  textSize(20);
  // Mostramos resultado de la distancia maxima
  text("Rmax: " + solutions.z + "px", 0, 850); 
}

// OPCION C: Satelite en orbita atraido por un planeta, pero calculado la e,rmax,rmin de esa orbita
void optionC() {
  // Calculamos y aplicamos la fuerza
  choque = satellite.choque(earth);
  PVector f = earth.attract(satellite,choque);
  satellite.applyForce(f);
  // Si no hay choque seguimos actualizando la velocidad igual que en el A
  if(!choque){
    satellite.update(satellite.velocity);
  }
  
  // Mostramos todo
  earth.display();
  satellite.display();
  dibujarRecorrido();
  // Añadimos el mostrar los resultados obtenidos de la orbita
  displayInfo();
}

// Procedimiento principal
void draw() {
  // Mostramos la pantalla inicial
  initialScreen();
  // Segun lo que valga la opcion que escogemos el programa hara una cosa o otra
  if(opcion != null) {
    background(bg);
    switch(opcion) {
      case "a":    
        optionA();
      break;
        
      case "b":
        optionB();
      break;
    
      case "c":
        optionC();
      break;
    
      default:
        initialScreen();
      break;
    }
  }
}
