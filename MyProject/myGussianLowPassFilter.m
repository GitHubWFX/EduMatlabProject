function [img2] = myGussianLowPassFilter1(img1, D0)
%����im2double
%ͨ����˹��ͨ�˲����ģ��ͼ��
%���im2double

    [r,c] = size(img1); 
    D = zeros(r,c); %D��u��v)�Ǿ�Ƶ�ʾ������ĵľ���
    for i = 1 : r
        for j = 1 : c
            D(i,j) = sqrt((i-r/2)^2+(j-c/2)^2);
        end
    end
    H = exp(-(D.^2)/(2*D0*D0));
        %�����˲������õ���˹��ͨ�˲���
    F = fft2(img1,size(H,1),size(H,2));
        %��ԭͼ����и���Ҷ�任
    F = fftshift(F);
        %�Ը���Ҷ�任���F����������λ
    F1 = ifft2(ifftshift(H.*F));
        %��������λ���Fʹ�ø�˹��ͨ�˲�������з�FFT�ƶ�
        %������з�FFT�ƶ�������������ͼƬ������䰵
    img2 = real(F1);
    img2 = uint8(img2);
end