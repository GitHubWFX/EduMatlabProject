function [ img2 ] = ResolutionRatioDoubleUp( img )
%输入 im2double 灰度图像
%输出 im2double 灰度图像
%该方法用于像素(行列分别)翻倍
    [r,c] = size(img);
    rr = r*2;
    cc = c*2;
    
    img2temp = zeros(rr,c);
    for i = 1 : rr
        ii = ceil(i/2);
        img2temp(i,:) = img(ii,:);
    end
    
    img2 = zeros(rr,cc);
    for i = 1 : cc
        ii = ceil(i/2);
        img2(:,i) = img2temp(:,ii);
    end
    
end
