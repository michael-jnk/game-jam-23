shader_type canvas_item;

uniform bool is_past = true;

void fragment() {
	vec4 previousColor = texture(TEXTURE, UV);
	vec4 newShader;
	if (is_past) {
		newShader = previousColor + vec4(.3, .3, .3, 0);
	} else {
		newShader = previousColor + vec4(.25, .25, .15, 0);
	}
	
	COLOR = newShader;
}
