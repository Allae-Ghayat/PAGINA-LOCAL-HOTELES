% Funci�n para obtener los �ndices de cada casilla del tablero
function [m] = IndMatrix(N)
    
    cont = 1;
    for i = 1:N
        for j =1:N
            m(j,i) = cont;
            cont = cont+1;
        end
    end
end