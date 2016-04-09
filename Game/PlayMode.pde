/**
 * Playing mode. The user tilts the plane dragging the mouse.
 */
class PlayMode extends Mode {

  /*
   * Performs the mouse dragged action of the plane.
   *
   * @see  plane.mouseDraggedPlane
   */
  void mouseDragged() {
    plane.mouseDraggedPlane();
  }

  /*
   * Performs the mouse wheel action of the plane.
   *
   * @see  plane.mouseWheelPlane
   */
  void mouseWheel(MouseEvent event) {
    plane.mouseWheelPlane(event);
  }

  /*
   * Updates and displays the plane and the ball.
   */
  void display() {
    plane.display();
    ball.update();
    ball.display();
  }

  /*
   * Draws the cylinders on the plane.
   */
  void drawCylinders() {    
    cylinder.side.setFill(cylinder.colour);
    cylinder.top.setFill(cylinder.colour);
    cylinder.bot.setFill(cylinder.colour);

    for (int j = 0; j < cylinders.size(); ++j) {
      pushMatrix();      
      rotateX(PI/2 + plane.angleX);
      rotateY(plane.angleZ);
      translate(cylinders.get(j).x, cylinders.get(j).y, cylinders.get(j).z);
      cylinder.draw();
      popMatrix();
    }
  }
}