function [ xxs, yys ] = mySort(  xx, yy )
%输入 4个点的坐标
%使用4个点按照 在坐标系中 左下角  右下角  右上角  左上角的顺序排序
%横坐标x较小的两个点中   纵坐标y较小的点为左下角  较大的点为左上角
%对过于形变的四边形无法正确处理
%输出 排序后的坐标
    
    [xx,yy] = bubblesort(xx,yy);
    
    if( yy(1) <= yy(2) )
        xxs(1) = xx(1); %左下角
        yys(1) = yy(1); 
        xxs(4) = xx(2); %左上角
        yys(4) = yy(2);
    else
        xxs(1) = xx(2); %左下角
        yys(1) = yy(2); 
        xxs(4) = xx(1); %左上角
        yys(4) = yy(1);
    end
    
    if( yy(3) <= yy(4) )
        xxs(2) = xx(3); %右下角
        yys(2) = yy(3); 
        xxs(3) = xx(4); %右上角
        yys(3) = yy(4);
    else
        xxs(2) = xx(4); %右下角
        yys(2) = yy(4); 
        xxs(3) = xx(3); %右上角
        yys(3) = yy(3);
    end

% 
%     [w,pw] = max(xx);
%     [h,ph] = max(yy);
%     %  四个点 (1,1)  (max,1)  (max,max)  (1,max)
%     px = [ 1, m, m, 1 ];
%     py = [ 1, 1, m, 10*h ];
%     
%     Rs = zeros(4,4);
%     for i = 1 : 4
%         x = xx(i);
%         y = yy(i);
%         for j = 1 : 4
%             x0 = px(j);
%             y0 = py(j);
%             R = (x-x0)^2+(y-y0)^2;
%             Rs(i,j) = R;
%         end
%     end
%     % Rs(i,j) 表示第i个点到第j个角的距离
%     
%     xxs = zeros(1,4);
%     yys = zeros(1,4);
%     
%     for i = 1 : 4
%         [d,p] = min(Rs(:,i));
%         xxs(i) = xx(p);
%         yys(i) = yy(p);
%     end
end

function [x,y] = bubblesort(x,y)
%按前者升序的冒泡排序法
r = length(x); 
    for i=1:r-1 
        for j=i+1:r 
            if x(i)>x(j) 
                temp=x(i); 
                x(i)=x(j); 
                x(j)=temp; 

                temp=y(i); 
                y(i)=y(j); 
                y(j)=temp; 
            end 
        end 
    end
end
