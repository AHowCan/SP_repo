shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

// uniform vec4 overlay_color :hint_color = vec4(1.0, 0.0, 0.0, 0.5);

//void fragment() {
    //// vec4 tex_color = texture(TEXTURE, FRAGCOORD.xy / SCREEN_PIXEL_SIZE);
    //// COLOR = mix(tex_color, overlay_color, overlay_color.a);
	//COLOR.b = 1.0;
//}

//void fragment() {
    //vec2 uv = FRAGCOORD.xy / SCREEN_PIXEL_SIZE;
    //vec2 center = vec2(0.5, 0.5);
    //float radius = 0.5;
    //float dist = distance(uv, center);
    //
    //if (dist > radius) {
        //discard;
    //} else {
        //float vignette = smoothstep(radius, radius - 0.1, dist);
        //COLOR.rgb *= vignette;
    //}
//}

uniform float radius : hint_range(0.0, 1.0);
uniform vec4 fog_color;
uniform float fog_density : hint_range(0.0, 1.0);

void fragment() {
    vec2 uv = FRAGCOORD.xy / SCREEN_PIXEL_SIZE;
    vec2 center = vec2(0.5, 0.5);
    float dist = distance(uv, center);

    // Tunnel vision effect
    float vignette = smoothstep(radius, radius + 0.1, dist);

    // Fog effect
    float fog = smoothstep(radius, radius + fog_density, dist);

    vec4 color = texture(TEXTURE, UV);
    color.rgb = mix(color.rgb, fog_color.rgb, fog);

    COLOR = vec4(color.rgb * vignette, color.a);
}
