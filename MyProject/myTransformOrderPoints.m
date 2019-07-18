function [ imgTrans ] = myTransformOrderPoints( rawImage ,XXs, YYs )
%
%
    
    %������ͼ��Ϊim2doubleͼ��  ����uint8ͼ��
    if( max(max(rawImage))>1 )
        rawImage = im2double(rawImage);
    end
    
    %����任����
    
    I1 = 1 - rawImage;
    %��Ϊ�÷��������ڰ�ɫ�����Ķ�ά��ֵͼ��,��imtransform()���������ɺ�ɫ����
    %��������ȡ������ʹ������ɫ����һ��
    [XXs,YYs]=mySort(XXs, YYs);  %ʹ���갴�����½�  ���½�  ���Ͻ� ���Ͻǵ�˳������
    
    Mat1 = myTransformationMatrix(XXs,YYs,2);%�������任 �任����
    tform_translate = maketform('affine', Mat1);
    [I1 xdata ydata]= imtransform(I1, tform_translate);%��ֱ�任����
    YYs2 = Mat1(1,2).*XXs+YYs;  %��ֱ�任����֮�������ӳ��
    
    Mat2 = myTransformationMatrix(XXs,YYs2,1);%�������任 �任����
    tform_translate = maketform('affine', Mat2);
    [I2 xdata ydata]= imtransform(I1, tform_translate);%ˮƽ�任
    XXs2 = Mat2(2,1).*XXs+YYs;  %��ֱ�任����֮�������ӳ��
    
    % XXs2 YYs2Ϊͼ��������
    imgTrans = 1 - I2;
end

