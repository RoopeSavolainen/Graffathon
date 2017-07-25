uniform float intensity; // use this syntax for variables from processing

varying vec4 vertPos;

void main() {
  vec3 from, to;
  float lerp_v;
  lerp_v = clamp((-vertPos.y + 0) / 1800.0, -1.0, 1.0);
  if(lerp_v > 0) lerp_v = pow(lerp_v, 0.75) / 2.0 + 0.5;
  else {
     lerp_v = 0.5 - pow(-lerp_v, 0.75) / 2.0;
  }

  from = vec3(255 / 255.0 * 2, 100 / 255.0 * 2, 116 / 255.0 * 2) * 1;
  to = vec3(14 / 255.0, 14 / 255.0, 36 / 255.0);

// from = rgb2hsv(from); to = rgb2hsv(to);

  vec3 color = clamp(mix(from, to, lerp_v), 0, 1); // * (1-intensity / 2);
 // color = hsv2rgb(color);
  color = clamp(mix(color, vec3(1, 1, 1), intensity), 0, 1);
  vec3 gammaCorrected = color; // pow(color, vec3(0.4545));
  gl_FragColor = vec4(gammaCorrected, 1);
}
