function [ img2 ] = ResolutionRatioDoubleDown( img )
%输入 im2double 灰度图像
%输出 im2double 灰度图像
%该方法用于像素(行列分别)翻倍
    [r,c] = size(img);
    rr = ceil(r/2);
    cc = ceil(c/2);
    
    img2temp = zeros(rr,c);
    for i = 1 : r
        ii = ceil(i/2);
        img2temp(ii,:) = img(i,:);
    end
    
    img2 = zeros(rr,cc);
    for i = 1 : c
        ii = ceil(i/2);
        img2(:,ii) = img2temp(:,i);
    end
    
end

