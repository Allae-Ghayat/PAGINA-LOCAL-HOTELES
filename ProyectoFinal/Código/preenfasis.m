% Funci�n para aplicar la pre�nfasis a la se�al de audio
function signal = preenfasis(signal,a)
    signal = filter([1 -a],1,signal);
end