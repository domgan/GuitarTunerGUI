function varargout = tunfig(varargin)
% TUNFIG MATLAB code for tunfig.fig
%      TUNFIG, by itself, creates a new TUNFIG or raises the existing
%      singleton*.
%
%      H = TUNFIG returns the handle to a new TUNFIG or the handle to
%      the existing singleton*.
%
%      TUNFIG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TUNFIG.M with the given input arguments.
%
%      TUNFIG('Property','Value',...) creates a new TUNFIG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before tunfig_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to tunfig_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help tunfig

% Last Modified by GUIDE v2.5 09-May-2019 09:03:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @tunfig_OpeningFcn, ...
                   'gui_OutputFcn',  @tunfig_OutputFcn, ...
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


% --- Executes just before tunfig is made visible.
function tunfig_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to tunfig (see VARARGIN)

% Choose default command line output for tunfig
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes tunfig wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = tunfig_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in strojenia.
function strojenia_Callback(hObject, eventdata, handles)
strojenie = handles.strojenia.Value;
switch strojenie
    case 1
       handles.struna1.String = 'E2 - 82 Hz';
       handles.struna2.String = 'A2 - 110 Hz';
       handles.struna3.String = 'D3 - 147 Hz';
       handles.struna4.String = 'G3 - 196 Hz';
       handles.struna5.String = 'B3 - 247 Hz';
       handles.struna6.String = 'E4 - 330 Hz';
    case 2
       handles.struna1.String = 'D2 - 73 Hz';
       handles.struna2.String = 'A2 - 110 Hz';
       handles.struna3.String = 'D3 - 147 Hz';
       handles.struna4.String = 'G3 - 196 Hz';
       handles.struna5.String = 'B3 - 247 Hz';
       handles.struna6.String = 'E4 - 330 Hz';
    case 3
       handles.struna1.String = 'D2 - 73 Hz';
       handles.struna2.String = 'A2 - 110 Hz';
       handles.struna3.String = 'D3 - 147 Hz';
       handles.struna4.String = 'G3 - 196 Hz';
       handles.struna5.String = 'B3 - 247 Hz';
       handles.struna6.String = 'D4 - 294 Hz';
    case 4
       handles.struna1.String = 'D2 - 73 Hz';
       handles.struna2.String = 'G2 - 98 Hz';
       handles.struna3.String = 'D3 - 147 Hz';
       handles.struna4.String = 'G3 - 196 Hz';
       handles.struna5.String = 'B3 - 247 Hz';
       handles.struna6.String = 'D4 - 294 Hz';
       
