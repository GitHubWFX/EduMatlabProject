function [ xxs, yys ] = mySort(  xx, yy )
%���� 4���������
%ʹ��4���㰴�� ������ϵ�� ���½�  ���½�  ���Ͻ�  ���Ͻǵ�˳������
%������x��С����������   ������y��С�ĵ�Ϊ���½�  �ϴ�ĵ�Ϊ���Ͻ�
%�Թ����α���ı����޷���ȷ����
%��� ����������
    
    [xx,yy] = bubblesort(xx,yy);
    
    if( yy(1) <= yy(2) )
        xxs(1) = xx(1); %���½�
        yys(1) = yy(1); 
        xxs(4) = xx(2); %���Ͻ�
        yys(4) = yy(2);
    else
        xxs(1) = xx(2); %���½�
        yys(1) = yy(2); 
        xxs(4) = xx(1); %���Ͻ�
        yys(4) = yy(1);
    end
    
    if( yy(3) <= yy(4) )
        xxs(2) = xx(3); %���½�
        yys(2) = yy(3); 
        xxs(3) = xx(4); %���Ͻ�
        yys(3) = yy(4);
    else
        xxs(2) = xx(4); %���½�
        yys(2) = yy(4); 
        xxs(3) = xx(3); %���Ͻ�
        yys(3) = yy(3);
    end

% 
%     [w,pw] = max(xx);
%     [h,ph] = max(yy);
%     %  �ĸ��� (1,1)  (max,1)  (max,max)  (1,max)
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
%     % Rs(i,j) ��ʾ��i���㵽��j���ǵľ���
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
%��ǰ�������ð������
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
