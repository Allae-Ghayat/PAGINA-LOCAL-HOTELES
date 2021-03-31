% Función principal donde se carga la interfaz y se realiza todo lo
% referente al backend de la aplicación
function varargout = PruebaInterfaz(varargin)
% PRUEBAINTERFAZ MATLAB code for PruebaInterfaz.fig
%      PRUEBAINTERFAZ, by itself, creates a new PRUEBAINTERFAZ or raises the existing
%      singleton*.
%
%      H = PRUEBAINTERFAZ returns the handle to a new PRUEBAINTERFAZ or the handle to
%      the existing singleton*.
%
%      PRUEBAINTERFAZ('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PRUEBAINTERFAZ.M with the given input arguments.
%
%      PRUEBAINTERFAZ('Property','Value',...) creates a new PRUEBAINTERFAZ or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PruebaInterfaz_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PruebaInterfaz_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PruebaInterfaz

% Last Modified by GUIDE v2.5 24-Jan-2021 11:31:38

% Begin initialization code - DO NOT EDIT
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @PruebaInterfaz_OpeningFcn, ...
                       'gui_OutputFcn',  @PruebaInterfaz_OutputFcn, ...
                       'gui_LayoutFcn',  [] , ...
                       'gui_Callback',   []);
    if nargin && ischar(varargin{1})
        gui_State.gui_Callback = str2func(varargin{1});
    end

    if nargout
        [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
    else
        gui_mainfcn(gui_State, varargin{:});
    end
% End initialization code - DO NOT EDIT


% --- Executes just before PruebaInterfaz is made visible.
function PruebaInterfaz_OpeningFcn(hObject, eventdata, handles, varargin)
    % This function has no output args, see OutputFcn.
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    % varargin   command line arguments to PruebaInterfaz (see VARARGIN)

    % Choose default command line output for PruebaInterfaz
    handles.output = hObject;
    load Datos.mat;
    handles.Texto = "";

    %Inicializaciones de matriz e imagenes
    handles.mat = zeros(3); %Matriz para comprobar si se ha ganao ya
    handles.mat2 = rectablero(); %Matriz cuando cargamos imagen
    handles.soluciones = [1 2 3;4 5 6; 7 8 9;1 4 7;2 5 8; 3 6 9 ;1 5 9;3 5 7];
    im = imread('raya.png');
    im2 = imread('tablero.jpeg');

    [centers,radii] = imfindcircles(im,[10 15],'ObjectPolarity','dark','Sensitivity',0.965,'Method','twostage'); 
    [centers,radii] = Reordenar(centers,radii);  % Los circulos del tablero estan desordenados
    handles.centros = centers;
    handles.radios = radii;
    handles.imagen = im;
    handles.imagen2 = im2;
    handles.turno = 3;   % Los turnos seran 3 o -3, aprovechamos este truco para usarlo en la comprobaciond de la solucion
    handles.cc_uno = cc_uno;
    handles.cc_dos = cc_dos;
    handles.cc_tres= cc_tres;

    % Update handles structure
    guidata(hObject, handles);

    % UIWAIT makes PruebaInterfaz wait for user response (see UIRESUME)
    % uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PruebaInterfaz_OutputFcn(hObject, eventdata, handles) 
    % varargout  cell array for returning output args (see VARARGOUT);
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Get default command line output from handles structure
    varargout{1} = handles.output;

%BOTON PARA EMPEZAR UNA PARTIDA NUEVA
% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
    % hObject    handle to pushbutton1 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    safe = false;
    [f,c] = size(handles.mat);
    MaxMov = f*c;   %%Maximos de movimientos
    contMov = 0;
    matIndices = IndMatrix(size(handles.mat,1));    %Matriz de indices
    indAzules = [];
    indRojos = [];
    size(handles.cc_dos);
    
    while safe == false && contMov < MaxMov
        if handles.turno == 3
            handles.Texto = "Turno de los rojos";
            guidata(hObject, handles);
            edit1_Callback(hObject, eventdata, handles);    % Llamo al texto
        else
            handles.Texto = "Turno de los azules";
            guidata(hObject, handles);
            edit1_Callback(hObject, eventdata, handles);    % Llamo al texto
        end
        pause(2);     
        %Pedir ficha
        % Pedimos la fila
        handles.Texto = "Piense la fila";
        guidata(hObject, handles);
        edit1_Callback(hObject, eventdata, handles);    % Llamo al texto
        pause(1);

        % Damos 5 segundos para que piense con una cuenta atrás
        cont = 5;
        while(cont > 0)
            handles.Texto = cont;
            guidata(hObject, handles);
            edit1_Callback(hObject, eventdata, handles);    % Llamo al texto    
            cont = cont - 1;
            pause(1);
        end    

        % Obtenemos la fila
        handles.Texto = "Introduzca fila";
        guidata(hObject, handles);
        edit1_Callback(hObject, eventdata, handles);    % Llamo al texto
        fila = Numero(handles.cc_uno,handles.cc_dos,handles.cc_tres);

        % Pedimos la columna
        handles.Texto = "Piense la columna";    
        guidata(hObject, handles);
        edit1_Callback(hObject, eventdata, handles);
        pause(1);

        % Damos 5 segundos para que piense con una cuenta atrás
        cont = 5;
        while(cont > 0)
            handles.Texto = cont;
            guidata(hObject, handles);
            edit1_Callback(hObject, eventdata, handles);    % Llamo al texto    
            cont = cont - 1;
            pause(1);
        end

        % Obtenemos la columna
        handles.Texto="Introduzca columna";
        guidata(hObject, handles);
        edit1_Callback(hObject, eventdata, handles);
        col = Numero(handles.cc_uno,handles.cc_dos,handles.cc_tres);

        % Comprobar si la posición está vacía
        if handles.mat(fila,col) ==0    % Sitio vacío
            if handles.turno == 3
                handles.mat(fila,col) = 1;
            else
                handles.mat(fila,col) = -1;
            end
            handles.mat

        % Si está vacía, comprobar si es solución
            safe = ComprobacionSol(handles.soluciones,handles.mat,handles.turno);

        % Mostrarlo en la Interfaz
        if handles.turno == 3    % Color rojo
            indRojos = [indRojos matIndices(fila,col)];
            imshow(handles.imagen);
            h = viscircles(handles.centros(indRojos,:),handles.radios(indRojos),'Color','r');   %Para ver los circulos
            h = viscircles(handles.centros(indAzules,:),handles.radios(indAzules),'Color','b');
        else
            indAzules = [indAzules matIndices(fila,col)];
            imshow(handles.imagen);
            h = viscircles(handles.centros(indAzules,:),handles.radios(indAzules),'Color','b');
            h = viscircles(handles.centros(indRojos,:),handles.radios(indRojos),'Color','r');
        end
        guidata(hObject, handles);
        % Cambiar turno
            handles.turno = handles.turno*-1;
            guidata(hObject, handles);
            contMov = contMov+1;
        else
            handles.Texto = "Ficha ocupada...repita";
            guidata(hObject, handles);
            edit1_Callback(hObject, eventdata, handles);
        end
        pause(1);
    end

    % Comprobar ganador
    if contMov == MaxMov && safe ==false
        f = msgbox('EMPATE');
    elseif safe && true
        if handles.turno == -3
            f = msgbox('HA GANADO EL ROJO');
        else
            f = msgbox('HA GANADO EL AZUL');
        end
    end
    
 
%BOTON PARA TABLERO EMPEZADO
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
    % hObject    handle to pushbutton2 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    handles.Texto = "Mostrando imagen cargada...";
    guidata(hObject, handles);
    edit1_Callback(hObject, eventdata, handles);
    imshow(handles.imagen2);
    pause(2);
    safe = false;
    [f,c] = size(handles.mat2);
    MaxMov = f*c;   % Número máximo de movimientos
    contMov = 0;
    matIndices = IndMatrix(size(handles.mat2,1));    % Matriz de indices
    indAzules = [];
    indRojos = [];
    
    % Cargar Tablero
    indRojos = find( handles.mat2 == 1);  % Equipo rojo
    indAzules = find(handles.mat2 == -1); % Equipo azul

    imshow(handles.imagen);
    h = viscircles(handles.centros(indRojos,:),handles.radios(indRojos),'Color','r');   % Para ver los circulos
    h = viscircles(handles.centros(indAzules,:),handles.radios(indAzules),'Color','b');
    guidata(hObject, handles);

    % Decido el turno, por defecto , si hay el mismo número de piezas del 
    % mismo tipo,epiezan los rojos
    if length(indAzules) <  length(indRojos)
        handles.turno = -3;
    else
        handles.turno = 3;
    end
    
    contMov = length(indAzules) +  length(indRojos);

    while safe == false && contMov < MaxMov
        if handles.turno == 3
            handles.Texto = "Turno de los rojos";
            guidata(hObject, handles);
            edit1_Callback(hObject, eventdata, handles);    % Llamo al texto
        else
            handles.Texto = "Turno de los azules";
            guidata(hObject, handles);
            edit1_Callback(hObject, eventdata, handles);    % Llamo al texto
        end
        pause(2);     
        % Pedir ficha
        % Pedimos la fila
        handles.Texto = "Piense la fila";
        guidata(hObject, handles);
        edit1_Callback(hObject, eventdata, handles);    % Llamo al texto
        pause(1);

        % Damos 5 segundos para que piense con una cuenta atrás
        cont = 5;
        while(cont > 0)
            handles.Texto = cont;
            guidata(hObject, handles);
            edit1_Callback(hObject, eventdata, handles);    % Llamo al texto    
            cont = cont - 1;
            pause(1);
        end

        % Obtenemos la fila
        handles.Texto = "Introduzca fila";
        guidata(hObject, handles);
        edit1_Callback(hObject, eventdata, handles);    % Llamo al texto
        fila = Numero(handles.cc_uno,handles.cc_dos,handles.cc_tres);
        pause(1);

        % Pedimos la columna
        handles.Texto = "Piense la columna";    
        guidata(hObject, handles);
        edit1_Callback(hObject, eventdata, handles);
        pause(1);

        % Damos 5 segundos para que piense con una cuenta atrás
        cont = 5;
        while(cont > 0)
            handles.Texto = cont;
            guidata(hObject, handles);
            edit1_Callback(hObject, eventdata, handles);    % Llamo al texto    
            cont = cont - 1;
            pause(1);
        end    

        % Obtenemos la columna
        handles.Texto = "Introduzca columna";
        guidata(hObject, handles);
        edit1_Callback(hObject, eventdata, handles);
        col = Numero(handles.cc_uno,handles.cc_dos,handles.cc_tres);
        pause(1);

        % Comprobar si la posición está vacía
        if handles.mat2(fila,col) == 0    % Sitio vacío
            if handles.turno == 3
                handles.mat2(fila,col) = 1;
            else
                handles.mat2(fila,col) = -1;
            end
            handles.mat2

        % Si está vacía, comprobar si es solución
            safe = ComprobacionSol(handles.soluciones,handles.mat2,handles.turno);

        % Mostrarlo en la Interfaz    
        if(size(indRojos,1) > size(indRojos,2))
            indRojos = indRojos';
        end
        if(size(indAzules,1) > size(indAzules,2))
            indAzules = indAzules';
        end

        if handles.turno == 3    % Color rojo
            indRojos = [indRojos matIndices(fila,col)];
            imshow(handles.imagen);
            h = viscircles(handles.centros(indRojos,:),handles.radios(indRojos),'Color','r');   % Para ver los circulos
            h = viscircles(handles.centros(indAzules,:),handles.radios(indAzules),'Color','b');
        else
            indAzules = [indAzules matIndices(fila,col)];
            imshow(handles.imagen);
            h = viscircles(handles.centros(indAzules,:),handles.radios(indAzules),'Color','b');
            h = viscircles(handles.centros(indRojos,:),handles.radios(indRojos),'Color','r');
        end
        guidata(hObject, handles);

        % Cambiar turno
            handles.turno = handles.turno*-1;
            guidata(hObject, handles);
            contMov = contMov+1;
        else
            handles.Texto = "Ficha ocupada...repita";
            guidata(hObject, handles);
            edit1_Callback(hObject, eventdata, handles);
        end
        pause(1);
    end
    
    % Comprobar ganador
    if contMov == MaxMov && safe ==false
        f = msgbox('EMPATE');
    elseif safe && true
        if handles.turno == -3
            f = msgbox('HA GANADO EL ROJO');
        else
            f = msgbox('HA GANADO EL AZUL');
        end
    end    

function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double

%msgbox( sprintf('Your Balance is ') ); Para abrir una ventana

set(handles.edit1,'String',handles.Texto);



% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function pushbutton1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --------------------------------------------------------------------
function uipanel1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to uipanel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1

 
 



