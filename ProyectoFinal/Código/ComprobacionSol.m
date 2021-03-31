% Función para comprobar si un estado dado de
% un tablero es una posible solución
function safe = ComprobacionSol(soluciones,mat,valor)

    safe = false;
    cont =1;
    
    while cont <= length(soluciones) && safe == false
        fila = soluciones(cont,:);
        if sum(mat(fila)) == valor
            safe = true; 
        end
        cont = cont+1;
    end
end

