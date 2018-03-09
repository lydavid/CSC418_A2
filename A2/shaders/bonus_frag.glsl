// Fragment shader template for the bonus question

precision mediump float; // It is required to set a floating point precision in all fragment shaders.

// Interpolated values from vertex shader
// NOTE: You may need to edit this section to add additional variables
varying vec3 normalInterp; // Normal
varying vec3 vertPos; // Vertex position
varying vec3 viewVec; // Interpolated view vector

// uniform values remain the same across the scene
// NOTE: You may need to edit this section to add additional variables
uniform float Ka;   // Ambient reflection coefficient
uniform float Kd;   // Diffuse reflection coefficient
uniform float Ks;   // Specular reflection coefficient
uniform float shininessVal; // Shininess

// Material color
uniform vec3 ambientColor;
uniform vec3 diffuseColor;
uniform vec3 specularColor;

uniform vec3 lightPos; // Light position in camera space

uniform sampler2D uSampler;	// 2D sampler for the earth texture

void main() {
  // Your solution should go here.
  // Only the ambient colour calculations have been provided as an example.
  //gl_FragColor = vec4(ambientColor, 1.0);

  // We will be attempting the Cook-Torrance model

  // Define our own roughness and freshnel constants
  float roughness = 1.0;
  float freshnel = 1.9;
  float pi = 3.141592653589793238;

  vec3 lightDirection = normalize(lightPos - vertPos); // s
  vec3 worldNormal = normalize(normalInterp); // n
  float lambert = max(0.0, dot(lightDirection, worldNormal));
  vec3 diffuse = Kd * diffuseColor * lambert;

  vec3 reflection = normalize(reflect(-lightDirection, worldNormal));
  vec3 viewDirection = normalize(viewVec);//(-vertPos);

  vec3 halfVector = normalize(lightDirection + viewDirection);

  

  //vec3 specular = Ks * specularColor * pow(max(0.0, dot(reflection, viewDirection)), shininessVal);
  // change 1.0 to FGD
  float hDotN = max(0.0, dot(halfVector, worldNormal));
  float vDotN = max(0.0, dot(viewDirection, worldNormal));
  float vDotH = max(0.0, dot(viewDirection, halfVector));
  float lDotN = max(0.0, dot(lightDirection, worldNormal));

  float F = pow(1.0 - vDotN, freshnel);

  float G = min(1.0, min(((2.0 * hDotN * vDotN) / vDotH), ((2.0 * hDotN * lDotN) / vDotH)));

  float D = pow(exp(-tan(acos(hDotN) / roughness)), 2.0) / (4.0 * pow(roughness, 2.0) * pow(acos(hDotN), 4.0));

  vec3 specular = specularColor * (Ks / pi) * ((F * G * D) / (vDotN * lDotN));

  gl_FragColor = vec4(Ka * ambientColor + diffuse + specular, 1.0);
}
