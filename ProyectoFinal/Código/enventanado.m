% Función para obtener la señal enventanada
function segmentos_enventados = enventanado(segmentos)    
    N = size(segmentos,1);
    v = hamming(N);
    columnas = size(segmentos,2);
    B = repmat(v,1,columnas);
    segmentos_enventados = segmentos .* B;
end