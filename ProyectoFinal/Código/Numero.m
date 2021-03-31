% Función para obtener el número dicho por el jugador e identificarlo
function[num] = Numero(cc_uno,cc_dos,cc_tres)

    cc = muestreo();

    d_uno = DTW2(cc,cc_uno);
    d_dos = DTW2(cc,cc_dos);
    d_tres = DTW2(cc,cc_tres);


    num = min(d_uno,min(d_dos,d_tres));
    if(num == d_uno)
        num = 1; 
        disp('1');
    elseif(num == d_dos)
        num = 2;
        disp('2');
    else
        num = 3;
        disp('3');
    end
end