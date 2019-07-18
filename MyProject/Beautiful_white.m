function img3 = Beautiful_white(img2,img1,r,c,x,y)  
    %输入一维二维码图形img1和彩色图像img2
    %x和y为原始点的坐标
    %输出彩色图像（含二维码)
    
    img1 = imresize(img1,[r,c]);%改变二维码图片的大小 
    [yy,xx,zz] = size(img2);
       
    img3 = img2;   %img3是最终输出图像
    thresh = graythresh(img1); %设置自动阈值
    img1 = im2bw(img1,thresh); %灰度二值化
    img1 = double(img1);%为了能和img2相乘
    
    %判断参数类型
    if( isnan(r) || isnan(c) || isnan(x) || isnan(y) )
        error  = errordlg('请输入int类型的值，请重新设置参数');
        jframe = getJFrame(error);
        jframe.setAlwaysOnTop(1);
        return;
    end
    
    %判断二维码图片的长宽是否超过背景图片的长宽
    if( r > yy || c > xx)
        if( c > xx )
             error  = errordlg(['二维码图片的长',num2str(c),'超过背景图片的长，请重新设置参数']);
        else
             error  = errordlg(['二维码图片的宽',num2str(r),'超过背景图片的宽，请重新设置参数']);
        end
        jframe = getJFrame(error);
        jframe.setAlwaysOnTop(1);
        return;
    end

    %判断起始坐标是否会导致二维码图片超出界限
    if( x > xx-c || y >yy-r)
        if( x > xx-c)
             error  = errordlg(['起始横坐标(',num2str(x),',',num2str(y),'设置出错，图片超出界限，请重新设置参数']);
        else
             error  = errordlg(['起始纵坐标(',num2str(x),',',num2str(y),'设置出错，图片超出界限，请重新设置参数']);
        end
        jframe = getJFrame(error);
        jframe.setAlwaysOnTop(1);
        return;
    end
    
    %把二维码白色部分美化
    for i = 1:r
        for j = 1:c
            for h = 1 : 3
                img3(y+i,x+j,h) = img2(y+i,x+j,h).*img1(i,j);
                %把img2和img1相乘起始坐标确定好
            end
        end
    end
end