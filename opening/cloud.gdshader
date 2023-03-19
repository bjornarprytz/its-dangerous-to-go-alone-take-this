shader_type canvas_item;

uniform sampler2D noise_tex : source_color, repeat_enable;
uniform sampler2D noise_tex2 : source_color, repeat_enable;
uniform vec2 scroll = vec2(0.9, 0.5);

uniform float speed : hint_range(0.0, 1.0) = 0.03;
uniform float fluffiness : hint_range(0.0, 2.0) = 0.1;
uniform float alpha : hint_range(0.0, 1.0) = 0.4;

void fragment() {
	vec4 noise = texture(noise_tex, UV + (TIME * scroll * speed));
	vec4 noise2 = texture(noise_tex2, UV + (TIME * fluffiness * speed));
	vec4 combinedNoise = ((noise * 2.0) + noise2) / 3.0;
	
	COLOR =  combinedNoise; // texture(noise_tex, UV + (scroll * TIME  * speed));
	COLOR.a = alpha;
}
