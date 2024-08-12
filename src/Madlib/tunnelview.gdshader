shader_type canvas_item;

uniform vec2 resolution = vec2(640.0, 360.0);
uniform sampler2D tunnel_texture: repeat_enable;
uniform float tunnel_radius: hint_range(0.1, 4.0, 0.1) = 1.0;
uniform float brightness: hint_range(0.1, 4.0, 0.1)= 2.0;
uniform float text_repeat: hint_range(0.0, 10.0, 1.0) = 4.0;
uniform float tunnel_fade: hint_range(1.0, 10.0, 0.1) = 1.5;
uniform float tunnel_speed: hint_range(0.1, 10, 0.5) = 2.0;

void fragment() {
	vec2 uv = UV - 0.5;
	uv.x *= resolution.x / resolution.y;
	vec3 ray_direction = vec3(uv, 1.0);
	float ray_length = tunnel_radius / length(ray_direction.xy);
	vec3 intersection = ray_direction * ray_length;
	float theta = text_repeat * atan(intersection.y / intersection.x) / PI;
	vec2 p = vec2(theta, intersection.z);
	p.y += TIME / tunnel_speed;
	float dist = pow(length(uv), tunnel_fade);
	vec4 pixel = texture(tunnel_texture, p) * dist;
	COLOR = pixel * brightness;
	
	// Use if you don't want it to be transparent
	//COLOR = vec4(pixel.rgb * brightness, 1.0);

}


