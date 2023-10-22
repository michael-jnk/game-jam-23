shader_type canvas_item;

uniform bool active = false;


void fragment() {
	// Place fragment code here.
	vec4 new_color;
	vec4 previousColor = texture(TEXTURE, UV);
	vec4 whiteColor = vec4(1.0,1.0,1.0, previousColor.a);
	if (active) {
		new_color = whiteColor;
	} else {
		new_color = previousColor;
	}
	COLOR = new_color;
}