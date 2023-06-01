shader_type spatial;

// Uniforms
uniform sampler2D grass_texture;
uniform float wind_strength = 0.1;
uniform float wind_speed = 1.0;

// Main function
void fragment() {
    // Texture coordinates
    vec2 uv = UV;
    
    // Add wind effect to the y coordinate of the texture
    uv.y += sin(TIME * wind_speed + uv.x * 10.0) * wind_strength;

    // Sample the texture
    vec4 tex_color = texture(grass_texture, uv);

    // Set the diffuse color
    ALBEDO = tex_color.rgb;

    // Set metallic and roughness values
    METALLIC = 0.0;
    ROUGHNESS = 1.0;
}
