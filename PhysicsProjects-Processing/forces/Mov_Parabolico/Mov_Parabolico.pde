Mover m1, m2;
ArrayList <PVector> recorrido = new ArrayList<PVector>();
float time, angle, v0, x, y, m;
PVector init, pos, pos2, gravity;

void setup() {
  size(900,900);
  
  // Aqui se introduce la velocidad inicial, el angulo, la posicion inicial i la masa
  angle = 45;
  v0 = 10;
  x = 0;
  y = height - 0.1;
  m = 1;
  
  // Pasamos todas estas dadas a la clase para que lo gestione
  m1 = new Mover(m, x, y, v0, angle); //m1 --> es la bola afectada por la gravedad
  m2 = new Mover(x, y, v0, angle); //m2 --> es la bola que se calcula todo de forma analitica
  time = 0;
  gravity = new PVector(0, 0.1);
  init = new PVector(x, y);
}

// Funcion que utilizamos para mostrar la trayectoria de la analitica
void displayRecorrido() {
  // Guardamos las posiciones  de localizacion en una lista de vectores
  pos = m2.location2;
  recorrido.add(new PVector(pos.x,pos.y));
  // Por cada localizacion mostramos una elipse
  for (int i = 0; i < recorrido.size(); i++) {
    fill(255,0,0);
    noStroke();
    ellipse(recorrido.get(i).x, recorrido.get(i).y, 10, 10);
  } 
}

void draw() {
  background(255);
  // Tenemos que calcular el tiempo para que la forma analitica vaya cambiando respecto al tiempo
  time = millis() / 1000;
  // Aplicamos la fuerza de la gravedad sobre la primera bola
  m1.applyForce(gravity);
  // Actualizamos las posiciones
  m1.update();
  m1.display();
  m1.checkEdges();
  
  // Guardamos la posicion actualizada en cada momento 
  pos2 = m2.analitica(time);
  // Muestra la segunda bola en cada posicion
  m2.display2(pos2);
   
  // Si se encuentra la primera bola en la posicion maxima de la pantalla que vuelva a hacer el recorrido
  if(m1.location.y == height || m1.location.x == width) {
    m1 = new Mover(m, x, y, v0,  angle);
  }
  // Muestra el recorrido de la la segunda bola
  displayRecorrido();
}
