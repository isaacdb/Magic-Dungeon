shader_type canvas_item;

uniform vec4 base_color : source_color;

void fragment() {
	vec4 color = texture(TEXTURE, UV); // Pega cor do pixel
	float colorAverage = (color.r + color.g + color.b) / 3.0; // Definindo os pixel para media, fica preto e branco.
	COLOR = vec4(colorAverage, colorAverage, colorAverage,  color.a) * base_color; // Multiplica a tonalidade preto e branco, com uma cor base.
}
