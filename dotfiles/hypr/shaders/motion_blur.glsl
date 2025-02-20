#version 330 core

uniform float u_time; // Tiempo transcurrido
uniform sampler2D u_texture; // Textura de la pantalla

in vec2 v_tex_coords; // Coordenadas de textura
out vec4 frag_color; // Color de salida

void main() {
    vec2 uv = v_tex_coords;
    vec4 color = texture(u_texture, uv);

    // Efecto de motion blur
    float blur_amount = 0.01; // Ajusta este valor para más/menos blur
    vec2 blur_direction = vec2(1.0, 0.0); // Dirección del blur (horizontal)

    for (int i = 0; i < 5; i++) {
        uv += blur_direction * blur_amount;
        color += texture(u_texture, uv);
    }

    color /= 6.0; // Promedia los colores para el efecto de blur
    frag_color = color;
}
