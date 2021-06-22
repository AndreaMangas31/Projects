// Clase del Satelite
class Mover {
  
  PVector location, velocity, acceleration, force;
  float mass, distance;
  PImage satellite;

 // Le pasamos la posicion inicial que habra introducido el usuario
  Mover(float initx, float inity) {
    // Aqui se puede introducir la masa del satelite
    mass = 0.5;   
    
    // Aqui se puede introducir la velocidad inicial del satelite
    velocity = new PVector(0.9,0.6);
    
    location = new PVector(initx, inity);
    acceleration = new PVector(0,0);
    // Cargamos la imagen del satelite y la escalamos
    satellite = loadImage("Satellite.png");
    satellite.resize(50,50);
    // Inicializamos esta distancia para la opcion C 
    distance = 0.0;
  }
  
  // Calcula la fuerza que aplica la tierra sobre el satelite
  void applyForce(PVector force) {
    PVector f = PVector.div(force,mass);
    acceleration.add(f);
  }
  
  // Funcion de la opcion B para saber a que velocidad debe ir para que la orbita fuera circular
  PVector guessVelocity(Attractor a) {
    // Sumamos a la localizacion la mitad de su tamaño para que la orbita quede centrada,
    // ya que sino coge la localizacion del punto arriba izquierda de la fotografia
    PVector size = new PVector(25,25);
    PVector atractor = new PVector(0,0);
    atractor = PVector.add(a.location,size);
    
    // Calculamos el vector que hay de la tierra al satelite
    force = PVector.sub(atractor,location);
    // Hacemos el modulo de la distancia
    distance = force.mag();
    // A partir de la formula GMm/R^2=m*v^2/R --> sacamos que v=raiz(M/R)
    float velocity_module = sqrt(a.mass/distance);
    
    // Pensamos que para que la orbita fuera circular, el modulo de la velocidad deberia estar sacado de un vector donde Vx y Vy fueran iguales
    // a partir de la funcion v=raiz(a^2+a^2), aislamos a, y calulamos auxiliar
    float aux = sqrt(pow(velocity_module,2)/2);
    PVector v = new PVector(aux,aux);
    
    return v;
  } 
  
  // Funcion que detecta cuando el satelite choca contra la tierra
  boolean choque(Attractor a) {
    PVector size = new PVector(100,100);
    PVector atractor = new PVector(0,0);
    atractor = PVector.add(a.location,size);
    // Si cualquiera de los extremos del satelite se chocara contra la tierra detectaria que ha chocado y la imagen cambiaria a una explosion
    if(location.x >= a.location.x && location.x <= atractor.x && location.y >= a.location.y && location.y <= atractor.y){
       satellite = loadImage("Explosion.png");
       satellite.resize(50,50);
       display();
       // Devolveriamos true, para asi luego asegurarnos que no se sigue moviendo
       return true;
    }
    return false;
  }
  
  // Calculamos la relacion entre velocidad, aceleracion y localizacion
  void update(PVector v) {
    v.add(acceleration);
    location.add(v);
    acceleration.mult(0);
  }
  
  // Mostramos la imagen que carguemos en satelite y en la posicion que se encuentre en cada momento
  void display() {
    image(satellite, location.x, location.y);
  }
}

// Clase de la Tierra
class Attractor {
  float mass;
  PVector location;
  PImage earth;

  Attractor() {
    // Aqui se introduce la localizacion de la Tierra
    location = new PVector(width/2 - 50, height/2 - 50);
    
    // Aqui se introduce la masa de la Tierra
    mass = 100;
    
    // Cargamos la imagen y la escalamos
    earth = loadImage("Earth.png");
    earth.resize(100,100);
  }
 
  // Muestra por pantalla la imagen de la tierra con su posicion dada
  void display() {
    image(earth, location.x, location.y);
  }
  
  // Esta funcion se encarga de calcular la fuerza que ejerce en cada momento la tierra sobre el satelite
  PVector attract(Mover m, boolean choque) {
    PVector size = new PVector(25,25);
    PVector atractor = new PVector(0,0);
    atractor = PVector.add(location,size);
    // Calculamos la fuerza que ejerce la tierra sobre el satelite
    PVector force = PVector.sub(atractor,m.location);
    // Si no hay choque hacemos los calculos
    if(!choque) {
      float distance = force.mag();
      force.normalize();
      float strength = (mass * m.mass) / (distance * distance);
      force.mult(strength);
    } 
    
    return force;
  }
  
  // Aqui calculamos los resultados de la opcion C (e, rmax y rmin)
  PVector guessSolutions(ArrayList <PVector> recorrido) {
    float a2 = 0.0;
    float a = 0.0;
    float c = 0.0;
    float rmax = 0.0;
    float rmin = 0.0;
    float e = 0.0;

   // Compara cada posicion para coger la mas grande
   for(int i = 0; i < recorrido.size(); i++) {
     // Calculamos desde el centro de la tierra hasta la posicion del satelite la distancia en x y en y
     float rx = recorrido.get(i).x - (location.x + 50);
     float ry = recorrido.get(i).y - (location.y + 50);
     PVector r = new PVector(rx, ry);
      
     // Modulo de la distancia, que seria la magnitud de esta distancia
     float distance = r.mag();
     
     // Comparamos todas las distancias y si encontramos la mas grande es la que guardamos
     if(distance > rmax) {
       rmax = distance;
     }
     // En la primera instancia ponemos la rmin como la primera que calcula
     if(i == 0) {
       rmin = distance;
       // Si no vamos actualizando esta distancia si encontramos que en alguna otra posicion es mas pequeña 
     } else {
       if(distance < rmin) {
         rmin = distance;
       }
     } 
   }
   // 2a es igual a la suma de la distancia maxima de la orbita + la minima
   a2 = rmin + rmax;
   a = a2 / 2;
   // La c en una orbita sera el semieje mayor menos la distancia minima
   c = a - rmin;
   // La excentricidad es c/a
   e = c / a;
   
   // Guardamos estas soluciones en un PVector, ya que como son 3 resultados aprovechamos para guardarlo en un solo vector x, y, z
   PVector solutions = new PVector(e, rmin, rmax);
    
   return solutions;
  }
}
