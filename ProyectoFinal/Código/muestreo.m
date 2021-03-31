% Función para obtener la señal de audio y preprocesarla
function [cc,segmentos] = muestreo()
    % Obtener la señal
    t = 1;
    Fs = 8000;
    Ch = 1;
    num_bits = 16;
    grabado = 1;
    
    while(grabado == 1)
        signal = grabacion(t,Fs,Ch,num_bits);
        
        if(max(signal) > 0.01)
            grabado = 0;
        else
            disp('Repita el número');
            pause(1);
        end
    end    

    % Preénfasis
    a = 0.95;
    signal = preenfasis(signal,a);

    % Segmentación
    num_muestras = 0.03 * Fs;
    despl = 0.01 * Fs;
    segmentos = segmentacion(signal,num_muestras,despl);

    % Inicio y fin de la palabra
    num_segmentos_ruido = 10;
    segmentos = inicio_fin(segmentos, num_segmentos_ruido);    
    
    % Enventanado
    segmentos_enventados = enventanado(segmentos);

    % Extracción de características
    cc = caracteristicas(segmentos_enventados);
end