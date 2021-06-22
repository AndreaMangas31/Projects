class Mover{
  PVector pos;
  PVector vel;
  PVector acc;
  PVector pos_cuc;
  PVector vel_cuc;
  PVector acc_cuc;
  float topspeed;
  
  Mover(PVector _pos, PVector _vel, PVector _acc) {
    pos = _pos;
    vel = _vel;
    acc = _acc;
  }
  
  Mover(PVector _pos_cuc, PVector _vel_cuc, PVector _acc_cuc, float _topspeed) {
    pos_cuc = _pos_cuc;
    vel_cuc = _vel_cuc;
    acc_cuc = _acc_cuc;
    topspeed = _topspeed;
  }
  
  PVector followMouse(){   
    PVector mouse = new PVector(mouseX, mouseY);
    //calculem la acceleració que trigara en arribar a la posicio del mouse
    acc = mouse.sub(pos);
    //reduiem per a què no agafi el ratolí de seguida
    acc.mult(0.006);
 
    vel.add(acc);
    //que no vagi molt ràpid quan s'apropi al ratolí
    vel.mult(0.8);
    pos.add(vel);
    return pos;
   }
   
   PVector moveWorm(){
   
    //Velocity changes by acceleration and is limited by topspeed.
    vel_cuc.add(acc_cuc);
    vel_cuc.limit(topspeed);
    pos_cuc.add(vel_cuc);

    return pos_cuc;
   }
 
}
