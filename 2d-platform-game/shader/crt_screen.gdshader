shader_type canvas_item;
render_mode unshaded,skip_vertex_transform;
// this is the sader to make the game looks like a CRT TV
uniform sampler2D screen_texture: hint_screen_texture, filter_linear_mipmap;
uniform float vignette_multiplier = 0.8;
uniform float curvature =7.0;

void fragment() {
	vec2 centered_uv = SCREEN_UV *2.0-1.0;
	vec2 uv_offset = centered_uv.yx / curvature;
	// this is to make it looks warp
	vec2 warped_uv = centered_uv + centered_uv * uv_offset* uv_offset;
	vec3 cutoff = vec3(step(abs(warped_uv.x),1.0) * step(abs(warped_uv.y),1.0));
	// this is adding the lines you see on the screen
	vec3 scanlines = vec3(sin(warped_uv.y*324.0)*0.25+0.75);
	// this is adding the affect to make the surroned border darken
	vec3 vignette = vec3(length(pow(abs(centered_uv),vec2(4.0)) /3.0));
	vec3 screen_color = textureLod(screen_texture,(warped_uv+1.0)/2.0,0.2).rgb * cutoff * scanlines;
	screen_color -= vignette * vignette_multiplier;
	COLOR = vec4(screen_color,1.0);
}
