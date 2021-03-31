% Función para obtener la energía
function salida = energia(segmentos)
    segmentos_enventados = enventanado(segmentos);
    salida = sum(segmentos_enventados .^ 2);
end