function varargout = PickUpFrame(varargin)
%%
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PickUpFrame_OpeningFcn, ...
                   'gui_OutputFcn',  @PickUpFrame_OutputFcn, ...
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




function PickUpFrame_OpeningFcn(hObject, eventdata, handles, varargin)
%%
handles.output = hObject;
guidata(hObject, handles);


function varargout = PickUpFrame_OutputFcn(hObject, eventdata, handles) 
%%
varargout{1} = handles.output;



function Menu_m_Callback(hObject, eventdata, handles)
%%
    h = gcf;
    MakeFrame
    close(h);

function Menu_ide_Callback(hObject, eventdata, handles)
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
%ѡ��ͼ��
    global IMG_Origin

    [filelist,path] = uigetfile({'*.PNG;*.jpg;*.tif',...
                      'Image Files (*.PNG,*.jpg,*.tif)'},'��ѡ������ͼ�� ...');
    if (filelist == 0)
        return;
    end
    axes(handles.Ori_Axes); 
    file = [path,filelist];
    IMG_Origin = imread(file);
    imshow(IMG_Origin);
    title(filelist);
 
    set(handles.filetxt2,'string',file);
    set(handles.doing1,'string','');
    set(handles.doing2,'string','');
    set(handles.pickup,'enable','on');


function pickup_Callback(hObject, eventdata, handles)
%%
%ѡ��
    global IMG_Origin ImgPick1 ImgPick2
    
    set(handles.doing1,'string','������');
    set(handles.doing2,'string','������');
    
    [ImgPick1,ImgPick2] = PickUp(IMG_Origin);
    
    axes(handles.Result1_Axes);
    imshow(ImgPick1);
    title('�任ͼ��');
    set(handles.doing1,'string','�������');
    set(handles.See1,'enable','on');
    set(handles.Save1,'enable','on');

    axes(handles.Result2_Axes);
    imshow(ImgPick2);
    title('��ֵͼ��');
    set(handles.doing2,'string','�������');
    set(handles.See2,'enable','on');
    set(handles.Save2,'enable','on');
    

function Save1_Callback(hObject, eventdata, handles)
%%
%����ͼ��
    global ImgPick1;
    [filename, filepath ] = uiputfile({'*.jpg','JEPGͼ���ļ� (*.jpg)'},...
                                 '�����ά��','ImgPick.jpg');
    if (filename==0)
        return;
    else
        imwrite(ImgPick1,[filepath,filename],'jpg');
    end



function Save2_Callback(hObject, eventdata, handles)
%%
    global ImgPick2;
    [filename, filepath ] = uiputfile({'*.jpg','JEPGͼ���ļ� (*.jpg)'},...
                                 '�����ά��','ImgPick.jpg');
    if (filename==0)
        return;
    else
        imwrite(ImgPick2,[filepath,filename],'jpg');
    end


% --- Executes on button press in See1.
function See1_Callback(hObject, eventdata, handles)
%%
    global ImgPick1;
    figure('name','������ͼ��','NumberTitle','off','toolbar','none','menubar','none')  % ����ʾ���������˵���
    imshow(ImgPick1);
    title('�任ͼ��');

% --- Executes on button press in See2.
function See2_Callback(hObject, eventdata, handles)
%%
    global ImgPick2;
    figure('name','������ͼ��','NumberTitle','off','toolbar','none','menubar','none')  % ����ʾ���������˵���
    imshow(ImgPick2);
    title('��ֵͼ��');
