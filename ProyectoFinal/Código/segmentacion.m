% Función para obtener los segmentos de la señal de audio
function segmentos = segmentacion(signal,num_muestras,despl)
    segmentos = buffer(signal,num_muestras,num_muestras-despl,'nodelay');
end