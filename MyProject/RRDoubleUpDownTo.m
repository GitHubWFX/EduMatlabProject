function [ img2 ] = RRDoubleUpDownTo( img, num )
%���� im2double �Ҷ�ͼ��
%��� im2double �Ҷ�ͼ��
%�������ص㲻�ϱ�����ֱ�����о���С��num
    [r,c] = size(img);
    xxx = r*c;
    
    num1 = num*num;
    num2 = num1*4;
    
    while(xxx > num2 )
        img = ResolutionRatioDoubleDown(img); %�ֱ��ʱ���
        [r,c] = size(img);
        xxx = r*c;
    end
    
    while( xxx <= num1 )    %�ֱ��ʱ���ֱ������num1*num1
        img = ResolutionRatioDoubleUp(img); %�ֱ��ʱ���
        [r,c] = size(img);
        xxx = r*c;
    end
    

    img2 = img;
end

