precision mediump float; // It is required to set a floating point precision in all fragment shaders.

// Interpolated values from vertex shader
varying vec3 normalInterp; // Normal
varying vec3 vertPos; // Vertex position
varying vec3 viewVec; // Interpolated view vector
varying highp vec2 texCoordInterp;

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

// uniform values are the same across the scene
uniform sampler2D uSampler;	// A GLSL sampler represents a single texture. A sampler2D can be used to sample a 2D texture.

void main() {
  // Your solution should go here.
  // The model is currently rendered in black

  // texture seemed to be upside down, so we flip it
  highp vec2 flippedTexCoordInterp = vec2(texCoordInterp.s, 1.0 - texCoordInterp.t);
  gl_FragColor = vec4(texture2D(uSampler, flippedTexCoordInterp).rgb, 1.0);
}
