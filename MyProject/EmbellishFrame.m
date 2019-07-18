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

% 按钮『插入二维码图片』的回调函数
global QR_ima
clc;
 
[filelist,path] = uigetfile({'*.PNG;*.jpg;*.tif',...
                  'Image Files (*.PNG,*.jpg,*.tif)'},'请选择输入图像 ...');
if (filelist == 0)
    return;
end

%高斯低通滤波处理
QR_ima = myGussianLowPassFilter( QR_ima, 65 );
%通过myOtsu函数进行二值化处理
QR_ima = myOtsu( QR_ima );

axes(handles.Beautify_axes1); % 在指定的图像坐标系(即axesI)上显示图像
QR_ima = imread([path,filelist]);
imshow(QR_ima);
title(filelist);

handles.Beautiful_black.Enable = 'on'; %黑色美化按钮可用
handles.Beautiful_white.Enable = 'on'; %白色美化按钮可用

% --- Executes on button press in Beautify_back.
function Beautify_back_Callback(hObject, eventdata, handles)
% 按钮『插入背景图片』的回调函数
global Background_ima
clc;

[filelist,path] = uigetfile({'*.PNG;*.jpg;',...
                  'Image Files (*.PNG,*.jpg)'},'请选择输入图像 ...');
if (filelist == 0)
    return;
end
axes(handles.Beautify_axes2); % 在指定的图像坐标系(即axesI)上显示图像
Background_ima = imread([path,filelist]);
imshow(Background_ima);
title(filelist);

handles.Beautiful_black.Enable = 'on'; %黑色美化按钮可用
handles.Beautiful_white.Enable = 'on'; %白色美化按钮可用
[ir,ic,ih] = size(Background_ima);
set(handles.t_c,'string',['0-',num2str(ic)]);
set(handles.t_r,'string',['0-',num2str(ir)]);

function Beautiful_black_Callback(hObject, eventdata, handles)

% 按钮『黑色美化』的回调函数
global Beautify_ima Background_ima QR_ima  r c x y flagwhite flagblack
clc;

flagblack = 1;
flagwhite = 0;
%获取文本框数据
r = round(str2double(get(handles.edit_r, 'String')));
c = round(str2double(get(handles.edit_c,'String')));
x = round(str2double(get(handles.edit_x, 'String')));
y = round(str2double(get(handles.edit_y,'String')));

%设置滑动条的最大值为背景图片的最大值
[rr,cc,zz] = size(Background_ima);
set(handles.slider_x,'Min',0,'Max',cc-c);
set(handles.slider_y,'Min',r-rr,'Max',0);

Beautify_ima = Beautiful_black(Background_ima,QR_ima,r,c,x,y);
axes(handles.Beautify_axes3); % 在指定的图像坐标系(即axesI)上显示图像
imshow(Beautify_ima);
title('美化处理后的图片');

handles.Beautify_Preview.Enable = 'on'; %预览按钮可用
handles.Beautify_save.Enable = 'on'; %保存按钮可用



function Beautiful_white_Callback(hObject, eventdata, handles)
% 按钮『白色美化』的回调函数
global Beautify_ima Background_ima QR_ima r c x y flagwhite flagblack
clc;

flagwhite = 1;
flagblack = 0;

%获取文本框数据
r = round(str2double(get(handles.edit_r, 'String')));
c = round(str2double(get(handles.edit_c,'String')));
x = round(str2double(get(handles.edit_x, 'String')));
y = round(str2double(get(handles.edit_y,'String')));

%设置滑动条的最大值为背景图片的最大值
[rr,cc,zz] = size(Background_ima);
set(handles.slider_x,'Min',0,'Max',cc-c);
set(handles.slider_y,'Min',r-rr,'Max',0);


Beautify_ima = Beautiful_white(Background_ima,QR_ima,r,c,x,y);
axes(handles.Beautify_axes3); % 在指定的图像坐标系(即axesI)上显示图像
imshow(Beautify_ima);
title('美化处理后的图片');

handles.Beautify_Preview.Enable = 'on'; %预览按钮可用
handles.Beautify_save.Enable = 'on'; %保存按钮可用


function Beautify_Preview_Callback(hObject, eventdata, handles)

% 按钮『预览』的回调函数
global Beautify_ima
clc;
figure();
imshow(Beautify_ima);
title('预览美化处理后的图片');


function Beautify_save_Callback(hObject, eventdata, handles)

% 按钮『保存』的回调函数
global Beautify_ima

[filename, filepath ] = uiputfile({'*.jpg','JEPG图像文件 (*.jpg)'},...
                             '保存处理后的图像','新图像.jpg');
if (filename==0)
    return;
else
    imwrite(Beautify_ima,[filepath,filename],'jpg');
end



function slider_x_Callback(hObject, eventdata, handles)

% 滑动条『x轴』的回调函数
global flagwhite flagblack
%与文本框edit_x数据同步
set(handles.edit_x,'string',get(hObject,'value'));

if ( flagblack == 1) %使用黑色美化按钮
    Beautiful_black_Callback(hObject, eventdata, handles);
end
if ( flagwhite == 1 ) %使用白色美化按钮
    Beautiful_white_Callback(hObject, eventdata, handles)
end


function slider_x_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function slider_y_Callback(hObject, eventdata, handles)

% 滑动条『y轴』的回调函数

global flagwhite flagblack
%与文本框edit_y数据同步
set(handles.edit_y,'string',-get(hObject,'value'));

if ( flagblack == 1) %使用黑色美化按钮
    Beautiful_black_Callback(hObject, eventdata, handles);
end
if ( flagwhite == 1 ) %使用白色美化按钮
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

%与滑动条slider_x的数据同步
set(handles.slider_x,'value',get(hObject,'value'));

% --- Executes during object creation, after setting all properties.
function edit_x_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_y_Callback(hObject, eventdata, handles)

%与滑动条slider_y的数据同步
set(handles.slider_y,'value',-get(hObject,'value'));


function edit_y_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
