// uniform float fraction; // use this syntax for variables from processing

varying vec4 vertPos;

void main() {
  float lerp_v = clamp((-vertPos.y + 250) / 1700.0, 0.0, 1.0);
  lerp_v = pow(lerp_v, 0.5);

  vec3 fromColor = vec3(255 / 255.0, 100 / 255.0, 116 / 255.0) * 1;
  vec3 toColor = vec3(14 / 255.0, 14 / 255.0, 36 / 255.0);

  vec3 color = clamp(mix(fromColor, toColor, lerp_v), 0, 1);
  vec3 gammaCorrected = color; // pow(color, vec3(0.4545));
  gl_FragColor = vec4(gammaCorrected, 1);
}