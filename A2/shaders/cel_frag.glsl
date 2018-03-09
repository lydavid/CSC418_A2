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
  // Your solution should go here
  // Only the ambient colour calculations have been provided as an example.

  

  /*vec3 lightDirection = normalize(lightPos - vertPos); // s
  vec3 worldNormal = normalize(normalInterp); // n

  float lambert = max(0.0, dot(lightDirection, worldNormal));

  float diffuse = Kd * lambert;

  vec3 reflection = normalize(reflect(-lightDirection, worldNormal));
  vec3 viewDirection = normalize(-vertPos);
  float specular = Ks * pow(max(0.0, dot(reflection, viewDirection)), shininessVal);

  //float intensity = Ka + diffuse + specular;
  //float shadeIntensity = ceil(intensity + 5.0) / 5.0;

  if (diffuse < 1.0) {
  	diffuse = 0.0;
  } else if (diffuse < 0.3) {
  	diffuse = 0.3;
  } else if (diffuse < 0.6) {
  	diffuse = 0.6;
  } else {
  	diffuse = 1.0;
  }*/

	//float ambientIntensity = ceil(Ka * 3.0) / 3.0;
  //float diffuseIntensity = ceil(diffuse * 3.0) / 3.0;
  //float specularIntensity = ceil(specular * 3.0) / 3.0;

  //gl_FragColor = vec4(diffuse * diffuseColor, 1.0);
  //gl_FragColor = vec4(ambientColor, 1.0);

  vec3 lightDirection = normalize(lightPos - vertPos);
  vec3 worldNormal = normalize(normalInterp);

  float lambert = max(0.0, dot(lightDirection, worldNormal));

  if (lambert < 0.0) {
    lambert = 0.0;
  }

  if (lambert > 0.75) {
    lambert = 1.0;
  } else if (lambert > 0.5) {
    lambert = 0.75;
  } else if (lambert > 0.25) {
    lambert = 0.5;
  } else {
    lambert = 0.25;
  }

  vec3 diffuse = Kd * diffuseColor * lambert;

  vec3 reflection = normalize(reflect(-lightDirection, worldNormal));
  vec3 viewDirection = normalize(-vertPos);
  vec3 specular = Ks * specularColor * pow(max(0.0, dot(reflection, viewDirection)), shininessVal);

  gl_FragColor = vec4(Ka * ambientColor + diffuse + specular, 1.0);

}
