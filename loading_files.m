function varargout = loading_files(varargin)
% LOADING_FILES MATLAB code for loading_files.fig
%      LOADING_FILES, by itself, creates a new LOADING_FILES or raises the existing
%      singleton*.
%
%      H = LOADING_FILES returns the handle to a new LOADING_FILES or the handle to
%      the existing singleton*.
%
%      LOADING_FILES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LOADING_FILES.M with the given input arguments.
%
%      LOADING_FILES('Property','Value',...) creates a new LOADING_FILES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before loading_files_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to loading_files_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help loading_files

% Last Modified by GUIDE v2.5 28-Aug-2014 15:23:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @loading_files_OpeningFcn, ...
                   'gui_OutputFcn',  @loading_files_OutputFcn, ...
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


% --- Executes just before loading_files is made visible.
function loading_files_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to loading_files (see VARARGIN)

% Choose default command line output for loading_files
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes loading_files wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = loading_files_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function pushbutton1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
