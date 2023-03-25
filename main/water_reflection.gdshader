shader_type canvas_item;

// Determines the color of the texture that will be shaded
uniform vec4 water_color : source_color;

uniform sampler2D sky_texture;
uniform sampler2D noise;
uniform vec2 distortion_scale;
uniform float intensity;
uniform float speed;

void fragment() {
	float distortion = texture(noise, SCREEN_UV * distortion_scale + TIME * speed).x;
	distortion -= .5;
	distortion *= intensity;
	
	vec2 reflected_screenuv = vec2(SCREEN_UV.x - distortion, SCREEN_UV.y);
	
	vec4 reflection = texture(sky_texture, reflected_screenuv);
	
	if (step(COLOR.g, 0.6) == 1.0){
		COLOR.rgb = reflection.rgb;
	}
	
}
