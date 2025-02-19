// デフォルトuniform
uniform mat4 projectionMatrix;
uniform mat4 viewMatrix;
uniform mat4 modelMatrix;

// デフォルトattribute
attribute vec3 position; // モデル座標
attribute vec2 uv; // テクスチャ座標 0 - 1（plane左下0）
attribute vec2 normal;

uniform float uTime;

// varying
varying vec2 vUv;

void main() {
  vec3 pos = position.xyz; // モデル座標

  float distance = length(uv.xy - 0.5); // (0, 0)からuvの距離
  float maxDistance = length(vec2(0.5));
  float normalizeDistance = distance / maxDistance; // 0 - 1.0 （角で戻り値最大で1.0）

  float stickOutEffect = normalizeDistance;
  float stickInEffect = -normalizeDistance;
  float stickEffect = mix(stickInEffect, stickOutEffect, 1.0);

  // ※planeがwindow.innerWidth * window.innerHeightなのでoffset大きく
  float offset = 2000.;

  pos.z += stickEffect * offset;

  vec4 modelPosition = modelMatrix * vec4(pos, 1.0); // ワールド座標
  vec4 viewPosition = viewMatrix * modelPosition;
  vec4 projectPosition = projectionMatrix * viewPosition;

  gl_Position = projectPosition;
  
  vUv = uv;
}