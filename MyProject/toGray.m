function [ img ] = toGray( img )
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
    Size = size(img);
    if numel(Size) == 3
        img = rgb2gray(img);

end

