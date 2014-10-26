function varargout = Editor(varargin)
% EDITOR M-file for Editor.fig
%      EDITOR, by itself, creates a new EDITOR or raises the existing
%      singleton*.
%
%      H = EDITOR returns the handle to a new EDITOR or the handle to
%      the existing singleton*.
%
%      EDITOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EDITOR.M with the given input arguments.
%
%      EDITOR('Property','Value',...) creates a new EDITOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Editor_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Editor_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Editor

% Last Modified by GUIDE v2.5 26-Oct-2014 15:42:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Editor_OpeningFcn, ...
                   'gui_OutputFcn',  @Editor_OutputFcn, ...
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



% --- Executes just before Editor is made visible.
function Editor_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Editor (see VARARGIN)

% Choose default command line output for Editor
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Editor wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Editor_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.

% --- Executes on button press in openButton.
function openButton_Callback(hObject, eventdata, handles)
% hObject    handle to openButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[Filename,Path]=uigetfile({'*.jpg;*.tif;*.png;*.gif','All Image Files'},'Open Image');
global picDraw;

axes(picDraw);
if ~isequal(Filename,0)
global Image;
Image=imread(strcat(Path,Filename));
imshow(Image);
global Im2
Im2=Image;
end


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');
z=1-(a/101);
global Image;
global Im2;
Im2 = imadjust(Image,[0 z],[]);
imshow(Im2);
x= strcat('Contrast:',' ',int2str(a),'%');
set(handles.text1,'String',x);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');
global Image;
global Im2;
H = fspecial('disk',a/5+0.01);
Im2 = imfilter(Image,H);
imshow(Im2);

x= strcat('Blur:',' ',int2str(a),'%');
set(handles.text3,'String',x);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in checkbox1.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global BeforeSharpen;
global Im2;
a=get(hObject,'Value');
if isequal(a,1)
    BeforeSharpen=Im2;
    H = fspecial('unsharp');
    %H = padarray(2,[2 2]) - fspecial('gaussian' ,[5 5],2); % create unsharp mask
    Im2 = imfilter(Im2,H);
    imshow(Im2);
else
    Im2=BeforeSharpen;
    imshow(Im2);
end
% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes during object creation, after setting all properties.
function axes4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
axes(hObject);
global picDraw;
picDraw=hObject;
global Image
Image=imread('Nomedia.png');
imshow(Image);
% Hint: place code in OpeningFcn to populate axes4


% --- Executes on mouse press over axes background.
function axes4_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
