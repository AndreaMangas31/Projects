class Car{
   
    Rueda r1;
    Rueda r2;
    Body body;
    //Colocamos las medidas de los rectangulos utilizarlas en las diferentes funciones
    float w_1=150;
    float h_1=50;
    float w_2=75;
    float h_2=50;
    //Definimos el centro donde queremos que el coche aparezca
    Vec2 center=new Vec2(100,450);
    
    Car(){
      
      //Inializamos dos ruedas y un cuerpo que sea el xassis 
        r1 = new Rueda(center.x-40, center.y+30, 20);
        r2 = new Rueda(center.x+40, center.y+30,20);
        
        BodyDef bd = new BodyDef();
        //Hacemos que el cuerpo sea dinamico es decir que interactuen con el mundo
        bd.type = BodyType.DYNAMIC;
        bd.position.set(box2d.coordPixelsToWorld(center));
        body = box2d.createBody(bd);
        
        
        //Creamos dos rectangulos y escalamos los pixeles para que se escalen en el box2d
        PolygonShape ps = new PolygonShape();
        float box2dW = box2d.scalarPixelsToWorld(w_1/2);
        float box2dH = box2d.scalarPixelsToWorld(h_1/2);
        ps.setAsBox(box2dW, box2dH);
        
        PolygonShape ps2 = new PolygonShape();
        float box2dW2 = box2d.scalarPixelsToWorld(w_2/2);
        float box2dH2 = box2d.scalarPixelsToWorld(h_2/2);
        ps2.setAsBox(box2dW2, box2dH2);
        //unimos estos dos rectangulos en un mismo cuerpo
        body.createFixture(ps,1.0);
        body.createFixture(ps2, 1.0);
        
        //Con RevoluteJointDef hacemos que se una el cuerpo con la rueda y se muevan a la vez
        RevoluteJointDef rjd1 = new RevoluteJointDef();
        rjd1.initialize(body, r1.body, r1.body.getWorldCenter());
        //Añadimos un motor para que se mueva sola
        rjd1.motorSpeed = -PI*2;
        rjd1.maxMotorTorque = 300.0;
        rjd1.enableMotor = true;
        //Introducimos esta union en el mundo
        box2d.world.createJoint(rjd1);
        
        //Volvemos a repetir el proceso pero con la segunda rueda
        RevoluteJointDef rjd2 = new RevoluteJointDef();
        rjd2.initialize(body, r2.body, r2.body.getWorldCenter());
        rjd2.motorSpeed = -PI*2;
        rjd2.maxMotorTorque = 300.0;
        rjd2.enableMotor = true;
        box2d.world.createJoint(rjd2);
        
   }
   
   
    void display() {
      //cogemos la posicion definida en el mundo
      Vec2 pos = box2d.getBodyPixelCoord(body);
      float a = body.getAngle();
  
      rectMode(CENTER);
      pushMatrix();
      //movemos el coche a la posicion definida
      translate(pos.x,pos.y);
      //rotamos para ponerlo en el angulo que queremos
      rotate(-a);
      fill(255,0,0);
      noStroke();
      //Colocamos los dos rectangulos para que simulen la forma de un coche
      rect(0,0,w_1,h_1);
      rect(0,-h_1+10,w_2,h_2);
     
      popMatrix();
  }
  //Con esta función mostramos las dos ruedas y por encima el chasis
  void displayWholeCar(){
    
    r1.display();
    r2.display();
    display();
    
  }
}
