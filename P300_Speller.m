function varargout = P300_Speller(varargin)
% P300_SPELLER MATLAB code for P300_Speller.fig
%      P300_SPELLER, by itself, creates a new P300_SPELLER or raises the existing
%      singleton*.
%
%      H = P300_SPELLER returns the handle to a new P300_SPELLER or the handle to
%      the existing singleton*.
%
%      P300_SPELLER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in P300_SPELLER.M with the given input arguments.
%
%      P300_SPELLER('Property','Value',...) creates a new P300_SPELLER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before P300_Speller_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to P300_Speller_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help P300_Speller

% Last Modified by GUIDE v2.5 20-Jan-2019 08:33:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @P300_Speller_OpeningFcn, ...
                   'gui_OutputFcn',  @P300_Speller_OutputFcn, ...
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


% --- Executes just before P300_Speller is made visible.
function P300_Speller_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to P300_Speller (see VARARGIN)


% Choose default command line output for P300_Speller
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes P300_Speller wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = P300_Speller_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in startButton.
function startButton_Callback(hObject, eventdata, handles)
% hObject    handle to startButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Get the handles of all pushbuttons and radiobuttons
alphabet = findall(gcf,'Style','text');
greyColor = [0.5020 0.5020 0.5020];
ABCDEF = [handles.A handles.B handles.C handles.D handles.E handles.F];
GHIJKL = [handles.G handles.H handles.I handles.J handles.K handles.L];
MNOPQR = [handles.M handles.N handles.O handles.P handles.Q handles.R];
STUVWX = [handles.S handles.T handles.U handles.V handles.W handles.X];
YZ1234 = [handles.Y handles.Z handles.one handles.two handles.three handles.four];
n567890 = [handles.five handles.six handles.seven handles.eight handles.nine handles.zero];
AGMSY5 = [handles.A handles.G handles.M handles.S handles.Y handles.five];
BHNTZ6 = [handles.B handles.H handles.N handles.T handles.Z handles.six];
CIOU17 = [handles.C handles.I handles.O handles.U handles.one handles.seven];
DJPV28 = [handles.D handles.J handles.P handles.V handles.two handles.eight];
EKQW39 = [handles.E handles.K handles.Q handles.W handles.three handles.nine];
FLRX40 = [handles.F handles.L handles.R handles.X handles.four handles.zero];
%Intensify all Rows and Columns 15 times
for counter = 1 : 15
    % 6x6 is 12 which gives us 15x12 total intensifications
    for numberOfRowsColumns = 1 : 12
        switch numberOfRowsColumns
            case 1 %ABCDEF
                set(ABCDEF,'ForegroundColor','white');
                pause(100/1000);
            case 2 %GHIJKL
                set(alphabet,'ForegroundColor',greyColor);
                set(GHIJKL,'ForegroundColor','white');
                pause(100/1000);
            case 3 %MNOPQR
                set(alphabet,'ForegroundColor',greyColor);
                set(MNOPQR,'ForegroundColor','white');
                pause(100/1000);
            case 4 %STUVWX
                set(alphabet,'ForegroundColor',greyColor);
                set(STUVWX,'ForegroundColor','white');
                pause(100/1000);
            case 5 %YZ1234
                set(alphabet,'ForegroundColor',greyColor);
                set(YZ1234,'ForegroundColor','white');
                pause(100/1000);
            case 6 %n567890
                set(alphabet,'ForegroundColor',greyColor);
                set(n567890,'ForegroundColor','white');
                pause(100/1000);
            case 7 %AGMSY5
                set(alphabet,'ForegroundColor',greyColor);
                set(AGMSY5,'ForegroundColor','white');
                pause(100/1000);
            case 8 %BHNTZ6
                set(alphabet,'ForegroundColor',greyColor);
                set(BHNTZ6,'ForegroundColor','white');
                pause(100/1000);
            case 9 %CIOU17
                set(alphabet,'ForegroundColor',greyColor);
                set(CIOU17,'ForegroundColor','white');
                pause(100/1000);
            case 10 %DJPV28
                set(alphabet,'ForegroundColor',greyColor);
                set(DJPV28,'ForegroundColor','white');
                pause(100/1000);
            case 11 %EKQW39
                set(alphabet,'ForegroundColor',greyColor);
                set(EKQW39,'ForegroundColor','white');
                pause(100/1000);
            case 12 %FLRX40
                set(alphabet,'ForegroundColor',greyColor);
                set(FLRX40,'ForegroundColor','white');
                pause(100/1000);
        end
        %Wait 75ms between intensifications
        pause(75/1000);
    end
    set(alphabet,'ForegroundColor',greyColor);
end
