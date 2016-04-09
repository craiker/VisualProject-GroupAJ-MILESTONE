/**
 *  This class modelizes the ball. It has attributes to keep track of its movement variables 
 *  and it's characteristics (dimentions, color, sounds, ...)
 *  
 *  @normalForce   normal force to the surface.
 *  @mu            friction coefficient.
 *  @friction      friction vector.
 *  @r             radius of the ball.
 *  @location      current position of the ball in the space, relative to the center of the plane.
 *  @velocity      current velocity of the ball.
 *  @gravity       gravity vector.
 */
class Ball {

  //_______________________________________________________________
  //Attributes  
  float normalForce;
  float mu;  
  PVector friction;
  float r;
  PVector location;
  PVector velocity;
  PVector gravity;
  color colour;

  //BONUS
  //The bouncing sound
  //AudioSample boing;


  //_______________________________________________________________
  //Functions
  /**
   * Initializes all attributes of the ball.
   */
  Ball(float r) {
    this.location = new PVector(0, 0, 0);
    this.r = r;
    velocity = new PVector(0, 0, 0);
    gravity = new PVector(0, 0, 0);
    friction = new PVector(0, 0, 0);
    mu = 0.6;
    normalForce = 1;

    //BONUS
    //boing = minim.loadSample("LaserBlasts.mp3");
    colour = color(50, 100, 200);
  }

  /**
   * Updates the position and velocity.
   */
  void update() {
    gravity.x = sin(plane.angleZ) * environment.g;
    gravity.z = -sin(plane.angleX) * environment.g;

    friction = velocity.get();
    friction.mult(-1);
    friction.normalize();
    friction.mult(normalForce * mu);

    velocity.add(gravity);
    velocity.add(friction);
    location.add(velocity);

    
    if (location.x > plane.boardEdge/2) {
      location.x = plane.boardEdge/2;
      velocity.x *= -1; 
      
      //BONUS
      //boing.trigger();
    } else if (location.x < -plane.boardEdge/2) {
      location.x = -plane.boardEdge/2;
      velocity.x *= -1;
      
      //BONUS
      //boing.trigger();
    }
    if (location.z > plane.boardEdge/2) {
      location.z = plane.boardEdge/2;
      velocity.z *= -1; 
      
      //BONUS
      //boing.trigger();
    } else if (location.z < -plane.boardEdge/2) {
      location.z = -plane.boardEdge/2;
      velocity.z *= -1; 
      
      //BONUS
      //boing.trigger();
    }
    
    cylinderCollision();
  }

 /**
  * Checks the collision with all cylinders on the plane.
  */
  void cylinderCollision() {
    PVector norm;
    for (int i = 0; i < cylinders.size(); ++i) {
      if ( dist(cylinders.get(i).x, cylinders.get(i).y, location.x, location.z) <= cylinder.c_radius + r) {        
        norm = (new PVector(location.x - cylinders.get(i).x, 0, location.z - cylinders.get(i).y)).normalize();
       
        velocity = PVector.sub(velocity, PVector.mult(norm, velocity.dot(norm) * 2));

        PVector cylc = new PVector(cylinders.get(i).x, 0, cylinders.get(i).y);
        location = PVector.add(cylc, PVector.mult(norm, cylinder.c_radius + r));

        //BONUS
        //boing.trigger();
      }
    }
  }

 /**
  * Displays the ball.
  */
  void display() {
    pushMatrix();
    rotateX(plane.angleX);
    rotateZ(plane.angleZ);
    translate(location.x, -r - (plane.boardThick/2), location.z);
    fill(colour);
    sphere(r);
    popMatrix();
  }
}