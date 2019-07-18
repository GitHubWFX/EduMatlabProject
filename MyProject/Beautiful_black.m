function img3 = Beautiful_black(img2,img1,r,c,x,y)  
    %����һά��ά��ͼ��img1�Ͳ�ɫͼ��img2
    %x��yΪԭʼ�������
    %���uint8��ά��ɫͼ�񣨺���ά��)
    
    img1 = imresize(img1,[r,c]);%�ı��ά��ͼƬ�Ĵ�С 
    thresh = graythresh(img1); %�����Զ���ֵ
    img1 = im2bw(img1,thresh); %�Ҷȶ�ֵ��
    
    [yy,xx,zz] = size(img2);
    img2 = im2double(img2);
  
    img3 = img2;
    
    if( isnan(r) || isnan(c) || isnan(x) || isnan(y) )
        error  = errordlg('������int���͵�ֵ�����������ò���');
        jframe = getJFrame(error);
        jframe.setAlwaysOnTop(1);
        return;
    end
    
    if( r > yy || c > xx )
        if( c > xx )
             error  = errordlg(['��ά��ͼƬ�ĳ�',num2str(c),'��������ͼƬ�ĳ������������ò���']);
        else
             error  = errordlg(['��ά��ͼƬ�Ŀ�',num2str(r),'��������ͼƬ�Ŀ����������ò���']);
        end
        jframe = getJFrame(error);
        jframe.setAlwaysOnTop(1);
        return;
    end

    if( x > xx-c || y >yy-r)
        if( x > xx-c)
             error  = errordlg(['��ʼ������(',num2str(x),',',num2str(y),')���ó���ͼƬ�������ޣ����������ò���']);
        else
             error  = errordlg(['��ʼ������(',num2str(x),',',num2str(y),')���ó���ͼƬ�������ޣ����������ò���']);
        end
        jframe = getJFrame(error);
        jframe.setAlwaysOnTop(1);
        return;
    end
     
    for i = 1:r
        for j = 1:c
            if( img1(i,j) == 1)
                img3(y+i,x+j,:) = 1;
            else
                for h = 1 : 3
                img3(y+i,x+j,h) = img2(y+i,x+j,h).*(1-img1(i,j));
                %��img2��img1�����ʼ����ȷ����
                end
            end
        end
    end
end