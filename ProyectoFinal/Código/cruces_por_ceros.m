% Función para obtener la tasa de cruces por cero
function salida = cruces_por_ceros(segmentos) 
    seg_env = enventanado(segmentos);
    signox = sign(seg_env);
    signox = sum(abs(signox(2:end,:)-signox(1:end-1,:))/2);
    salida = signox/size(segmentos,1);
end