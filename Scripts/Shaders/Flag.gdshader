shader_type canvas_item;

uniform float speed = 2.0;
uniform float dis = 1.0;

float random (vec2 uv) {
    return fract(sin(dot(uv.xy,
        vec2(12.9898,78.233))) * 43758.5453123);
}

void vertex() {	
	// This is running every frame - i would like to random a number just at start
	// If happen some performance problem, try to improve here
	float randomValue = random(vec2(UV.x, UV.y));
	VERTEX.x += sin(TIME * (speed + randomValue ) ) * dis * (UV.y - 1.0);
}