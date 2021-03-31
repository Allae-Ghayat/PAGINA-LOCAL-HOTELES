% Función para obtener el inicio y fin de la palabra
function segmentos = inicio_fin(segmentos, num_segmentos_ruido)
    % Obtención de las magnitudes y cruces
    n = num_segmentos_ruido;
    magnitudes = magnitud(segmentos);
    cruces = cruces_por_ceros(segmentos);
    Ms = magnitudes(1:n);
    Zs = cruces(1:n);

    % Obtención de los umbrales
    mediaMs = mean(Ms);
    stdMs = std(Ms);
    mediaZs = mean(Zs);
    stdZs = std(Zs);

    UmbSupEnrg = 0.5 * max(magnitudes);
    UmbInfEnrg = mediaMs + 2 * stdMs;
    UmbCruCero = mediaZs + 2 * stdZs;

    % Obtención del inicio de la palabra
    % Paso 4
    ok = find(magnitudes(n+1:end) > UmbSupEnrg);
    if(ok)
        ln = ok(1) + n;  % Le sumamos 10 porque hemos obviado las 10 primeras muestras.
    else
        ln = n;
    end

    % Paso 5
    ok = find(magnitudes(1:ln) < UmbInfEnrg);
    if(ok)
        le = ok(end);
    else
        le = ln;
    end

    % Paso 6
    limit = max(n+1,le-25);
    ok = find(cruces(limit:le) > UmbCruCero);

    pos = 0;
    cont = 1;

    if(ok)
        for i=1:length(ok)-1
            if(ok(i) == ok(i+1)-1)
                cont = cont + 1;
            else
                cont = 1;
            end
            if(cont == 3)
                pos = ok(i-1);
                break
            end
        end
    end

    if(pos ~= 0)
        inicio = pos;
    else
        inicio = le;
    end

    % Ya tenemos el inicio, ahora hacer lo mismo en el otro sentido para
    % obtener el final de la señal
    % Paso 4
    ok = find(magnitudes(1:end-n) > UmbSupEnrg);
    if(ok)
        ln = ok(end);
    else
        ln = length(magnitudes)-n;
    end

    % Paso 5
    ok = find(magnitudes(ln:end) < UmbInfEnrg);
    
    if(ok)
        le = ok(1);
    else
        le = length(magnitudes);
    end
        
    % Paso 6
    limit = min(length(magnitudes)-n,le+25);
    ok = find(cruces(le:limit) > UmbCruCero);

    pos = 0;
    cont = 1;

    if(ok)
        for i=1:length(ok)-1
            if(ok(i) == ok(i+1)-1)
                cont = cont + 1;
            else
                cont = 1;
            end
            if(cont == 3)
                pos = ok(i-1);
                break
            end
        end
    end

    if(pos ~= 0)
        final = pos;
    else
        final = le;
    end
    segmentos = segmentos(:,inicio:final);
end