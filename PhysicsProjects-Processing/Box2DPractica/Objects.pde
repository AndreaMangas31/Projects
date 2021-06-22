class Surface {
  ArrayList<Vec2> surface;

  Surface() {

   surface = new ArrayList<Vec2>();
   //Para crear la superficie primero necistamos definir las coordenadas de los puntos de ella
    float theta = 0;
    //Hacemos que de un tercio del mapa hasta el doble de la pantalla haga un sinus para que haga forma ondulatoria
    //(para que no se viera que el coche cae al vacio)
    for(float x=width*2; x>width/3; x-=5) {
      //con la funcion map conseguimps que se coloquen los vectores siguiendo el sin con una altura 
      //i bajada definida y incluso distancia entre las oscilaciones
      float y = map(sin(theta), -2, 2, 650, 700);
      theta += 0.15;
      //añadimos un vector a la superficie
      surface.add(new Vec2(x, y));
    }
    //Añadimos este ultimo vector para que se haga una superficie plana de la altura definida hasta donde empieza el sin
    surface.add(new Vec2(0, height-250));


    
    ChainShape chain = new ChainShape();

    //añadimos vertices a la superficie para que se pinte el recorrido despues
    Vec2[] vertices = new Vec2[surface.size()];
    for (int i = 0; i < vertices.length; i++) {
      vertices[i] = box2d.coordPixelsToWorld(surface.get(i));
    }

    //Hacemos que los vertices se añadan a el box2d
    chain.createChain(vertices, vertices.length);

    //Y convertimos estos vertices en un body
    BodyDef bd = new BodyDef();
    ///Hacemos que el cuerpo sea estatico para que no se mueva.
    bd.type=BodyType.STATIC;
    Body body = box2d.world.createBody(bd);
    body.createFixture(chain, 1);


  }
  void display() {
    strokeWeight(1);
    stroke(0);
    //pintamos la cadena que creaban los vertices
    fill(0,150,50);
    beginShape();
    for (Vec2 v: surface) {
      vertex(v.x, v.y);
    }
    
    //añadimos el vertice inferior izquierdo y el vertice inferior derecho para que asi se pintara una forma y no solo la linia de vertices
    //Y asi se simula mejor un suelo.
    vertex(0, height);
    vertex(width*2, height);
    
    
    endShape(CLOSE);
  }
}
