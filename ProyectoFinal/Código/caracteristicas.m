% Función para obtener los coeficientes delta cepstrum
function rcepstrum_delta = caracteristicas(segmentos_enventados)
    num_coef = 13;
    rcepstrum = rceps(segmentos_enventados);
    rcepstrum_coefs = rcepstrum(2:num_coef,:);

    % Coeficientes delta
    P = 3;
    ponderacion = -P:1:P;
    filas = size(rcepstrum_coefs,1);
    col = size(rcepstrum_coefs,2);
    rcepstrum_aux = zeros(filas, col + 2 * P);
    rcepstrum_aux(:,P+1:end-P) = rcepstrum_coefs;
    rcepstrum_delta = rcepstrum_aux;
    v_aux = zeros(1,size(rcepstrum_delta,2));
    v_aux(P+1:end-P) = 1;

    % Calcular delta-cepstrum
    for i = P+1:P+col
        aux = rcepstrum_delta(:,i);
        M = repmat(aux,1,2*P+1);    
        N = rcepstrum_delta(:,i-P:i+P);
        M = N - M;
        M = M .* v_aux(i-P:i+P);
        M = M .* ponderacion;
        v = sum(M,2);
        d = i-P:i+P;
        p = sum(d.^2);
        v = v ./ p;    
        rcepstrum_aux(:,i) = v;
    end

    % Unir los cepstrum con los delta-cepstrum
    rcepstrum_delta = [rcepstrum_delta; rcepstrum_aux];

    % Normalizar
    medias = mean(rcepstrum_delta);
    des_tip = std(rcepstrum_delta);

    rcepstrum_delta = rcepstrum_delta - medias;
    rcepstrum_delta = rcepstrum_delta ./ des_tip;
    rcepstrum_delta = rcepstrum_delta(:,P+1:end-P);
end