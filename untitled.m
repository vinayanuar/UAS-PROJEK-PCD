function varargout = untitled(varargin)
% UNTITLED MATLAB code for untitled.fig
%      UNTITLED, by itself, creates a new UNTITLED or raises the existing
%      singleton*.
%
%      H = UNTITLED returns the handle to a new UNTITLED or the handle to
%      the existing singleton*.
%
%      UNTITLED('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED.M with the given input arguments.
%
%      UNTITLED('Property','Value',...) creates a new UNTITLED or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
% Edit the above text to modify the response to help untitled
% Last Modified by GUIDE v2.5 01-May-2020 20:42:32
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled_OutputFcn, ...
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
% --- Executes just before untitled is made visible.
function untitled_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled (see VARARGIN)
% Choose default command line output for untitled
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
% UIWAIT makes untitled wait for user response (see UIRESUME)
% uiwait(handles.figure1);
% --- Outputs from this function are returned to the command line.
function varargout = untitled_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get default command line output from handles structure
varargout{1} = handles.output;
function edit1_Callback(~, ~, ~) %#ok<DEFNU>
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, ~, ~) %#ok<DEFNU>
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, ~, handles) %#ok<DEFNU>
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% menampilkan menu browse file
[file, path] = uigetfile({'*.jpg;*.png', 'menampilkan'});
% jika ada file yang dipilih maka menjalankan perintah di bawahnya
if ~isequal(file,0)
 % membaca file citra yang dipilih
 img = imread(fullfile(path, file));
 % menampilkan citra pada axes
 axes(handles.axes1)
 imshow(img)
 title('Citra RGB')
 % menyimpan variabel Img pada lokasi handle (lokasi penyimpanan MATLAB
 % agar dapat dipanggil pada pushbutton yang lain
 handles.Img = img;
 guidata(hObject, handles)
 
 % mereset button2
 set(handles.pushbutton2,'Enable','on')
 set(handles.pushbutton3,'Enable','on')
 set(handles.edit1,'String',[])
 set(handles.text2,'String',[])
 set(handles.uitable2,'Data',[])
 cla(handles.axes2, 'reset')
 set(handles.axes2,'XTick',[])
 set(handles.axes2,'YTick',[])
else
return
end
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, ~, handles) %#ok<DEFNU>
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% memanggil variabel Img yang ada pada lokasi handles
Img = handles.Img;
gray = rgb2gray(Img);
axes(handles.axes2);
imshow(gray);
handles.data2 = gray;
% mengkonversi citra grayscale pada axes
title('Citra Grayscale')
% melakukan ekstraksi ciri orde satu pada citra grayscale
H = imhist(Img)';
H = H/sum(H);
I = (0:255);
CiriMEAN = I * H';
CiriENT = -H * log2(H+eps)';
CiriVAR = (I-CiriMEAN).^2*H';
CiriSKEW = (I-CiriMEAN).^3*H'/ CiriVAR^1.5;
CiriKURT = (I-CiriMEAN).^4*H'/ CiriVAR^2-3;
data_uji = [CiriMEAN,CiriENT,CiriVAR,CiriSKEW,CiriKURT];
% menampilkan hasil ekstraksi ciri orde satu pada tabel
data_tabel = cell(5,2);
data_tabel{1,1} = 'Mean';
data_tabel{2,1} = 'Entropy';
data_tabel{3,1} = 'Variance';
data_tabel{4,1} = 'Skewness';
data_tabel{5,1} = 'Kurtosis';
data_tabel{1,2} = num2str(CiriMEAN);
data_tabel{2,2} = num2str(CiriENT);
data_tabel{3,2} = num2str(CiriVAR);
data_tabel{4,2} = num2str(CiriSKEW);
data_tabel{5,2} = num2str(CiriKURT);
set (handles.text2,'String','Hasil_Ekstraksi Citra')
set (handles.uitable2,'Data',data_tabel,'RowName',1:5)
% mereset button2
set (handles.pushbutton3,'Enable','on')
set (handles.edit1,'String',[])
% memanggil variabe data_uji yang ada lokasi handles
handles.data_uji = data_uji;
guidata(hObject, handles)
% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(~, ~, handles) %#ok<DEFNU>

set(handles.edit1,'String','Kamboja')
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% memanggil variabel data_uji yang ada pada lokasi handles
% load data_latih dan target_latih hasil pelatihan
% pengujian menggunakan algoritam multivism
% mengubah nilai keluaran menjadi kelas keluaran
% menampilkan hasl identifikasi jenis bunga pada edit text
% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(~, ~,handles) %#ok<DEFNU>
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% mereset button2
set(handles.pushbutton2,'Enable','on')
 set(handles.pushbutton3,'Enable','on')
 set(handles.edit1,'String',[])
 set(handles.text2,'String',[])
 set(handles.uitable2,'Data',[])
 set(handles.axes2)
 cla reset
 set(gca,'XTick',[])
 set(gca,'YTick',[])
function c = imhist(I)
   c = accumarray(I(:)+1, 1, [256 1]);


% --- Executes on button press in pushbutton5.
