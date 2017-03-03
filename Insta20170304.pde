ArrayList<Particle> particles;

float angle;
float depth;
int size;

void setup()
{
  size(512, 512, P3D);
  frameRate(30);
  colorMode(HSB);
  
  particles = new ArrayList<Particle>();
  float p_size = 15;
  size = 256; 
  depth = 800;
  
  int index = 0;
 
  for(int y = -size / 2; y < size / 2; y += p_size)  
  {
    for(int z = -size / 2; z < size / 2; z += p_size)
    {
      for(int x = -size / 2; x < size / 2; x += p_size)  
      {
        particles.add(new Particle(index, x, y, z, p_size));
        index += 1;
      }
    }
  }
}

void draw()
{
  background(0);
  
  angle = (angle + 1) % 360;
  float x = depth * cos(radians(angle));
  float z = depth * sin(radians(angle));   
  camera(x + width / 2.0, height / 2.0, z, 
         width / 2.0, height / 2.0, 0.0, 
         0.0, 1.0, 0.0);
         
  translate(width / 2, height / 2);
    
  for(Particle p : particles)
  {
    if(p.moved || PVector.dist(new PVector(0, 0, 0), p.location) > size - (frameCount + 100) / 3)
    {
      if(p.moved)
      {
        p.applyForce(0, 0.5, 0);
      }else
      {
        PVector direction = PVector.sub(new PVector(0, 0, 0), p.location);
        p.applyForce(direction.mult(-1));
        p.moved = true;
      }
    }
    p.update();
    p.display();
  }
  
  /*
  println(frameCount);
  saveFrame("screen-#####.png");
  if(frameCount > 720)
  {
     exit();
  }
  */
}