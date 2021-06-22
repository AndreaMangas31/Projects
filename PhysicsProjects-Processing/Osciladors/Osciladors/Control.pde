class Mover {
  
  PVector location, location2, update_location, velocity, acceleration, v, init_pos, v0;
  float mass, angulo, vx, vy, g, Ecin, Epot, K;
  PImage ball;
  boolean firstTime;

   Mover(float m, float x , float y,PVector v) {
    mass = m;
    location = new PVector(x,y);
    velocity = v;
    acceleration = new PVector(0,0);
    ball = loadImage("basketBall.png");
    K = 0.4;
    firstTime = true;
    g = 1;
  }
  
  //Calcula la fuerza que aplica la gravedad sobre la pelota
  void applyForce(PVector force) {
    PVector f = PVector.div(force,mass);
    acceleration.add(f);
  }
  
  // Calculamos la velocidad y la localización de la pelota
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }
  
  PVector energies() {
    // Inicialmente calcularemos la enercia cinética y la potencial
    if (firstTime) {
      PVector peso = new PVector(0,mass);
      Ecin = (PVector.div((peso.add(velocity)).add(velocity),2.0)).mag();
      float h = location.y - (height - 200);
      Epot = (mass * h * g) / 2;
    }
    // Cuando toque el suelo distribuiremos energias mediante porcentajes 
    if (location.y > (height-200)) {
       firstTime = false;
       // Ec de salida 80%
       Ecin = (Ecin + Epot) * 0.8;
       // Ep 20%
       Epot = (Ecin + Epot) * 0.2;
    } 
    PVector energies = new PVector(Ecin,Epot);
    return energies;
  } 
  
  // Con un threshold hacemos que la pelota pare cuando la velocidad sea muy pequeña
  void controlVelocity() {
    float th_y = 0.03;
    float th_x = 0.9;
    if(abs(velocity.y) < th_y) {
      velocity.y = 0;
    }
    if(abs(velocity.x) < th_x) {
      velocity.x = 0;
    }
  }
  
  // Mostramos la pelota
  void display() {
    ball.resize(100,100);
    image(ball, location.x, location.y);
  }
  
  void displayStretch(PVector d, float Epot) {
    // Calculamos la altura mediante la energia potencial
    
    float h = Epot / (mass * g);
   
    // Cuando la pelota rebote contra el suelo la deformamos verticalmente
    if(location.y > height - 201 && abs(velocity.y) > 1) {
      ball.resize(100, 100 - (int)d.y);
     image(ball, location.x, location.y);
      
    } else {
      // Cuando la pelota rebote contra la pared la deformamos horizontalmente
      if((location.x > (width - 51) || location.x < 1)) {
         ball.resize(100 - (int)d.x, 100);
         image(ball, location.x, location.y);
        
      } else {
        // Cuando energias sean cercanas a 0 y la pelota esté en el suelo botando la mostramos normal
        if((Epot == 0.0 && Ecin < 2.1) && abs(h) < 1) {
          ball.resize(100,100);
          image(ball, location.x, location.y);
          velocity.x=0;
          velocity.y=0;
          
          
        }else{
        // Mostramos la pelota normal 
          ball.resize(100,100);
          image(ball, location.x, location.y);
          
        }
      }
    }
    
  }
  
  void harmonicSimple(float t, float Ecin, float Epot) {
    // Definimos la constante de elasticidad
    float k = 0.01;
    float A, Wo;
    
    
    // Calculamos velocidad angular
    Wo = sqrt(k/mass);
    // Calculamos la amplitud
    A = sqrt(2*Ecin/k);
    // Calculamos mediante la fórmula del movimiento harmónico simple la posición x e y
    y = A * abs(cos(Wo * t));
    x = A * abs(sin(Wo * t));
    PVector distorsio = new PVector(x,y);
    // Controlamos cuándo mostrar la deformación de la pelota
    displayStretch(distorsio, Epot);
    
  }
  
  void checkEdges() {
    // Reducimos la velocidad un 20% de la pelota cuando choque y la hacemos rebotar
    if (location.x > (width - 50)) {
      location.x = width - 50;
      velocity.x *= -velocity.x * 0.2;
    } else if (location.x < 0) {
      velocity.x *= velocity.x * 0.2;
      location.x = 0;
    }

    // Colocamos el suelo más arriba para ver mejor el choque
    if (location.y > (height - 200)) {
      velocity.y = -velocity.y * 0.8;
      location.y = height - 200;
    }
  }
  
  void checkEdgesRigid() {
    // En el choque rígido solo cambiamos de dirección cuando choque para que rebote
    if (location.x > (width-50)) {
      location.x = width-50;
      velocity.x *= -1;
    } else if (location.x < 0) {
      velocity.x *= -1;
      location.x = 0;
    }

    if (location.y > (height-50)) {
      velocity.y *= -1;
      location.y = height-50;
    }
  }
}


class Spring{

  // Localización del anchor
  PVector anchor;
  
  float len;
  float k = 0.1;
  PImage ball;

  // Inicializa el anchor y la longitud de reposo
  Spring(float x, float y, int l) {
    anchor = new PVector(x,y);
    len = l;
    ball = loadImage("basketBall.png");
  }
  
  // Calcula la fuerza spring con la Ley de Hooke
  void connect(Mover b) {
    PVector loc = new PVector(b.location.x + 50, b.location.y);
    // Vector que apunte desde el anchor al bob
    PVector force = PVector.sub(loc,anchor); 
    float d = force.mag(); 
    // Desplazamiento entre distancia y longitud de reposo
    float stretch = d- len; //[bold]

    // Direccion y magnitud juntas
    force.normalize(); 
    // Fórmula Ley de Hooke
    force.mult(-1 * k * stretch); 
   
    // Aplicamos la fuerza a la pelota
    b.applyForce(force);
  }

  // Dibujamos el anchor
  void display() {
    fill(100);
    rectMode(CENTER);
    rect(anchor.x,anchor.y,10,10);
  }
  
  // Dibujamos la conexión entre el bob y el anchor
  void displayLine(Mover m) {
    stroke(255);
  
    if((int)(-m.location.y + anchor.y) <= 0) {
       ball.resize((int)(anchor.x - m.location.x), 20);
    } else {
       ball.resize((int)(100), (int)(-m.location.y + anchor.y));
    }
    image(ball, m.location.x, m.location.y);
    //Si se quiere mostrar la linea de la molla
    line(m.location.x + 50, m.location.y, anchor.x, anchor.y);
  }
}