end
% hObject    handle to strojenia (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns strojenia contents as cell array
%        contents{get(hObject,'Value')} returns selected item from strojenia


% --- Executes during object creation, after setting all properties.
function strojenia_CreateFcn(hObject, eventdata, handles)
% hObject    handle to strojenia (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in recb.
function recb_Callback(hObject, eventdata, handles)
fs=48000;
tr=5;
rec = audiorecorder(fs,16,1);
disp('Szarpnij strunê.');
recordblocking(rec, tr);
disp('Koniec nagrywania.');
adata = getaudiodata(rec);
adata(length(adata)+1,:)=0;
ts=[0:1/fs:tr];
y = abs(fft(adata'))/length(adata');
f=[0:1/max(ts):fs];
%wykres czasowy
subplot(2,1,1)
plot(adata);
grid on;
title('Wykres czasowy dŸwiêku')
ylabel('Amplituda')
xlabel('Czas [s]')
ylim([-1 1])
%spectrum
subplot(2,1,2)
semilogx(f,10*log10(y))
xlim([10 20000])  
grid on;
title('Wykres spectrum dŸwiêku')
ylabel('Amplituda [dB]')
xlabel('Czêstotliwoœæ [Hz]')
%axes(handles.axes1)
%wykrycie
[~, maxH] = max(10*log10(y));
h = f(maxH);
handles.wf.String = h + " Hz";
%struny
strojenie = handles.strojenia.Value;
switch strojenie
    case 1 %strojenie EADGBE
        if handles.struna1.Value==1
            s=82-h;
            if s<0
                s=-s;
                handles.str.String="Zmniejsz czêstotliwoœæ o " + s + " Hz";
            elseif s>0
                handles.str.String="Zwiêksz czêstotliwoœæ o " + s + " Hz";
            elseif abs(s)<1
                handles.str.String="Struna jest nastrojona.";
            end
        elseif handles.struna2.Value==1
            s=110-h;
            if s<-1
                s=-s;
                handles.str.String="Zmniejsz czêstotliwoœæ o " + s + " Hz";
            elseif s>1
                handles.str.String="Zwiêksz czêstotliwoœæ o " + s + " Hz";
            elseif abs(s)<=1
                handles.str.String="Struna jest nastrojona.";
            end
         elseif handles.struna3.Value==1
            s=147-h;
            if s<0
                s=-s;
                handles.str.String="Zmniejsz czêstotliwoœæ o " + s + " Hz";
            elseif s>0
                handles.str.String="Zwiêksz czêstotliwoœæ o " + s + " Hz";
            elseif abs(s)<1
                handles.str.String="Struna jest nastrojona.";
            end
         elseif handles.struna4.Value==1
            s=196-h;
            if s<0
                s=-s;
                handles.str.String="Zmniejsz czêstotliwoœæ o " + s + " Hz";
            elseif s>0
                handles.str.String="Zwiêksz czêstotliwoœæ o " + s + " Hz";
            elseif abs(s)<1
                handles.str.String="Struna jest nastrojona.";
            end
         elseif handles.struna5.Value==1
            s=247-h;
            if s<0
                s=-s;
                handles.str.String="Zmniejsz czêstotliwoœæ o " + s + " Hz";
            elseif s>0
                handles.str.String="Zwiêksz czêstotliwoœæ o " + s + " Hz";
            elseif abs(s)<1
                handles.str.String="Struna jest nastrojona.";
            end
         elseif handles.struna6.Value==1
            s=330-h;
            if s<0
                s=-s;
                handles.str.String="Zmniejsz czêstotliwoœæ o " + s + " Hz";
            elseif s>0
                handles.str.String="Zwiêksz czêstotliwoœæ o " + s + " Hz";
            elseif abs(s)<1
                handles.str.String="Struna jest nastrojona.";
            end
        end
    case 2 %strojenie DADGBE
        if handles.struna1.Value==1
            s=73-h;
            if s<0
                s=-s;
                handles.str.String="Zmniejsz czêstotliwoœæ o " + s + " Hz";
            elseif s>0
                handles.str.String="Zwiêksz czêstotliwoœæ o " + s + " Hz";
            elseif abs(s)<1
                handles.str.String="Struna jest nastrojona.";
            end
        elseif handles.struna2.Value==1
            s=110-h;
            if s<0
                s=-s;
                handles.str.String="Zmniejsz czêstotliwoœæ o " + s + " Hz";
            elseif s>0
                handles.str.String="Zwiêksz czêstotliwoœæ o " + s + " Hz";
            elseif abs(s)<1
                handles.str.String="Struna jest nastrojona.";
            end
         elseif handles.struna3.Value==1
            s=147-h;
            if s<0
                s=-s;
                handles.str.String="Zmniejsz czêstotliwoœæ o " + s + " Hz";
            elseif s>0
                handles.str.String="Zwiêksz czêstotliwoœæ o " + s + " Hz";
            elseif abs(s)<1
                handles.str.String="Struna jest nastrojona.";
            end
         elseif handles.struna4.Value==1
            s=196-h;
            if s<0
                s=-s;
                handles.str.String="Zmniejsz czêstotliwoœæ o " + s + " Hz";
            elseif s>0
                handles.str.String="Zwiêksz czêstotliwoœæ o " + s + " Hz";
            elseif abs(s)<1
                handles.str.String="Struna jest nastrojona.";
            end
         elseif handles.struna5.Value==1
            s=247-h;
            if s<0
                s=-s;
                handles.str.String="Zmniejsz czêstotliwoœæ o " + s + " Hz";
            elseif s>0
                handles.str.String="Zwiêksz czêstotliwoœæ o " + s + " Hz";
            elseif abs(s)<1
                handles.str.String="Struna jest nastrojona.";
            end
         elseif handles.struna6.Value==1
            s=330-h;
            if s<0
                s=-s;
                handles.str.String="Zmniejsz czêstotliwoœæ o " + s + " Hz";
            elseif s>0
                handles.str.String="Zwiêksz czêstotliwoœæ o " + s + " Hz";
            elseif abs(s)<1
                handles.str.String="Struna jest nastrojona.";
            end
        end
    case 3 %strojenie DADGBD
        if handles.struna1.Value==1
            s=73-h;
            if s<0
                s=-s;
                handles.str.String="Zmniejsz czêstotliwoœæ o " + s + " Hz";
            elseif s>0
                handles.str.String="Zwiêksz czêstotliwoœæ o " + s + " Hz";
            elseif abs(s)<1
                handles.str.String="Struna jest nastrojona.";
            end
        elseif handles.struna2.Value==1
            s=110-h;
            if s<0
                s=-s;
                handles.str.String="Zmniejsz czêstotliwoœæ o " + s + " Hz";
            elseif s>0
                handles.str.String="Zwiêksz czêstotliwoœæ o " + s + " Hz";
            elseif abs(s)<1
                handles.str.String="Struna jest nastrojona.";
            end
         elseif handles.struna3.Value==1
            s=147-h;
            if s<0
                s=-s;
                handles.str.String="Zmniejsz czêstotliwoœæ o " + s + " Hz";
            elseif s>0
                handles.str.String="Zwiêksz czêstotliwoœæ o " + s + " Hz";
            elseif abs(s)<1
                handles.str.String="Struna jest nastrojona.";
            end
         elseif handles.struna4.Value==1
            s=196-h;
            if s<0
                s=-s;
                handles.str.String="Zmniejsz czêstotliwoœæ o " + s + " Hz";
            elseif s>0
                handles.str.String="Zwiêksz czêstotliwoœæ o " + s + " Hz";
            elseif abs(s)<1
                handles.str.String="Struna jest nastrojona.";
            end
         elseif handles.struna5.Value==1
            s=247-h;
            if s<0
                s=-s;
                handles.str.String="Zmniejsz czêstotliwoœæ o " + s + " Hz";
            elseif s>0
                handles.str.String="Zwiêksz czêstotliwoœæ o " + s + " Hz";
            elseif abs(s)<1
                handles.str.String="Struna jest nastrojona.";
            end
         elseif handles.struna6.Value==1
            s=294-h;
            if s<0
                s=-s;
                handles.str.String="Zmniejsz czêstotliwoœæ o " + s + " Hz";
            elseif s>0
                handles.str.String="Zwiêksz czêstotliwoœæ o " + s + " Hz";
            elseif abs(s)<1
                handles.str.String="Struna jest nastrojona.";
            end
        end    
   case 4 %strojenie DGDGBD
        if handles.struna1.Value==1
            s=73-h;
            if s<0
                s=-s;
                handles.str.String="Zmniejsz czêstotliwoœæ o " + s + " Hz";
            elseif s>0
                handles.str.String="Zwiêksz czêstotliwoœæ o " + s + " Hz";
            elseif abs(s)<1
                handles.str.String="Struna jest nastrojona.";
            end
        elseif handles.struna2.Value==1
            s=98-h;
            if s<0
                s=-s;
                handles.str.String="Zmniejsz czêstotliwoœæ o " + s + " Hz";
            elseif s>0
                handles.str.String="Zwiêksz czêstotliwoœæ o " + s + " Hz";
            elseif abs(s)<1
                handles.str.String="Struna jest nastrojona.";
            end
         elseif handles.struna3.Value==1
            s=147-h;
            if s<0
                s=-s;
                handles.str.String="Zmniejsz czêstotliwoœæ o " + s + " Hz";
            elseif s>0
                handles.str.String="Zwiêksz czêstotliwoœæ o " + s + " Hz";
            elseif abs(s)<1
                handles.str.String="Struna jest nastrojona.";
            end
         elseif handles.struna4.Value==1
            s=196-h;
            if s<0
                s=-s;
                handles.str.String="Zmniejsz czêstotliwoœæ o " + s + " Hz";
            elseif s>0
                handles.str.String="Zwiêksz czêstotliwoœæ o " + s + " Hz";
            elseif abs(s)<1
                handles.str.String="Struna jest nastrojona.";
            end
         elseif handles.struna5.Value==1
            s=247-h;
            if s<0
                s=-s;
                handles.str.String="Zmniejsz czêstotliwoœæ o " + s + " Hz";
            elseif s>0
                handles.str.String="Zwiêksz czêstotliwoœæ o " + s + " Hz";
            elseif abs(s)<1
                handles.str.String="Struna jest nastrojona.";
            end
         elseif handles.struna6.Value==1
            s=294-h;
            if s<0
                s=-s;
                handles.str.String="Zmniejsz czêstotliwoœæ o " + s + " Hz";
            elseif s>0
                handles.str.String="Zwiêksz czêstotliwoœæ o " + s + " Hz";
            elseif abs(s)<1
                handles.str.String="Struna jest nastrojona.";
            end
        end         
end
    
    

% hObject    handle to recb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3


% --- Executes on button press in struna4.
function struna4_Callback(hObject, eventdata, handles)
% hObject    handle to struna4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of struna4


% --- Executes on button press in struna5.
function struna5_Callback(hObject, eventdata, handles)
% hObject    handle to struna5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of struna5


% --- Executes on button press in struna6.
function struna6_Callback(hObject, eventdata, handles)
% hObject    handle to struna6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of struna6


% --- Executes on button press in struna1.
function struna1_Callback(hObject, eventdata, handles)
% hObject    handle to struna1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of struna1


% --- Executes on button press in struna2.
function struna2_Callback(hObject, eventdata, handles)
% hObject    handle to struna2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of struna2


% --- Executes on button press in struna3.
function struna3_Callback(hObject, eventdata, handles)
% hObject    handle to struna3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of struna3
