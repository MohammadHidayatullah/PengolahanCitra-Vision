function varargout = JamurTiram(varargin)
% JAMURTIRAM MATLAB code for JamurTiram.fig
%      JAMURTIRAM, by itself, creates a new JAMURTIRAM or raises the existing
%      singleton*.
%
%      H = JAMURTIRAM returns the handle to a new JAMURTIRAM or the handle to
%      the existing singleton*.
%
%      JAMURTIRAM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in JAMURTIRAM.M with the given input arguments.
%
%      JAMURTIRAM('Property','Value',...) creates a new JAMURTIRAM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before JamurTiram_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to JamurTiram_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help JamurTiram

% Last Modified by GUIDE v2.5 09-Dec-2021 13:38:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @JamurTiram_OpeningFcn, ...
                   'gui_OutputFcn',  @JamurTiram_OutputFcn, ...
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


% --- Executes just before JamurTiram is made visible.
function JamurTiram_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to JamurTiram (see VARARGIN)

% Choose default command line output for JamurTiram
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes JamurTiram wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = JamurTiram_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.panelhome,'visible','on');
set(handles.panel1,'visible','off');
set(handles.panelprosess,'visible','off');

% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.panelhome,'visible','off');
set(handles.panel1,'visible','on');
set(handles.panelprosess,'visible','off');
% --------------------------------------------------------------------
function Untitled_3_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function url_Callback(hObject, eventdata, handles)
% hObject    handle to url (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of url as text
%        str2double(get(hObject,'String')) returns contents of url as a double


% --- Executes during object creation, after setting all properties.
function url_CreateFcn(hObject, eventdata, handles)
% hObject    handle to url (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname] = uigetfile({'*.*'});
if ~isequal(filename,0)
    Info = imfinfo(fullfile(pathname,filename));
    Img_Gray = "";
    
    % Memastikan format citra adalah RGB atau grayscale
    if Info.BitDepth == 1
        msgbox('Citra masukan harus citra RGB atau Grayscale');
        return
    % Masukkan citra ke Img_gray jika citra sudah grayscale
    % Grayscale terdiri dari 0-255, jumlah 256
    % Total 8 bit adalah 256
    % BitDepth == 8
    elseif Info.BitDepth == 8
        Img_Gray = imread(fullfile(pathname,filename));
    
    else
        % Ubah RGB Ke grayscale dulu.
        Img_Gray = rgb2gray(imread(fullfile(pathname,filename)));
    end
    
    % Tampilkan gambar
    set(handles.url,'String',[pathname,filename]);
    axes(handles.axes3)
    cla('reset')
    imshow(Img_Gray)
    title('Citra Asli','Color','white')
    
else
     return
end
handles.Img_Gray = Img_Gray;
handles.Img_Gray2 = Img_Gray;
guidata(hObject, handles) 

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img = handles.Img_Gray;
%fill = imfill(Img_Gray,'holes');
%se = strel('disk', 7);
%open = imopen(fill,se);
%Value for Thresholding
T_Low = 0.075;
T_High = 0.175;

%Gaussian Filter Coefficient
B = [2, 4, 5, 4, 2; 4, 9, 12, 9, 4;5, 12, 15, 12, 5;4, 9, 12, 9, 4;2, 4, 5, 4, 2 ];
B = 1/159.* B;

%Convolution of image by Gaussian Coefficient
A=conv2(img, B, 'same');

%Filter for horizontal and vertical direction
KGx = [-1, 0, 1; -2, 0, 2; -1, 0, 1];
KGy = [1, 2, 1; 0, 0, 0; -1, -2, -1];

%Convolution by image by horizontal and vertical filter
Filtered_X = conv2(A, KGx, 'same');
Filtered_Y = conv2(A, KGy, 'same');

%Calculate directions/orientations
arah = atan2 (Filtered_Y, Filtered_X);
arah = arah*180/pi;

pan=size(A,1);
leb=size(A,2);

%Adjustment for negative directions, making all directions positive
for i=1:pan
    for j=1:leb
        if (arah(i,j)<0) 
            arah(i,j)=360+arah(i,j);
        end;
    end;
end;

arah2=zeros(pan, leb);

%Adjusting directions to nearest 0, 45, 90, or 135 degree
for i = 1  : pan
    for j = 1 : leb
        if ((arah(i, j) >= 0 ) && (arah(i, j) < 22.5) || (arah(i, j) >= 157.5) && (arah(i, j) < 202.5) || (arah(i, j) >= 337.5) && (arah(i, j) <= 360))
            arah2(i, j) = 0;
        elseif ((arah(i, j) >= 22.5) && (arah(i, j) < 67.5) || (arah(i, j) >= 202.5) && (arah(i, j) < 247.5))
            arah2(i, j) = 45;
        elseif ((arah(i, j) >= 67.5 && arah(i, j) < 112.5) || (arah(i, j) >= 247.5 && arah(i, j) < 292.5))
            arah2(i, j) = 90;
        elseif ((arah(i, j) >= 112.5 && arah(i, j) < 157.5) || (arah(i, j) >= 292.5 && arah(i, j) < 337.5))
            arah2(i, j) = 135;
        end;
    end;
end;

%figure, imagesc(arah2); colorbar;

%Calculate magnitude
magnitude = (Filtered_X.^2) + (Filtered_Y.^2);
magnitude2 = sqrt(magnitude);

BW = zeros (pan, leb);

%Non-Maximum Supression
for i=2:pan-1
    for j=2:leb-1
        if (arah2(i,j)==0)
            BW(i,j) = (magnitude2(i,j) == max([magnitude2(i,j), magnitude2(i,j+1), magnitude2(i,j-1)]));
        elseif (arah2(i,j)==45)
            BW(i,j) = (magnitude2(i,j) == max([magnitude2(i,j), magnitude2(i+1,j-1), magnitude2(i-1,j+1)]));
        elseif (arah2(i,j)==90)
            BW(i,j) = (magnitude2(i,j) == max([magnitude2(i,j), magnitude2(i+1,j), magnitude2(i-1,j)]));
        elseif (arah2(i,j)==135)
            BW(i,j) = (magnitude2(i,j) == max([magnitude2(i,j), magnitude2(i+1,j+1), magnitude2(i-1,j-1)]));
        end
    end
end

BW = BW.*magnitude2;
%figure, imshow(BW);

%Hysteresis Thresholding
T_Low = T_Low * max(max(BW));
T_High = T_High * max(max(BW));

T_res = zeros (pan, leb);

for i = 1  : pan
    for j = 1 : leb
        if (BW(i, j) < T_Low)
            T_res(i, j) = 0;
        elseif (BW(i, j) > T_High)
            T_res(i, j) = 1;
        %Using 8-connected components
        elseif ( BW(i+1,j)>T_High || BW(i-1,j)>T_High || BW(i,j+1)>T_High || BW(i,j-1)>T_High || BW(i-1, j-1)>T_High || BW(i-1, j+1)>T_High || BW(i+1, j+1)>T_High || BW(i+1, j-1)>T_High)
            T_res(i,j) = 1;
        end
    end
end

edge_final = uint8(T_res.*255);
% Tampilkan gambar
axes(handles.axes4)
cla('reset')
imshow(edge_final)
title('Citra Hasil Deteksi Tepi','Color','white')
handles.Img = edge_final;
guidata(hObject, handles)


%m = zeros(size(img_edge_detec,1),size(img_edge_detec,2));
%m(111:231,123:243) = 1;
%seg = activecontour(img_edge_detec,m,350);
%axes(handles.axes6)
%imshow(seg)
%title('Citra Hasil Contour','Color','white')
%hold on
%contour(seg, 'y','LineWidth',2);
%d = imdistline;
%hold off


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    delete(handles.VidObj)
catch
end

axes(handles.axes3)
cla('reset')
set(gca,'XTick',[])
set(gca,'YTick',[])

axes(handles.axes4)
cla('reset')
set(gca,'XTick',[])
set(gca,'YTick',[])

axes(handles.axes5)
cla('reset')
set(gca,'XTick',[])
set(gca,'YTick',[])

axes(handles.axes6)
cla('reset')
set(gca,'XTick',[])
set(gca,'YTick',[])

set(handles.edit3,'String',[]);
set(handles.edit4,'String',[]');
set(handles.url,'String',"")
set(handles.edit2,'String',"")

% --------------------------------------------------------------------
function Untitled_4_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.panelhome,'visible','off');
set(handles.panel1,'visible','off');
set(handles.panelprosess,'visible','on');


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
IAHI = webcamlist;
IA = (IAHI);
D = menu ('Select Video Input Device:',IA);
if isempty(IA)||D==0
    clear('VidObj');
    msgbox({'You dont have any video input installed adaptor!',...
        'Please try again select Adaptors property.'})
    return
end

VidObj = webcam(D);
handles.VidObj = VidObj;
axes(handles.axes3)
hImage=image(zeros(640,480,1));
preview(handles.VidObj, hImage)
guidata(hObject,handles);


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    VidObj = handles.VidObj;
    i = snapshot(VidObj);
%     n = str2double(get(handles.edit2,'String'))+1;
%     set(handles.edit2,'String',num2str(n));
    startingFolder = userpath; % Or "pwd" or wherever you want.
    defaultFileName = fullfile(startingFolder, '*.jpg');
    [baseFileName, folder] = uiputfile(defaultFileName, 'Specify a file');
    if baseFileName == 0
	% User clicked the Cancel button.
    return;
    end
    fullFileName = fullfile(folder, baseFileName);
    imwrite(i, fullFileName);
%     imwrite(i, strcat(['Jamur',num2str(n),'.jpg']))
    Img_Gray = rgb2gray(i);
    axes(handles.axes5)
    imshow(Img_Gray);
    title('Hasil Capture','Color','white')
    
    
handles.Img_Gray = Img_Gray;
handles.Img2 = Img_Gray;
guidata(hObject,handles); 
catch
end
    



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Img = handles.Img;
axes(handles.axes4)
cla reset
imshow(Img)
title('Citra Asli')
h = imellipse;
setColor(h,'b')
mask = createMask(h);
bw = activecontour(Img,mask,1000);
bw = imfill(bw,'holes');
bw = bwareaopen(bw,500);
bw = imclearborder(bw);
axes(handles.axes6)
cla reset
imshow(Img)
title('Hasil Segmentasi')
axis off
hold on
[c,~] = bwboundaries(bw,'noholes');

for k = 1:length(c) 
    boundary = c{k};
    plot(boundary(:,2), boundary(:,1),'y','LineWidth',3)
end
hold off
%set(handles.edit3,'String',[]);
%set(handles.edit4,'String',[]');
handles.bw = bw;
guidata(hObject, handles)

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
bw = handles.bw;
 
s  = regionprops(bw, 'area', 'EquivDiameter');
area_bw = s.Area;
%perim_bw = s.Perimeter;
diameter_bw = sqrt(4 * area_bw / pi);
diameter_bww = s.EquivDiameter;
 
res = 1.362; % resolusi spasial 1.362 pixel/mm
area = area_bw/(res^2)/100;
%perimeter = perim_bw/res/10;
diameterr = diameter_bw/res/10;
diameterrr = diameter_bww/res/10;
 
set(handles.edit3,'String',[num2str(area),' cm2']);
%set(handles.edit4,'String',[num2str(perimeter),' cm']);
set(handles.edit4,'String',[num2str(diameterr),' cm']);
set(handles.edit2,'String',[num2str(diameterrr),' cm']);

if diameterr < 5
    set(handles.edit6,'String',' Grade C');
elseif diameterr >= 5 && diameterr <= 10
    set(handles.edit6,'String',' Grade B');
else
    set(handles.edit6,'String',' Grade A');
end


function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
