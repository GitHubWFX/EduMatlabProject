function [ Mat1 ] = myTransformationMatrix( CPx, CPy ,value )
%输入 xx yy
%输出 
    Mat1 = [1,0,0;0,1,0;0,0,1];
    
    if( value == 1 )
        xDif1 = CPx(1)-CPx(4);
        xDif2 = CPx(2)-CPx(3);
        width1 = CPx(2)-CPx(1);
        width2 = CPx(3)-CPx(4);
        
        xScal = 0;
        xScal = xScal + (xDif1+xDif2)/(width1+width2);
        xScal = xScal + (xDif1)/(width1);
        xScal = xScal + (xDif2)/(width2);
        xScal = xScal + (xDif1)/(width2);
        xScal = xScal + (xDif2)/(width1);
        xScal = xScal/5;    %简单的减少误差方案
        xScal = 0.95*xScal; 
        %测试中发现变换总存在纠正过度的现象,我们希望尽可能纠正,而不纠正过度,所以简单减少变换幅度
        %仿射变换矩阵
        %水平
        Mat1=[    1,  0, 0;
              xScal,  1, 0;
                  0,  0, 1;];
    end
    
    if( value == 2 )
        yDif1 = CPy(1)-CPy(2);
        yDif2 = CPy(4)-CPy(3);
        height1 = CPy(4)-CPy(1);
        height2 = CPy(3)-CPy(2);
        
        yScal = 0;
        yScal = yScal + (yDif1+yDif2)/(height1+height2);
        yScal = yScal + (yDif1)/(height1);
        yScal = yScal + (yDif2)/(height2);
        yScal = yScal + (yDif2)/(height1);
        yScal = yScal + (yDif1)/(height2);
        yScal = yScal/5;
        yScal = 0.75*yScal;
        %垂直
        Mat1=[    1,  yScal, 0;
                  0,      1, 0;
                  0,      0, 1;];
    end
end

