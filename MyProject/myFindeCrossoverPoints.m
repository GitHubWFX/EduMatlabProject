function [ x,y ] = myFindeCrossoverPoints( lines, r, c )
%����:hough() houghpeaks() houghlines()�������ɵ�lines����  ��Χr c
%���:������Χ�ڵ�ֱ�߽�������

%�ⷽ�����󽻵�
%F1(x) = a1*x + b1*y + c1 = 0
%F2(x) = a2*x + b2*y + c2 = 0

    x = [];
    y = [];
    p = 1;
    k = length(lines);
    for i = 1 : k-1
        %ֱ��������
        x0 = lines(i).point1(1);
        y0 = lines(i).point1(2);
        x1 = lines(i).point2(1);
        y1 = lines(i).point2(2);
        a1 = y0 - y1;
        b1 = x1 - x0;
        c1 = x0*y1 - x1*y0;
        % ax + by + c = 0
        for j = i+1 : k
            x0 = lines(j).point1(1);
            y0 = lines(j).point1(2);
            x1 = lines(j).point2(1);
            y1 = lines(j).point2(2);
            a2 = y0 - y1;
            b2 = x1 - x0;
            c2 = x0*y1 - x1*y0;
            
            D = a1*b2 - a2*b1;
            
            xx = (b1*c2 - b2*c1)/D;
            yy = (a2*c1 - a1*c2)/D ;
            if( 1<=xx&&xx<=c && 1<=yy&&yy<=r )
                x(p) = xx;
                y(p) = yy;
                p = p + 1;
            end
        end
    end
end

