class Mover {

  PVector location, location2, update_location, velocity, acceleration, v, init_pos, v0;
  float mass, angulo, vx, vy, g;
  
  // Constructor de la primera bola --> Newton
  Mover(float m, float x , float y, float v0, float angle) {
    mass = m;
    location = new PVector(x,y);
    velocity = new PVector(v0*cos(radians(angle)), -v0*sin(radians(angle)));
    acceleration = new PVector(0,0);
  }
  // Constructor segunda bola --> analitica
  Mover(float x , float y, float v0, float angle) {
    // Inicializamos la velocidad igual que en la solucion a partir de Newton con v0 y el ángulo
    vx = v0 * cos(radians(angle));
    vy = -v0 * sin(radians(angle));
    location2 = new PVector(x,y);
    init_pos = new PVector(x,y);
    g = 9.8;
  }
  
  // Aplicamos 2a ley de Newton
  void applyForce(PVector force) {
    PVector f = PVector.div(force,mass);
    acceleration.add(f);
  }
  
  // Actualizamos la posicion a través de la relacion acceleracion, velocidad y localizacion
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }
  
  //Mostramos por pantalla la bola 1, con la localizacion en cada momento
  void display() {
    stroke(0);
    fill(175);
    ellipse(location.x,location.y,30,30);
  }
  
  // Mostramos por pantalla la bola, con la localizacion en cada momento
  void display2(PVector pos) {
    stroke(0);
    fill(255,0,0);
    ellipse(pos.x,pos.y,20,20);
  }
  
  // Funcion que calcula el movimiento de la bola 2 segun el tiempo
  PVector analitica(float t) {
    location2.x = init_pos.x + 10 * vx * t;
    location2.y = init_pos.y + (10 * vy * t + g/2 * t * t);
    
    return location2;
  }
  
  // Comprobamos si la bola sobrepasa los limites de la pantalla
  void checkEdges() {
    if (location.x > width) {
      location.x = width;
    } else if (location.x < 0) {
      location.x = 0;
    }
    if (location.y > height) {
      location.y = height;
    }
  }
}
