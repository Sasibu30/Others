function varargout = Guide_Crank_slider(varargin)
% GUIDE_CRANK_SLIDER MATLAB code for Guide_Crank_slider.fig
%      GUIDE_CRANK_SLIDER, by itself, creates a new GUIDE_CRANK_SLIDER or raises the existing
%      singleton*.
%
%      H = GUIDE_CRANK_SLIDER returns the handle to a new GUIDE_CRANK_SLIDER or the handle to
%      the existing singleton*.

%
%      GUIDE_CRANK_SLIDER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIDE_CRANK_SLIDER.M with the given input arguments.
%
%      GUIDE_CRANK_SLIDER('Property','Value',...) creates a new GUIDE_CRANK_SLIDER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Guide_Crank_slider_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Guide_Crank_slider_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Guide_Crank_slider

% Last Modified by GUIDE v2.5 01-Nov-2017 19:25:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Guide_Crank_slider_OpeningFcn, ...
                   'gui_OutputFcn',  @Guide_Crank_slider_OutputFcn, ...
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


% --- Executes just before Guide_Crank_slider is made visible.
function Guide_Crank_slider_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Guide_Crank_slider (see VARARGIN)

% Choose default command line output for Guide_Crank_slider
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Guide_Crank_slider wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%Initialize
evalin('base','clear all');
evalin('base','clc');

hand = 0;
Display = 'Display';

assignin('base','hand',hand);
assignin('base','Display',Display);


% --- Outputs from this function are returned to the command line.
function varargout = Guide_Crank_slider_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function variation_Callback(hObject, eventdata, handles)
% hObject    handle to variation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of variation as text
%        str2double(get(hObject,'String')) returns contents of variation as a double


% --- Executes during object creation, after setting all properties.
function variation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to variation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in oepn_button.
function oepn_button_Callback(hObject, eventdata, handles)
% hObject    handle to oepn_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hand=1;
assignin('base','hand',hand);

guidata(hObject,handles);


% --- Executes on button press in crossed_button.
function crossed_button_Callback(hObject, eventdata, handles)
% hObject    handle to crossed_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

hand=2;
assignin('base','hand',hand);

guidata(hObject,handles);


% --- Executes on button press in Stop_button.
function Stop_button_Callback(hObject, eventdata, handles)
% hObject    handle to Stop_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
evalin('base','pause');



% --- Executes on button press in Strart_button.
function Strart_button_Callback(hObject, eventdata, handles)
% hObject    handle to Strart_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

contents=cellstr( get(handles.popupmenu,'String') );
Type = contents(get(handles.popupmenu,'Value'));

hand=evalin('base','hand');


set(handles.variation,'String',Type);

if strcmp(Type,'로커')
    if hand == 1 || hand ==2
        Mechanism_4Link(hand);
    end
elseif strcmp(Type,'슬라이더')
    if hand == 1 || hand ==2
        Crank_Slider(hand);
    end
else
    dsip('Crossed or Open 선택해주세요');
end




% --- Executes on selection change in popupmenu.
function popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu


% --- Executes during object creation, after setting all properties.
function popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
