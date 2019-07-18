function [ imgResult1, imgResult2 ] = PickUp( imgOriginal )

    %2.从图像中选点截取,取im2double灰度图像，获取截取域和剪裁模板
    [imgClipArea , imgRip] = clipping(imgOriginal); %从已打开的img图像中选点剪裁

    %3.变换灰度图像
    imgGray = toGray(imgClipArea);  %所有图像统一为单通道灰度图像

    %4.对比度增强
    %伽马变换
    imgGray = im2double(imgGray);
    Gamma = 1.5; 
    imgGamma = 1*(imgGray.^Gamma); 

    %5.阈值处理
    imgOtsu = myOtsu(imgGamma);   %划分前背景

    %6.分离前景
    imgCutOut = im2double(imgOtsu).*imgRip;   %在图像中切割前景
    imgCutOut = imgCutOut + (1-imgRip);

    %像素拉伸
    imgUpDown = im2double(imgCutOut);   %归一化
    MinSize = 200;
    imgUpDown = RRDoubleUpDownTo(imgUpDown,MinSize);  %像素点倍增或倍缩，直至像素点在n*n~2n*2n之间

    %7.边缘扩充
    [r,c] = size(imgUpDown);
    imgEx = BorderExtend(imgUpDown,1,ceil(r/10),ceil(c/10)); %边缘扩充  1扩充  100宽度

    %8.腐蚀
    %腐蚀的核, 仅img(i:i+3,j:3)对应S位置全为1时img(i,j)保留1，否则为0;
    Cn = ceil(min(size(imgEx))/30); %模拟腐蚀程度,腐蚀程度越高
    imgCorrode = myCorrode(imgEx, Cn);  %腐蚀

    %9.图像边缘检测,取单像素边界
    imgEdgeCanny = edge(imgCorrode, 'canny');%Canny对图像进行边缘检测

    %10.绘制直线
    %获取直线参数(结果集lines为每条线直线经过的点坐标 和 极坐标系参数)  imgLinesTemp(),imgLines()
    [H,T,R] = hough(imgEdgeCanny);
    P  = houghpeaks(H,4,'threshold',ceil(0.2*max(H(:))));
    lines= houghlines(imgEdgeCanny,T,R,P,'FillGap',2000,'MinLength',10);
    
%     %绘线
%     imgLinesTemp = imgEdgeCanny;
%     [r,c] = size(imgEdgeCanny);
%     imgLines = zeros(r,c);
%     for i = 1 : length(lines)
%         x1 = lines(i).point1(1);
%         y1 = lines(i).point1(2);
%         x2 = lines(i).point2(1);
%         y2 = lines(i).point2(2);
%         imgLinesTemp = myBresenhamDraw(imgLinesTemp,x1,y1,x2,y2);
%         imgLines = myBresenhamDraw(imgLines,x1,y1,x2,y2);
%     end
% 
%     %11.绘制交点
%     %角(交点)计算
      [r,c] = size(imgEdgeCanny);
      [XXs,YYs] = myFindeCrossoverPoints(lines,r,c);
%     CPx = ceil(XXs);
%     CPy = ceil(YYs);
%     imgPoints = imgLines;
%     for i = 1 : length(CPx)
%         imgPoints( CPy(i)-5:CPy(i)+5,CPx(i)-5:CPx(i)+5 ) = 1;
%     end

    %12.图像矫正 仿射变换 根据给定4点坐标,把图像做垂直和水平仿射变换纠正
    IMG = (1-im2double(imgClipArea));
    [a,b,c] = size(IMG);
    for h = 1:c
       IMG(:,:,h) = IMG(:,:,h).*imgRip; %预处理  为使myTransformOrderPoints()生成的图像背景统一为白色  
    end
    IMG = 1-IMG;
    imgResult1 = myTransformOrderPoints( IMG ,XXs,YYs );
    imgResult2 = myTransformOrderPoints( imgCutOut ,XXs,YYs );


end

