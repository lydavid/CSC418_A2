precision mediump float; // It is required to set a floating point precision in all fragment shaders.

// Interpolated values from vertex shader
varying vec3 normalInterp; // Normal
varying vec3 vertPos; // Vertex position
varying vec3 viewVec; // Interpolated view vector

// uniform values remain the same across the scene
uniform float Ka;   // Ambient reflection coefficient
uniform float Kd;   // Diffuse reflection coefficient
uniform float Ks;   // Specular reflection coefficient
uniform float shininessVal; // Shininess

// Material color
uniform vec3 ambientColor;
uniform vec3 diffuseColor;
uniform vec3 specularColor;

uniform vec3 lightPos; // Light position in camera space

// HINT: Use the built-in variable gl_FragCoord to get the screen-space coordinates

void main() {
  // Your solution should go here.
  // Only the background color calculations have been provided as an example.

  // adustable diffuse
  vec3 lightDirection = normalize(lightPos - vertPos);
  vec3 worldNormal = normalize(normalInterp);
  float lambert = max(0.0, dot(lightDirection, worldNormal));
  vec3 diffuse = Kd * diffuseColor * lambert;

  // adjustable ambient
  vec3 ambient = Ka * ambientColor;

  float frequency = 50.0; // number of dots across model
  vec2 nearest = 2.0 * fract(frequency * vec2(vertPos.x, vertPos.y)) - 1.0;
  float dist = length(nearest);
  float radius = (1.0 - lambert) * 2.0; // size of dots, by basing it off our lambert, we can get a varied size based on where light hits our model

  gl_FragColor = vec4(mix(ambient, diffuse, step(radius, dist)), 1.0);
}
