function [ img2 ] = myBresenhamDraw( img,x0,y0,x1,y1 )
%基于Bresenham(布莱森汉姆)算法的划线算法
%给定img和两点坐标,在img上绘制过该两点的直线


%  y  = k *  x   + b;
% y+k = k *(x+1) + b = k*x+b + k
% x→x+1   y→y+k
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
        % y-y0 = (x-x0)*k  →  y = kx -kx0 + y0 → b = -kx0+y0;
        
        flag1 = 0;  %斜率是否为负数(需要沿x轴镜像)
        flag2 = 0;  %斜率是否＞1(需要沿y=x轴镜像)
        if( k < 0  )
            img = flip(img,1);  %沿x轴镜像
            k = -k;
            b = r-b;
            flag1 = 1;
        end
        if( k>1 )
            %坐标系镜像
            img = flip(img,2);  %沿y轴镜像
            img = img'; %矩阵转置
            img = flip(img,1);  %沿x轴镜像
            %实现沿y=x线镜像
            
            %函数镜像
            k = 1/k;
            b = -b*k;
            %标记
            flag2 = 1;
        end
            
        img = myDrawALine(img,k,b); %  k<=1
                
        if( flag2 == 1 )            
            %坐标系镜像 还原
            img = flip(img,1);  %沿x轴镜像
            img = img'; %矩阵转置
            img = flip(img,2);  %沿x轴镜像
        end
        if( flag1 == 1 )
            img = flip(img,1);  %沿x轴镜像
        end
    end
    img2 = img;
end
function [y x] = swap(x, y)

end
