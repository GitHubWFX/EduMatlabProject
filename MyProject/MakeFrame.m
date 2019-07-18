function varargout = MakeFrame(varargin)
%%
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MakeFrame_OpeningFcn, ...
                   'gui_OutputFcn',  @MakeFrame_OutputFcn, ...
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



function MakeFrame_OpeningFcn(hObject, eventdata, handles, varargin)
%%
handles.output = hObject;
guidata(hObject, handles);



function varargout = MakeFrame_OutputFcn(hObject, eventdata, handles) 
%%
varargout{1} = handles.output;


function Menu_m_Callback(hObject, eventdata, handles)
%%
    h = gcf;
    MakeFrame;
    close(h);


function Menu_iden_Callback(hObject, eventdata, handles)
%%
    h = gcf;
    IdentificationFrame;
    close(h);

% --- Executes on button press in Menu_emb.
function Menu_emb_Callback(hObject, eventdata, handles)
%%
    h = gcf;
    EmbellishFrame;
    close(h);
    
    
function Menu_pu_Callback(hObject, eventdata, handles)
%%
    h = gcf;
    PickUpFrame;
    close(h);

function StringText_Callback(hObject, eventdata, handles)
%%




function StringText_CreateFcn(hObject, eventdata, handles)
%%
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function M_Confirm_Callback(hObject, eventdata, handles)
%%
    javaaddpath('zxing-core3.3.3-utf8-j2se1.7.jar');
    %����ͼ��ʶ������Ҫ�İ�
    global str QRimg;
    str = get(handles.StringText,'String');
    QRimg = encode_qr(str, 512,512);
    axes(handles.QRcodeAxes); % ��ָ����ͼ������ϵ����ʾͼ��
    imshow(QRimg);
    set(handles.See,'enable','on');
    set(handles.Save,'enable','on');

function Save_Callback(hObject, eventdata, handles)
%%
    global QRimg;
    [filename, filepath ] = uiputfile({'*.jpg','JEPGͼ���ļ� (*.jpg)'},...
                                 '�����ά��','QRcode_IMG.jpg');
    if (filename==0)
        return;
    else
        imwrite(QRimg,[filepath,filename],'jpg');
    end



function See_Callback(hObject, eventdata, handles)
%%
    global QRimg;
    figure('name','������ͼ��','NumberTitle','off','toolbar','none','menubar','none');  % ����ʾ���������˵���
    imshow(QRimg);
    title('��ά��Ԥ��');
