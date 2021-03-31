% Función para obtener la magnitud
function salida = magnitud(segmentos)
    segmentos_enventados = enventanado(segmentos);
    salida = sum(abs(segmentos_enventados));
end