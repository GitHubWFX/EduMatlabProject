function varargout = EmbellishFrame(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @EmbellishFrame_OpeningFcn, ...
                   'gui_OutputFcn',  @EmbellishFrame_OutputFcn, ...
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


function EmbellishFrame_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

guidata(hObject, handles);




function varargout = EmbellishFrame_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;



function Menu_m_Callback(hObject, eventdata, handles)
%%
    h = gcf;
    MakeFrame
    close(h);


function Menu_iden_Callback(hObject, eventdata, handles)
%%
    h = gcf;
    IdentificationFrame
    close(h);

function Menu_emb_Callback(hObject, eventdata, handles)
%%
    h = gcf;
    EmbellishFrame
    close(h);
     
function Menu_pu_Callback(hObject, eventdata, handles)
%%
    h = gcf;
    PickUpFrame
    close(h);


function Beautify_inset_Callback(hObject, eventdata, handles)

% ��ť�������ά��ͼƬ���Ļص�����
global QR_ima
clc;
 
[filelist,path] = uigetfile({'*.PNG;*.jpg;*.tif',...
                  'Image Files (*.PNG,*.jpg,*.tif)'},'��ѡ������ͼ�� ...');
if (filelist == 0)
    return;
end

%��˹��ͨ�˲�����
QR_ima = myGussianLowPassFilter( QR_ima, 65 );
%ͨ��myOtsu�������ж�ֵ������
QR_ima = myOtsu( QR_ima );

axes(handles.Beautify_axes1); % ��ָ����ͼ������ϵ(��axesI)����ʾͼ��
QR_ima = imread([path,filelist]);
imshow(QR_ima);
title(filelist);

handles.Beautiful_black.Enable = 'on'; %��ɫ������ť����
handles.Beautiful_white.Enable = 'on'; %��ɫ������ť����

% --- Executes on button press in Beautify_back.
function Beautify_back_Callback(hObject, eventdata, handles)
% ��ť�����뱳��ͼƬ���Ļص�����
global Background_ima
clc;

[filelist,path] = uigetfile({'*.PNG;*.jpg;',...
                  'Image Files (*.PNG,*.jpg)'},'��ѡ������ͼ�� ...');
if (filelist == 0)
    return;
end
axes(handles.Beautify_axes2); % ��ָ����ͼ������ϵ(��axesI)����ʾͼ��
Background_ima = imread([path,filelist]);
imshow(Background_ima);
title(filelist);

handles.Beautiful_black.Enable = 'on'; %��ɫ������ť����
handles.Beautiful_white.Enable = 'on'; %��ɫ������ť����
[ir,ic,ih] = size(Background_ima);
set(handles.t_c,'string',['0-',num2str(ic)]);
set(handles.t_r,'string',['0-',num2str(ir)]);

function Beautiful_black_Callback(hObject, eventdata, handles)

% ��ť����ɫ�������Ļص�����
global Beautify_ima Background_ima QR_ima  r c x y flagwhite flagblack
clc;

flagblack = 1;
flagwhite = 0;
%��ȡ�ı�������
r = round(str2double(get(handles.edit_r, 'String')));
c = round(str2double(get(handles.edit_c,'String')));
x = round(str2double(get(handles.edit_x, 'String')));
y = round(str2double(get(handles.edit_y,'String')));

%���û����������ֵΪ����ͼƬ�����ֵ
[rr,cc,zz] = size(Background_ima);
set(handles.slider_x,'Min',0,'Max',cc-c);
set(handles.slider_y,'Min',r-rr,'Max',0);

Beautify_ima = Beautiful_black(Background_ima,QR_ima,r,c,x,y);
axes(handles.Beautify_axes3); % ��ָ����ͼ������ϵ(��axesI)����ʾͼ��
imshow(Beautify_ima);
title('����������ͼƬ');

handles.Beautify_Preview.Enable = 'on'; %Ԥ����ť����
handles.Beautify_save.Enable = 'on'; %���水ť����



function Beautiful_white_Callback(hObject, eventdata, handles)
% ��ť����ɫ�������Ļص�����
global Beautify_ima Background_ima QR_ima r c x y flagwhite flagblack
clc;

flagwhite = 1;
flagblack = 0;

%��ȡ�ı�������
r = round(str2double(get(handles.edit_r, 'String')));
c = round(str2double(get(handles.edit_c,'String')));
x = round(str2double(get(handles.edit_x, 'String')));
y = round(str2double(get(handles.edit_y,'String')));

%���û����������ֵΪ����ͼƬ�����ֵ
[rr,cc,zz] = size(Background_ima);
set(handles.slider_x,'Min',0,'Max',cc-c);
set(handles.slider_y,'Min',r-rr,'Max',0);


Beautify_ima = Beautiful_white(Background_ima,QR_ima,r,c,x,y);
axes(handles.Beautify_axes3); % ��ָ����ͼ������ϵ(��axesI)����ʾͼ��
imshow(Beautify_ima);
title('����������ͼƬ');

handles.Beautify_Preview.Enable = 'on'; %Ԥ����ť����
handles.Beautify_save.Enable = 'on'; %���水ť����


function Beautify_Preview_Callback(hObject, eventdata, handles)

% ��ť��Ԥ�����Ļص�����
global Beautify_ima
clc;
figure();
imshow(Beautify_ima);
title('Ԥ������������ͼƬ');


function Beautify_save_Callback(hObject, eventdata, handles)

% ��ť�����桻�Ļص�����
global Beautify_ima

[filename, filepath ] = uiputfile({'*.jpg','JEPGͼ���ļ� (*.jpg)'},...
                             '���洦����ͼ��','��ͼ��.jpg');
if (filename==0)
    return;
else
    imwrite(Beautify_ima,[filepath,filename],'jpg');
end



function slider_x_Callback(hObject, eventdata, handles)

% ��������x�᡻�Ļص�����
global flagwhite flagblack
%���ı���edit_x����ͬ��
set(handles.edit_x,'string',get(hObject,'value'));

if ( flagblack == 1) %ʹ�ú�ɫ������ť
    Beautiful_black_Callback(hObject, eventdata, handles);
end
if ( flagwhite == 1 ) %ʹ�ð�ɫ������ť
    Beautiful_white_Callback(hObject, eventdata, handles)
end


function slider_x_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function slider_y_Callback(hObject, eventdata, handles)

% ��������y�᡻�Ļص�����

global flagwhite flagblack
%���ı���edit_y����ͬ��
set(handles.edit_y,'string',-get(hObject,'value'));

if ( flagblack == 1) %ʹ�ú�ɫ������ť
    Beautiful_black_Callback(hObject, eventdata, handles);
end
if ( flagwhite == 1 ) %ʹ�ð�ɫ������ť
    Beautiful_white_Callback(hObject, eventdata, handles)
end



function slider_y_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit_c_Callback(hObject, eventdata, handles)

function edit_c_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_r_Callback(hObject, eventdata, handles)

function edit_r_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_x_Callback(hObject, eventdata, handles)

%�뻬����slider_x������ͬ��
set(handles.slider_x,'value',get(hObject,'value'));

% --- Executes during object creation, after setting all properties.
function edit_x_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_y_Callback(hObject, eventdata, handles)

%�뻬����slider_y������ͬ��
set(handles.slider_y,'value',-get(hObject,'value'));


function edit_y_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
