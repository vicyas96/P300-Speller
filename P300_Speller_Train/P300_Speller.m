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

% Last Modified by GUIDE v2.5 24-Jan-2019 17:18:17

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
set(hObject, 'UserData', false);

%This matrix is used to retrieve row and column indexes of target
%characters
matrix = {
    'A', 'B', 'C', 'D', 'E', 'F';
    'G', 'H', 'I', 'J', 'K', 'L';
    'M', 'N', 'O', 'P', 'Q', 'R';
    'S', 'T', 'U', 'V', 'W', 'X';
    'Y', 'Z', '1', '2', '3', '4';
    '5', '6', '7', '8', '9', '0';
    };

alphabet = findall(gcf,'Style','text');
greyColor = [0.5020 0.5020 0.5020];

%%%%%%%%%%%%%%%Makes it easier to access every row and column%%%%%%%%%%%%%%
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

%%%%%%%%%%%%Directory where all the generated vectors will be exported to
%ovDirectory = 'C:\Users\Victor\AppData\Roaming\openvibe-2.2.0\scenarios\signals\NewRecordedSignals\Pic300Train\';
ovDirectory = ['C:\Users\' getenv('username') '\AppData\Roaming\openvibe-2.2.0\scenarios\signals\'];
%ovDirectory = [pwd '\'];
if (~exist([ovDirectory 'NewRecordedSignals'], 'dir'))
    mkdir([ovDirectory 'NewRecordedSignals']);
end
ovDirectory = [ovDirectory 'NewRecordedSignals\'];

if (~exist([ovDirectory 'Vectors'], 'dir'))
    mkdir([ovDirectory 'Vectors']);
end

%%%%%%%%%%%Keep track of the word/sentence that user typed in GUI
sentence = get(handles.sentence, 'String');
%%%%%Remove all spaces
sentence = sentence(~isspace(sentence));

%%%%%%%%%%%We need to know when the user clicked the Start button. Retrieve
%%%%%%%%%%%current time -> convert to seconds -> save it.
currentTimeVector = [];
currentTime = fix(clock);
currentTimeSeconds = (currentTime(4)*3600) + (currentTime(5)*60) + currentTime(6);
currentTimeVector = [currentTimeVector; currentTimeSeconds];
%save([ovDirectory 'currentTimeAndSentence'], 'currentTimeSeconds','sentence');

%%%%%%Rows and columns should be intensified randomly. So, create a vector
%%%%%%of random numbers from 1 to 12.
p = randperm(12);
rowColumnHighlightVector = p;
newLetterHighlightIndexName = 'RowColumnHighlightIndex';
assignin('base', newLetterHighlightIndexName, rowColumnHighlightVector);
save([ovDirectory 'Vectors\' newLetterHighlightIndexName '.mat'], 'rowColumnHighlightVector');

for currentCharacter = 1 : length(sentence)
    %targetVector = zeros((12*15*96), 1); %used to be (12*15*12)
    targetVector = [];
    targetVectorCounter = 0;
    %rowColumnHighlightVector = zeros((15*12), 1);
    %rowColumnHighlightCounter = 0;
    
    %%%%%%%%%%%%%%%% Helps to Stop the application if needed
    drawnow();        %give a chance for interrupts
    need_to_stop = get(handles.startButton, 'UserData');
    if ~isempty(need_to_stop) && need_to_stop
        break;
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%%%%%Highlight Target character in blue for 4 seconds, so the subject
    %%%%%%knows what character to focus on.
    targetLetter = findobj(gcf, 'tag', sentence(currentCharacter));
    [targetCharacterRowNumber,targetCharacterColumnNumber] = find(strncmpi(matrix, 	sentence(currentCharacter), 1));
    targetCharacterColumnNumber = targetCharacterColumnNumber + 6;
    set(targetLetter, 'ForegroundColor', 'blue')
    
    %%%%%%Pause the application for 4 sec, before flashings begin
    pause(4);
    
    %Intensify all Rows and Columns 15 times. 180 intensifications total
    %for 1 character
    for epochs = 1 : 15
        for numberOfRowsColumns = 1 : 12
            
            %%%%%%%%%%%%%%%%Helps to Stop the application if needed
            drawnow();        %give a chance for interrupts
            need_to_stop = get(handles.startButton, 'UserData');
            if ~isempty(need_to_stop) && need_to_stop
                break;
            end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            randomNumber = p(numberOfRowsColumns);
            %%%%We're trying to extract 500ms after each flash.
            %%%%That results in 128*0.5 = 64 samples per flash
            %%%%if target row or column is flashed, append 1 to target vector,
            %%%%otherwise -1
            for i = 1 : 64
                targetVectorCounter = targetVectorCounter + 1;
                if((randomNumber == targetCharacterRowNumber) || (randomNumber == targetCharacterColumnNumber))
                    targetVector = [targetVector; 1];
                else
                    targetVector = [targetVector; -1];
                end
            end
            %%%%Every row or column is flashed for 100ms, and the size is increased.
            %%%%Looks like a jump.
            switch randomNumber
                case 1 %ABCDEF
                    set(alphabet,'ForegroundColor',greyColor);
                    set(ABCDEF,'ForegroundColor','white');
                    set(ABCDEF,'FontSize', 100);
                    currentTime = fix(clock);
                    pause(100/1000);
                case 2 %GHIJKL
                    set(alphabet,'ForegroundColor',greyColor);
                    set(GHIJKL,'ForegroundColor','white');
                    set(GHIJKL,'FontSize', 100);
                    currentTime = fix(clock);
                    pause(100/1000);
                case 3 %MNOPQR
                    set(alphabet,'ForegroundColor',greyColor);
                    set(MNOPQR,'ForegroundColor','white');
                    set(MNOPQR,'FontSize', 100);
                    currentTime = fix(clock);
                    pause(100/1000);
                case 4 %STUVWX
                    set(alphabet,'ForegroundColor',greyColor);
                    set(STUVWX,'ForegroundColor','white');
                    set(STUVWX,'FontSize', 100);
                    currentTime = fix(clock);
                    pause(100/1000);
                case 5 %YZ1234
                    set(alphabet,'ForegroundColor',greyColor);
                    set(YZ1234,'ForegroundColor','white');
                    set(YZ1234,'FontSize', 100);
                    currentTime = fix(clock);
                    pause(100/1000);
                case 6 %n567890
                    set(alphabet,'ForegroundColor',greyColor);
                    set(n567890,'ForegroundColor','white');
                    set(n567890,'FontSize', 100);
                    currentTime = fix(clock);
                    pause(100/1000);
                case 7 %AGMSY5
                    set(alphabet,'ForegroundColor',greyColor);
                    set(AGMSY5,'ForegroundColor','white');
                    set(AGMSY5,'FontSize', 100);
                    currentTime = fix(clock);
                    pause(100/1000);
                case 8 %BHNTZ6
                    set(alphabet,'ForegroundColor',greyColor);
                    set(BHNTZ6,'ForegroundColor','white');
                    set(BHNTZ6,'FontSize', 100);
                    currentTime = fix(clock);
                    pause(100/1000);
                case 9 %CIOU17
                    set(alphabet,'ForegroundColor',greyColor);
                    set(CIOU17,'ForegroundColor','white');
                    set(CIOU17,'FontSize', 100);
                    currentTime = fix(clock);
                    pause(100/1000);
                case 10 %DJPV28
                    set(alphabet,'ForegroundColor',greyColor);
                    set(DJPV28,'ForegroundColor','white');
                    set(DJPV28,'FontSize', 100);
                    currentTime = fix(clock);
                    pause(100/1000);
                case 11 %EKQW39
                    set(alphabet,'ForegroundColor',greyColor);
                    set(EKQW39,'ForegroundColor','white');
                    set(EKQW39,'FontSize', 100);
                    currentTime = fix(clock);
                    pause(100/1000);
                case 12 %FLRX40
                    set(alphabet,'ForegroundColor',greyColor);
                    set(FLRX40,'ForegroundColor','white');
                    set(FLRX40,'FontSize', 100);
                    currentTime = fix(clock);
                    pause(100/1000);
            end
            %%%%Keep track of every flash by saving the current time in seconds.
            currentTimeSeconds = (currentTime(4)*3600) + (currentTime(5)*60) + currentTime(6);
            currentTimeVector = [currentTimeVector; currentTimeSeconds];
            
            %%%%%Wait 75ms between intensifications, reduce the size to default
            set(alphabet,'ForegroundColor',greyColor);
            set(alphabet,'FontSize', 80);
            pause(75/1000);
        end
        set(alphabet,'ForegroundColor',greyColor);
        set(alphabet,'FontSize', 80);
    end
    
    %%%%Assigning proper name to targetVectors and save it to the Vector
    %%%%location for a future use
    newLetterTargetVectorName = ['Letter' sentence(currentCharacter) '_TargetVector'];
    assignin('base', newLetterTargetVectorName, targetVector);
    save([ovDirectory 'Vectors\' newLetterTargetVectorName '.mat'], 'targetVector');
end
save([ovDirectory 'Vectors\currentTimeAndSentence'], 'currentTimeVector', 'sentence');

%%%%After the flashings is over, run the Data Preprocessing script to extract
%%%%the relevant information
DataPreprocessing;

% workspaceVars = who;
% findVars = strfind(workspaceVars, '_TargetVector');
% indexVars = find(not(cellfun('isempty', findVars)));
% save([ovDirectory 'Vectors\TargetVectors'], workspaceVars{indexVars});





function sentence_Callback(hObject, eventdata, handles)
% hObject    handle to sentence (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sentence as text
%        str2double(get(hObject,'String')) returns contents of sentence as a double


% --- Executes during object creation, after setting all properties.
function sentence_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sentence (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in stopButton.
function stopButton_Callback(hObject, eventdata, handles)
% hObject    handle to stopButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.startButton, 'UserData', true);
