function [ Mat1 ] = myTransformationMatrix( CPx, CPy ,value )
%���� xx yy
%��� 
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
        xScal = xScal/5;    %�򵥵ļ�������
        xScal = 0.95*xScal; 
        %�����з��ֱ任�ܴ��ھ������ȵ�����,����ϣ�������ܾ���,������������,���Լ򵥼��ٱ任����
        %����任����
        %ˮƽ
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
        %��ֱ
        Mat1=[    1,  yScal, 0;
                  0,      1, 0;
                  0,      0, 1;];
    end
end

