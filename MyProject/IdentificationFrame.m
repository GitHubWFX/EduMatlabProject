function varargout = IdentificationFrame(varargin)
%%
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @IdentificationFrame_OpeningFcn, ...
                   'gui_OutputFcn',  @IdentificationFrame_OutputFcn, ...
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



function IdentificationFrame_OpeningFcn(hObject, eventdata, handles, varargin)
%%
handles.output = hObject;
guidata(hObject, handles);



function varargout = IdentificationFrame_OutputFcn(hObject, eventdata, handles) 
%%
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

function leading_Callback(hObject, eventdata, handles)
%%
    javaaddpath('zxing-core3.3.3-utf8-j2se1.7.jar'); %加载图像识别所需要的包
    global QR_IMG message;

    [filelist,path] = uigetfile({'*.PNG;*.jpg;*.tif',...
                      'Image Files (*.PNG,*.jpg,*.tif)'},'请选择输入图像 ...');
    if (filelist == 0)
        return;
    end

    file = [path,filelist];
    
    axes(handles.IMG_Axes);
    QR_IMG = imread(file);
    imshow(QR_IMG);
    title(filelist);
    set(handles.filetxt,'string',file);
    
    
    message = decode_qr(QR_IMG);
    set(handles.Ide_message,'string',message);
    
    
function Ide_message_Callback(hObject, eventdata, handles)
%%
    global message;
    set(handles.Ide_message,'string',message);

function Ide_message_CreateFcn(hObject, eventdata, handles)
%%
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
