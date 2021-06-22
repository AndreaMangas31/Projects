boolean choque;
ArrayList <PVector> recorrido = new ArrayList<PVector>();
PImage bg;
PFont f;
String typing = "";
String opcion = "";
PVector init, gravity, v;;
float time, x, y, m;

Mover m1;
Spring spring;

void setup() {
  size(900,900);
  bg = loadImage("pistaBasquet.jpg");
  bg.resize(900,900);
  
  // *****Aqui se introducen los datos iniciales*******
  // Posición
  x = 400;
  y = 350;
  // Masa 
  m = 1.0;
  // Velocidad inicial
  v = new PVector(0,0);
  
  f = createFont("Arial", 16);
  m1 = new Mover(m, x, y, v);
  gravity = new PVector(0, 0.1);
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
  //Creamos una pantalla donde podamos introducir la opcion que queremos
  fill(255);
  rect(200, 200, 550, 250);
  fill(0);
  textSize(20);
  text("Enter your option:(a(rigid), b(analitica) o c(numérica) \nClick enter when you are ready", 220, 300); 
  textSize(25);
  //Aqui introducimos si es la opcion a, b, c y la guardamos
  text("Input: " + typing, 350, 400, width - 20, 60);
}

void optionA() {
  background(bg);
  // Aplicamos fuerza de gravedad
  m1.applyForce(gravity);
  // Actualizamos las posiciones de la pelota
  m1.update();
  // La mostramos por pantalla
  m1.display();
  // Miramos si toca los límites y la hacemos rebotar
  m1.checkEdgesRigid();
}

void optionB() {
  background(bg);
  float time = millis() / 1000;
  
  //Para ver mejor la distorsión de la bola activa la siguiente linia de codigo del frameRate
  //frameRate(15);
  
  // Aplicamos gravedad
  m1.applyForce(gravity);
  // Miramos si toca los límites y la hacemos rebotar perdiendo velocidad
  m1.checkEdges();
  
  // Tenemos que hacer que vaya perdiendo energia potencial y cinetica
  PVector energies = m1.energies();
  float Ecin = energies.x;
  float Epot = energies.y;
 
  // Caluclamos analíticamente con la fórmula del movimiento harmónico simple el desplazamiento x
  m1.harmonicSimple(time, Ecin, Epot);
  // Con un threshold hacemos parar la pelota cuando la velocidad sea muy baja
  m1.controlVelocity();
  // Actualizamos las posiciones de la pelota
  m1.update();
}

void optionC() {
  background(bg);
  //Para ver mejor la distorsión de la bola activa la siguiente linia de codigo del frameRate
  frameRate(15);
  // Creamos el spring 
  spring = new Spring(m1.location.x + 50, m1.location.y + 100, 50);
  
  // Aplicamos gravedad
  m1.applyForce(gravity);
  // Calculamos la fuerza spring para la molla interior a la pelota 
  spring.connect(m1);
  // Tenemos que hacer que vaya perdiendo energia potencial y cinetica
  m1.energies();
  // Con un threshold hacemos parar la pelota cuando la velocidad sea muy baja
  m1.controlVelocity();
  // Actualizamos las posiciones de la pelota
  m1.update();
  
  // Mostramos la molla
  spring.display();
  spring.displayLine(m1);
 
  // Miramos si toca los límites y la hacemos rebotar perdiendo velocidad
  m1.checkEdges();
}

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
