varying vec2 vUv;
varying vec2 vCoordinates;
varying vec3 vPos;
attribute vec3 aCoordinates;
attribute float aSpeed;
attribute float aOffset;
attribute float aDirection;
attribute float aPress;

uniform float move;
uniform float time;
uniform vec2 mouse;
uniform float transition;

void main() {
    vUv = uv;

    vec3 pos = position;
    // NOT STABLE
    pos.x += sin(move * aSpeed) * 3.;
    pos.y += sin(move * aSpeed) * 3.;
    pos.z = mod(position.z + move * 200. * aSpeed + aOffset, 2000.) - 1000.;

    vec3 stable = position;
    float dist = distance(stable.xy, mouse);
    float area = smoothstep(0., 300., dist);

    stable.x += 50. * sin(time*aPress) * aDirection * area;
    stable.y += 50. * sin(time*aPress) * aDirection * area;
    stable.z += 200. * cos(time*aPress) * aDirection * area;

    pos = mix(pos, stable, transition);

    // STABLE
    vec4 mvPosition = modelViewMatrix * vec4( stable, 1. );
    gl_PointSize = 1000. * (.1 / - mvPosition.z) ;
    gl_Position = projectionMatrix * mvPosition;

    vCoordinates = aCoordinates.xy;
    vPos = pos;
}
