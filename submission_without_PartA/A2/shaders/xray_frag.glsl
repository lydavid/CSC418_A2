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

void main() {
  // Your solution should go here.
  
  // The model is currently rendered in black
  //gl_FragColor = vec4(vec3(0.0), 1.0);

  // Calculate opacity
  float opacity = abs(dot(normalize(normalInterp), normalize(vertPos)));
  opacity = 1.0 - opacity; 

  vec3 diffuse = Kd * diffuseColor;

  gl_FragColor = vec4(diffuse * opacity, 1.0);
}
