class Rueda {

  
  Body body;
  float r;

  //Para crear una rueda necesitamos la posicion y el radio que ocupara, para asi poderlo hacer de diferentes tamaños y en diferentes lugares
  Rueda(float x, float y, float r_) {
    r = r_;
    //Crea el cuerpo en el mundo y despues definiremos como
    makeBody(x,y,r);
  }
  
  //Define como creamos cada rueda
  void makeBody(float x, float y, float r) {
    
    //Definimos el cuerpo, su posicion y tipo Dinamico para que interactue con el mundo
    BodyDef bd = new BodyDef();
    bd.position = box2d.coordPixelsToWorld(x,y);
    bd.type = BodyType.DYNAMIC;
    //creamos el cuerpo en el mundo
    body = box2d.world.createBody(bd);

    //Definimos que tipo de cuerpo es(en este caso circular)
    CircleShape circle = new CircleShape();
    //escalamos el radio a las medidas del mundo
    circle.m_radius = box2d.scalarPixelsToWorld(r);
    
    //creamos la figura del cuerpo relacionandolo con la forma de este
    FixtureDef fd = new FixtureDef();
    fd.shape = circle;
    //Hacemos que afecte la densidad y la friccion que generan
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.1;
    
    //Asignamos esta figura al cuerpo de la rueda
    body.createFixture(fd);

  }

   
  void display() {
    //Definimos la posicion del cuerpo 
    Vec2 pos = box2d.getBodyPixelCoord(body);
    //Le damos un angulo
    float a = body.getAngle();
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(-a);
    fill(0);
    stroke(0);
    strokeWeight(1);
    ellipse(0,0,r*2,r*2);
    //Aqui añadimos la linia roja para ver la rotacion de la rueda
    stroke(255,0,0);
    line(0,0,r,0);
    
    popMatrix();
  }







}
