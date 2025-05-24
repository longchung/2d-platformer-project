shader_type canvas_item;
// use d/r for alha and 1 for alpha2
// this is the dark cave with a light up area around the player shader
uniform float bright = 0.0;
uniform float bright2 = 0.0;
void fragment() {
	// the next used to fix the shape of the cirle around the player
	vec2 uv = UV - 0.5;
	uv.x *= 1.7;
	// use as value to draw the see through circle around the player
	float d = length(uv);
	float r =0.3;
	float alpha =0.0;
	if (bright ==1.0){
		alpha =d/r;
	}
	else{
		alpha=bright;
	}
	float alpha2 = bright2;
	// if within the area of the circle draw arounf the player, then it is transparent
	// if outside that area then just make it black
	if (d < r){
		COLOR = vec4(0,0,0,alpha);
	}
	else{
		COLOR = vec4(0,0,0,alpha2);
	}
}


//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
