function [img2] = myGussianLowPassFilter1(img1, D0)
%输入im2double
%通过高斯低通滤波获得模糊图像
%输出im2double

    [r,c] = size(img1); 
    D = zeros(r,c); %D（u，v)是距频率矩形中心的距离
    for i = 1 : r
        for j = 1 : c
            D(i,j) = sqrt((i-r/2)^2+(j-c/2)^2);
        end
    end
    H = exp(-(D.^2)/(2*D0*D0));
        %计算滤波器，得到高斯低通滤波器
    F = fft2(img1,size(H,1),size(H,2));
        %对原图像进行傅里叶变换
    F = fftshift(F);
        %对傅里叶变换后的F进行中心移位
    F1 = ifft2(ifftshift(H.*F));
        %对中心移位后的F使用高斯低通滤波器后进行反FFT移动
        %必须进行反FFT移动，否则输入结果图片背景会变暗
    img2 = real(F1);
    img2 = uint8(img2);
end