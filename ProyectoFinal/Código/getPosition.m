% Función para obtener en que casilla se encuentra una ficha
% de una imagen de un tablero
function [fila,col] = getPosition(eje_x, eje_y)
    
    % Obtener fila
    if(eje_x < 124)
        fila = 1;
    elseif(eje_x < 237)
        fila = 2;
    else
        fila = 3;
    end
    
    % Obtener columna
    if(eje_y < 110)
        col = 1;
    elseif(eje_x < 227)
        col = 2;
    else
        col = 3;
    end
end