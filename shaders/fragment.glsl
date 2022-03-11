varying vec2 vCoordinates;
varying vec3 vPos;
uniform sampler2D t1;
uniform sampler2D t2;
uniform float move;

void main() {
    vec2 myUV = vec2(vCoordinates.x / 512., vCoordinates.y / 512.);
    vec4 tt1 = texture2D(t1, myUV);
    vec4 tt2 = texture2D(t2, myUV);

    vec4 final = mix(tt1, tt2, smoothstep(0., 1., fract(move)));

    gl_FragColor = final;
}
