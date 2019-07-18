function [ binaryImage  ] = myOtsu( rawImage )
    %����uint8�Ҷ�ͼ��[0~255]
    %����ǰ������
    %���uint8�Ҷ�ͼ��[0,255]
    
    %������ͼ��Ϊim2doubleͼ��  ����uint8ͼ��
    if( max(max(rawImage))<=1 )
        rawImage = uint8(rawImage*255);
    end
    
    [r,c] = size(rawImage);
    histogram = zeros(1,256);
    for i = 1 : 256
        histogram(i) = length( find( rawImage(:)==i-1 ) );
    end
    histogram = histogram/(r*c);    %ֱ��ͼ
    %bar(histogram); xlim([0, 255]);
    v = zeros(1,256);   %��¼ÿ���Ҷȶ�Ӧ�ķ���
    
    g1 = 0;
    for i = 1 : 256
            g1 = g1 + (i-1)*histogram(i);   %ȫ���Ҷ���ֵ
    end
    
    w0 = 0;
    g0 = 0;
    for i = 1 : 256 %����ÿ���Ҷȼ���
        w0 = w0 + histogram(i); %ǰ�����ʾ��
        g0 = g0 + (i-1)*histogram(i);   %����ǰ���Ҷ���ֵ
        u0 = g0/w0; %ǰ��ƽ���Ҷ�
        
        w1 = 1 - w0;    %�������ʾ��
        g1 = g1 - (i-1)*histogram(i);   %�����Ҷ���ֵ
        u1 = g1/w1; %����ƽ���Ҷ�
        
        v(i) = w0*w1*(u0-u1)^2; %��¼�Ҷȼ����Ӧ����
    end
    [m,p] = max(v); %�ҳ���󷽲�
    thresh = p-1;  %�ҳ���ֵ
    
    binaryImage = uint8(zeros(r,c));
    binaryImage(rawImage>thresh) = 255;
end