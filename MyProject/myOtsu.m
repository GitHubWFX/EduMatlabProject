function [ binaryImage  ] = myOtsu( rawImage )
    %输入uint8灰度图像[0~255]
    %划分前景背景
    %输出uint8灰度图像[0,255]
    
    %若输入图像为im2double图像  则变成uint8图像
    if( max(max(rawImage))<=1 )
        rawImage = uint8(rawImage*255);
    end
    
    [r,c] = size(rawImage);
    histogram = zeros(1,256);
    for i = 1 : 256
        histogram(i) = length( find( rawImage(:)==i-1 ) );
    end
    histogram = histogram/(r*c);    %直方图
    %bar(histogram); xlim([0, 255]);
    v = zeros(1,256);   %记录每个灰度对应的方差
    
    g1 = 0;
    for i = 1 : 256
            g1 = g1 + (i-1)*histogram(i);   %全景灰度总值
    end
    
    w0 = 0;
    g0 = 0;
    for i = 1 : 256 %遍历每个灰度级别
        w0 = w0 + histogram(i); %前景概率卷积
        g0 = g0 + (i-1)*histogram(i);   %计算前景灰度总值
        u0 = g0/w0; %前景平均灰度
        
        w1 = 1 - w0;    %背景概率卷积
        g1 = g1 - (i-1)*histogram(i);   %背景灰度总值
        u1 = g1/w1; %背景平均灰度
        
        v(i) = w0*w1*(u0-u1)^2; %记录灰度级别对应方差
    end
    [m,p] = max(v); %找出最大方差
    thresh = p-1;  %找出阈值
    
    binaryImage = uint8(zeros(r,c));
    binaryImage(rawImage>thresh) = 255;
end