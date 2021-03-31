% Función para aplicar la preénfasis a la señal de audio
function signal = preenfasis(signal,a)
    signal = filter([1 -a],1,signal);
end