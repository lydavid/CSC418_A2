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
  //gl_FragColor = vec4(diffuseColor, 1.0);

  vec3 lightDirection = normalize(lightPos - vertPos);
  vec3 worldNormal = normalize(normalInterp);

  float lambert = max(0.0, dot(lightDirection, worldNormal));

  vec3 diffuse = Kd * diffuseColor * lambert;

  gl_FragColor = vec4(Ka * ambientColor + diffuse, 1.0);
}