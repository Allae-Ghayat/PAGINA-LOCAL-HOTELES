% Funci�n para obtener la energ�a
function salida = energia(segmentos)
    segmentos_enventados = enventanado(segmentos);
    salida = sum(segmentos_enventados .^ 2);
end