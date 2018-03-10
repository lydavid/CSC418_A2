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

  // We will be attempting the Cook-Torrance model
  // Copied rest from phong, changing how we calculate our specular

  // Define our own constants
  float roughness = 1.0;
  float pi = 3.141592653589793238;
  float refractiveIndex = 2.2;

  // adjustable diffuse
  vec3 lightDirection = normalize(lightPos - vertPos); // s
  vec3 worldNormal = normalize(normalInterp); // n
  float lambert = max(0.0, dot(lightDirection, worldNormal));
  vec3 diffuse = Kd * diffuseColor * lambert;

  // specular calculations from phong
  vec3 reflection = normalize(reflect(-lightDirection, worldNormal));
  vec3 viewDirection = normalize(viewVec);

  // changes for Cook-Torrance
  vec3 halfVector = normalize(lightDirection + viewDirection);

  // dot products
  float hDotN = max(0.0, dot(halfVector, worldNormal));
  float vDotN = max(0.0, dot(viewDirection, worldNormal));
  float vDotH = max(0.0, dot(viewDirection, halfVector));
  float lDotN = max(0.0, dot(lightDirection, worldNormal));
  float lDotH = max(0.0, dot(lightDirection, halfVector));

  // Fresnel, Geometric, and Beckmann distribution factors
  float f_0 = pow((1.0 - refractiveIndex) / (1.0 + refractiveIndex), 2.0);
  float F = f_0 + (1.0 - f_0) * pow((1.0 - lDotH), 5.0);
  float G = min(1.0, min(((2.0 * hDotN * vDotN) / vDotH), ((2.0 * hDotN * lDotN) / vDotH)));
  float D = pow(exp(-tan(acos(hDotN) / roughness)), 2.0) / (4.0 * pow(roughness, 2.0) * pow(acos(hDotN), 4.0));

  // final specular from Cook-Torrance
  vec3 specular = specularColor * (Ks / pi) * max(((F * G * D) / (vDotN * lDotN)), 0.0);

  gl_FragColor = vec4(Ka * ambientColor + diffuse + specular, 1.0);
}
