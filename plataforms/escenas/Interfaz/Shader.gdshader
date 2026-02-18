shader_type canvas_item;

uniform float lod: hint_range(0.0, 5.0) = 2.0; // Intensidad del blur
uniform vec4 color_tinte : source_color = vec4(1.0, 0.0, 0.0, 0.4); // Rojo con transparencia
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

void fragment() {
    // 1. Obtenemos la textura de la pantalla con el desenfoque (LOD)
    vec4 pantalla = textureLod(SCREEN_TEXTURE, SCREEN_UV, lod);
    
    // 2. Mezclamos el color de la pantalla con nuestro tinte rojo
    // El 0.5 final controla qué tan "rojo" se ve (0.0 nada, 1.0 todo rojo)
    vec3 final_rgb = mix(pantalla.rgb, color_tinte.rgb, color_tinte.a);
    
    COLOR = vec4(final_rgb, 1.0);
}