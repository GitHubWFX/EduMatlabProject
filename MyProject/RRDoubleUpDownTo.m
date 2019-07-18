function [ img2 ] = RRDoubleUpDownTo( img, num )
%输入 im2double 灰度图像
%输出 im2double 灰度图像
%函数像素点不断倍增，直至行列均不小于num
    [r,c] = size(img);
    xxx = r*c;
    
    num1 = num*num;
    num2 = num1*4;
    
    while(xxx > num2 )
        img = ResolutionRatioDoubleDown(img); %分辨率倍缩
        [r,c] = size(img);
        xxx = r*c;
    end
    
    while( xxx <= num1 )    %分辨率倍增直至超过num1*num1
        img = ResolutionRatioDoubleUp(img); %分辨率倍增
        [r,c] = size(img);
        xxx = r*c;
    end
    

    img2 = img;
end

