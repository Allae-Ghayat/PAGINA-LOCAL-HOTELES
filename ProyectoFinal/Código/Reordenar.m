% Función para ordenar los círculos (fichas) del tablero
function[cen,rad] = Reordenar(centros,radios)
    cen(1,:) = centros(8,:);
    cen(2,:) = centros(1,:);
    cen(3,:) = centros(9,:);
    cen(4,:) = centros(3,:);
    cen(5,:) = centros(5,:);
    cen(6,:) = centros(2,:);
    cen(7,:) = centros(7,:);
    cen(8,:) = centros(4,:);
    cen(9,:) = centros(6,:);

    rad(1) = radios(8);
    rad(2) = radios(1);
    rad(3) = radios(9);
    rad(4) = radios(3);
    rad(5) = radios(5);
    rad(6) = radios(2);
    rad(7) = radios(7);
    rad(8) = radios(4);
    rad(9) = radios(6);
end