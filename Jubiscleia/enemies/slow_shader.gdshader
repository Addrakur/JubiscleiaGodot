shader_type canvas_item;

uniform float blue_value;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	if (COLOR.a > 0.0){
		COLOR = COLOR + vec4(0.0,0.0,blue_value,1);
		}
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
