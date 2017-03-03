class Particle
{
  int index;
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  PVector starting;
  
  float max_force;
  float max_speed;
  float size;
  color body_color;
  
  boolean moved;
  
  Particle(int i, float x, float y, float z, float s)
  {
    index = i;
    
    location = new PVector(x, y, z);
    velocity = new PVector(0, 0, 0);
    acceleration = new PVector(0, 0, 0);
    starting = location.copy();
    
    size = s;
    max_force = 0.5;
    max_speed = size;
    body_color = color(random(255), 255, 255);
    
    moved = false;
  }
  
  void update()
  {
    velocity.add(acceleration);
    velocity.limit(max_speed);
    location.add(velocity);
    velocity.mult(0.99);
    acceleration.mult(0);
  }
  
  void applyForce(PVector force)
  {
    acceleration.add(force);
  }
  
  void applyForce(float x, float y, float z)
  {
    acceleration.add(new PVector(x, y, z));
  }
  
  void seek(PVector target)
  {
    PVector desired = PVector.sub(target, location);
    float d = desired.mag();
    desired.normalize();
    if(d < 100)
    {
      float m = map(d, 0, 100, 0, max_speed);
      desired.mult(m);
    }else
    {
      desired.mult(max_speed);
    }
  
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(max_force);
    applyForce(steer);
  }
  
  void goHome()
  {
    seek(starting);
  }
  
  void display()
  {
    noStroke();
 
    pushMatrix();
    translate(location.x, location.y, location.z);
    stroke(200);
    strokeWeight(0.5);
    fill(body_color);
    box(size);
    popMatrix();
  }
}