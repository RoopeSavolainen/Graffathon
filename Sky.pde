class Sky {
  private PShader skyShader;
  // TODO: sun?
  
  public Sky() {
   skyShader = loadShader("sky-frag.glsl", "sky-vert.glsl");
  }

  void draw(PVector cameraPos) {
    shader(skyShader);
    
    pushMatrix();
    translate(cameraPos.x, cameraPos.y, cameraPos.z); // render the sphere to be in center of the camera
    noStroke();
    sphere(5000);
    popMatrix();
    
    resetShader();
  }
}