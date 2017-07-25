uniform mat4 transform;
attribute vec4 position;
varying vec4 vertPos;

void main() {
  gl_Position = transform * position;
  vertPos = position;
 }