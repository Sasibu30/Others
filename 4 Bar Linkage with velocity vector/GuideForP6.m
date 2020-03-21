function varargout = GuideForP6(varargin)
% GUIDEFORP6 MATLAB code for GuideForP6.fig
%      GUIDEFORP6, by itself, creates a new GUIDEFORP6 or raises the existing
%      singleton*.
%
%      H = GUIDEFORP6 returns the handle to a new GUIDEFORP6 or the handle to
%      the existing singleton*.
%
%      GUIDEFORP6('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIDEFORP6.M with the given input arguments.
%
%      GUIDEFORP6('Property','Value',...) creates a new GUIDEFORP6 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GuideForP6_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GuideForP6_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GuideForP6

% Last Modified by GUIDE v2.5 29-Nov-2017 14:27:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GuideForP6_OpeningFcn, ...
                   'gui_OutputFcn',  @GuideForP6_OutputFcn, ...
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


% --- Executes just before GuideForP6 is made visible.
function GuideForP6_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GuideForP6 (see VARARGIN)

% Choose default command line output for GuideForP6
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

%Initialize
evalin('base','clear all');
evalin('base','clc');

hand=0;
MainDisplay='Main';
Z=0; %Track on - Number
N=0; %number

assignin('base','hand', hand);
assignin('base','MainDisplay', MainDisplay);
assignin('base','Z',Z);
assignin('base','N',N);



% UIWAIT makes GuideForP6 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GuideForP6_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in StartBut.
function StartBut_Callback(hObject, eventdata, handles)
% hObject    handle to StartBut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


contents=cellstr( get(handles.popupmenu1,'String') );
Type = contents(get(handles.popupmenu1,'Value'));


set(handles.Status,'String',Type);
Z=evalin('base','Z');

N=evalin('base','N');
N=N+1;
assignin('base','N',N);

if strcmp(Type,'P6-47')
     
    hand=1;
     
    Type = 'L1 = 56.4  L2 = 25.4  L3 = 52.3  L4 = 59.2';
    set(handles.MainDisp,'String',Type);
    
    MainP6_2(hand,Z);
    
    
elseif strcmp(Type,'P6-48')
     
    hand=2;
    
    Type = 'L1 = 244.5  L2 = 50.8  L3 = 212.7  L4 = 182.5';
    set(handles.MainDisp,'String',Type);
    
    MainP6_1(hand,Z);
    
elseif strcmp(Type,'P6-51')
    
    hand=3;
    
    Type = 'L1 = 1.82  L2 = 0.72  L3 = 0.68  L4 = 0.85';
    set(handles.MainDisp,'String',Type);
    
    MainP6(hand,Z);
          
end






% --- Executes on button press in PauseBut.
function PauseBut_Callback(hObject, eventdata, handles)
% hObject    handle to PauseBut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
evalin('base','pause');

% --- Executes on button press in CheckBox.
function CheckBox_Callback(hObject, eventdata, handles)
% hObject    handle to CheckBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CheckBox
Z=evalin('base','Z');
Z=Z+1;
assignin('base','Z',Z);




function Status_Callback(hObject, eventdata, handles)
% hObject    handle to Status (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Status as text
%        str2double(get(hObject,'String')) returns contents of Status as a double


% --- Executes during object creation, after setting all properties.
function Status_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Status (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ConditionDisp_Callback(hObject, eventdata, handles)
% hObject    handle to ConditionDisp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ConditionDisp as text
%        str2double(get(hObject,'String')) returns contents of ConditionDisp as a double


% --- Executes during object creation, after setting all properties.
function ConditionDisp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ConditionDisp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in EndBt.
function EndBt_Callback(hObject, eventdata, handles)
% hObject    handle to EndBt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
evalin('base','clf');



function MainDisp_Callback(hObject, eventdata, handles)
% hObject    handle to MainDisp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MainDisp as text
%        str2double(get(hObject,'String')) returns contents of MainDisp as a double


% --- Executes during object creation, after setting all properties.
function MainDisp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MainDisp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function V_disp_Callback(hObject, eventdata, handles)
% hObject    handle to V_disp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of V_disp as text
%        str2double(get(hObject,'String')) returns contents of V_disp as a double


% --- Executes during object creation, after setting all properties.
function V_disp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to V_disp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Input_Callback(hObject, eventdata, handles)
% hObject    handle to Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Input as text
%        str2double(get(hObject,'String')) returns contents of Input as a double


% --- Executes during object creation, after setting all properties.
function Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Cal_but.
function Cal_but_Callback(hObject, eventdata, handles)
% hObject    handle to Cal_but (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

contents=cellstr( get(handles.popupmenu1,'String') );
Type = contents(get(handles.popupmenu1,'Value'));

if strcmp(Type,'P6-47')
    T2 = get(handles.Input,'String');
    T2 = str2double(T2);
    T2 = T2/180*pi;
  
    
    v=MainP6_2_v(T2);
    set(handles.V_disp,'String',sprintf('v = %f',v));
    
elseif  strcmp(Type,'P6-48')   
    
    T2 = get(handles.Input,'String');
    T2 = str2double(T2);
    T2 = T2/180*pi;
    
    v=MainP6_1_v(T2);
    set(handles.V_disp,'String',sprintf('v = %f',v));
    
elseif  strcmp(Type,'P6-51')   
    T2 = get(handles.Input,'String');
    T2 = str2double(T2);
    T2 = T2/180*pi;
    
    v=MainP6_v(T2);
    set(handles.V_disp,'String',sprintf('v = %f',v));
    
end
