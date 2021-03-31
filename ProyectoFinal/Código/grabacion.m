% Funci�n para grabar y obtener la se�al de audio
function signal = grabacion(t,Fs,Ch,num_bits)

	recObj = audiorecorder(Fs,num_bits,Ch);
    
    disp('Start speaking');
    recordblocking(recObj,t);
    disp('End of recording');
    signal = getaudiodata(recObj);
end