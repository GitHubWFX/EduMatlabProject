function [ img2 ] = ResolutionRatioDoubleDown( img )
%���� im2double �Ҷ�ͼ��
%��� im2double �Ҷ�ͼ��
%�÷�����������(���зֱ�)����
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

