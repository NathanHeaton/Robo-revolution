shader_type canvas_item;

uniform sampler2D noise;

void vertex() {
}

void fragment() {
	vec4 test = texture(TEXTURE, UV * sin(TIME*5.0) );
	//vec4 spirte = texture(TEXTURE)
	test.a = 0.2;
	COLOR = test;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
