function [ img2 img3 ] = clipping( imgOri )
%输入 任意图像
%选择4个点
%输出 img2包含四边形的矩形 img3 4点围成的四边形二值图像

    %在打开的图像中按顺序选点围成多边形，回车键结束，剪裁该多边形
    
    figure('name','图像剪裁','NumberTitle','off','toolbar','none','menubar','none')  % 不显示工具栏，菜单栏
    imshow(imgOri);
    title('请选择二维码图像的四个顶点');

    [x,y] = ginput(4); %在imshow图像上手动依次选取四边形的顶点
    
    close('图像剪裁');
    
    x = ceil(x);    %向上取整
    y = ceil(y);
    %img2=img(round(y(1)):round(y(2)), round(x(1)):round(x(2)) );

    %以下缩小图像处理的区域，减少运算规模
    minx = min(x);  maxx = max(x);  miny = min(y);  maxy = max(y);
    
    img2 = imgOri(miny:maxy, minx:maxx, :);   %从图像中截取 包含四边形的 最小矩形  保留外围20边界

    x1 = x - minx + 1 ;  %imgOtsu在img2中的坐标映射
    y1 = y - miny + 1 ;
    img3 = roipoly(img2,x1,y1); %根据选点切割前景区域,返回结果前景全部为1，背景全部为0
 %   img4 = img2.*img3;   %在图像中切割前景
  %  img4 = img4 + (1-img3);
    
   % CutOut = img4;
    
    %CutOut = uint8(ceil(CutOut*255));

end

