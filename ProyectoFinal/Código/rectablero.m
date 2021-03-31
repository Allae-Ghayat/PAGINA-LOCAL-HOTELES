% Función para obtener la imagen del tablero ya empezado y de las fichas,
% además de realizar el preprocesado de la imagen
function [aux] = rectablero()
    imagen = imread('tablero.jpeg');
    imagen = imresize(imagen,0.5);
    imagen = rgb2gray(imagen);

    imagen = edge(imagen,'log');    % Log laplaciano para detectar los bordes

    [centros, radios, ~] = imfindcircles(imagen, [20,50]);
    %viscircles(centros, radios, 'EdgeColor', 'b');
    n_monedas = length(radios);

    % Recorrer todas las monedas y dependiendo del tamaño (1€ azul, 0.10€ rojo)
    % y del centro determinar su posición.
    handles.mat = zeros(3);
    for i=1:n_monedas
        % Obtener fila y columna
        eje_y = centros(i,1);
        eje_x = centros(i,2);
        [fila, col] = getPosition(eje_x, eje_y);

        if radios(i) >= 40
            handles.mat(fila,col) = 1;  % Rojo
        else
            handles.mat(fila,col) = -1; % Azul
        end
    end
    aux = handles.mat;
end