function [ img ] = toGray( img )
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    Size = size(img);
    if numel(Size) == 3
        img = rgb2gray(img);

end

