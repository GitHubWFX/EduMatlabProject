function [ img2 ] = BorderExtend( img, n, extR, extC )
%����im2double��ֵͼ��  ���ֵ(0|1) �����
%���im2double
    [r,c] = size(img);
    if( n == 0 )
        img2 = zeros(r+extR*2,c+extC*2);
    elseif ( n==1 )
        img2 =  ones(r+extR*2,c+extC*2);
    end
    img2(extR+1:extR+r,extC+1:extC+c) = img(:,:);
    

end

