function [ imgTrans ] = myTransformOrderPoints( rawImage ,XXs, YYs )
%
%
    
    %若输入图像为im2double图像  则变成uint8图像
    if( max(max(rawImage))>1 )
        rawImage = im2double(rawImage);
    end
    
    %计算变换矩阵
    
    I1 = 1 - rawImage;
    %因为该方法常用于白色背景的二维二值图像,而imtransform()函数会生成黑色背景
    %所以这里取反处理使背景颜色保持一致
    [XXs,YYs]=mySort(XXs, YYs);  %使坐标按照左下角  右下角  右上角 左上角的顺序排序
    
    Mat1 = myTransformationMatrix(XXs,YYs,2);%计算仿射变换 变换矩阵
    tform_translate = maketform('affine', Mat1);
    [I1 xdata ydata]= imtransform(I1, tform_translate);%垂直变换纠正
    YYs2 = Mat1(1,2).*XXs+YYs;  %垂直变换纠正之后坐标的映射
    
    Mat2 = myTransformationMatrix(XXs,YYs2,1);%计算仿射变换 变换矩阵
    tform_translate = maketform('affine', Mat2);
    [I2 xdata ydata]= imtransform(I1, tform_translate);%水平变换
    XXs2 = Mat2(2,1).*XXs+YYs;  %垂直变换纠正之后坐标的映射
    
    % XXs2 YYs2为图像纠正后的
    imgTrans = 1 - I2;
end

