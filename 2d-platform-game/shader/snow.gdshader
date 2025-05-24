shader_type canvas_item;
// This is the shader for the snow fall effect when toaching ice block
// this layer value change the amount of layers on screen which change the amount of snow
// on each layer we see
uniform float screen_layers: hint_range(0.0, 200.0, 0.1)=50.0;
// this value determine how close the snowflakes are. The closer, the bigger they are
uniform float snow_depth: hint_range(0.0, 1.0, 0.1)=0.5;
// this value is the amount of snowflakes on a layer
uniform float snow_density: hint_range(0.0, 1.0, 0.1)=0.5;
// this value is the fall_speed at which the snowflakes fall
uniform float fall_speed: hint_range(0.0, 1.0, 0.1)=0.5;
// this value changes the direction the snowflakes is falling from
// negative: right to left, positive: left to right, zero: fall downward
uniform float wind_speed: hint_range(-2.0, 2.0, 0.1)=0.0;
uniform float snowon = 1.0;
void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 uv= -UV;
	vec2 resolution = 1.0 / TEXTURE_PIXEL_SIZE;
	uv.x *= resolution.x/ resolution.y;
	float time =TIME * fall_speed;
	vec3 color = vec3(0.0);
	for (float i = 0.0; i < screen_layers; i++){
		//creating the snowflake
		vec2 snow_flake = uv * (1.0 + i * snow_depth);
		//shifting the snowflakes amount and fall direction
		float shift_snow = (snow_density * (mod(i*PI,1.0)-(wind_speed+0.5)));
		//calculate the speed at which the snowflake fall
		float snow_fall = time / (1.0 + i * snow_depth * 0.03);
		snow_flake += vec2(snow_flake.y * shift_snow, snow_fall);
		//shaping the snowflake
		vec2 snow_shape = abs(mod(snow_flake,1.0)-1.0);
		snow_shape += 0.01 * abs(2.0 * fract(10.0 * snow_flake)-1.0);
		float dist = 0.05 * max(snow_shape.x - snow_shape.y, snow_shape.x + snow_shape.y)+max(snow_shape.x,snow_shape.y)-0.01;
		float edge = 0.05 * min(0.5 * abs(i-5.0),1.0);
		//smothing out the snowflake
		color += vec3(smoothstep(edge,-edge, dist));
	}
	COLOR = mix(texture(TEXTURE,SCREEN_UV) , vec4(vec3(color),0.0),snowon);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
