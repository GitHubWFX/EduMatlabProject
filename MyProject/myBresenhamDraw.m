function [ img2 ] = myBresenhamDraw( img,x0,y0,x1,y1 )
%����Bresenham(����ɭ��ķ)�㷨�Ļ����㷨
%����img����������,��img�ϻ��ƹ��������ֱ��


%  y  = k *  x   + b;
% y+k = k *(x+1) + b = k*x+b + k
% x��x+1   y��y+k
    if(x1==x0 && y1~=y0 )
        img(:,x0:x1) = 1;
    end
    if(y1==y0 && x1~=x0 )
        img(y0:y1,:) = 1;
    end
    if( x1~=x0 && y1~=y0)
        [r,c] = size(img);
        k = (y1-y0)/(x1-x0);
        b = y0-k*x0;
        % y-y0 = (x-x0)*k  ��  y = kx -kx0 + y0 �� b = -kx0+y0;
        
        flag1 = 0;  %б���Ƿ�Ϊ����(��Ҫ��x�᾵��)
        flag2 = 0;  %б���Ƿ�1(��Ҫ��y=x�᾵��)
        if( k < 0  )
            img = flip(img,1);  %��x�᾵��
            k = -k;
            b = r-b;
            flag1 = 1;
        end
        if( k>1 )
            %����ϵ����
            img = flip(img,2);  %��y�᾵��
            img = img'; %����ת��
            img = flip(img,1);  %��x�᾵��
            %ʵ����y=x�߾���
            
            %��������
            k = 1/k;
            b = -b*k;
            %���
            flag2 = 1;
        end
            
        img = myDrawALine(img,k,b); %  k<=1
                
        if( flag2 == 1 )            
            %����ϵ���� ��ԭ
            img = flip(img,1);  %��x�᾵��
            img = img'; %����ת��
            img = flip(img,2);  %��x�᾵��
        end
        if( flag1 == 1 )
            img = flip(img,1);  %��x�᾵��
        end
    end
    img2 = img;
end
function [y x] = swap(x, y)

end
