function [ img2 ] = myDrawALine( img, k, b )
%б��Ϊ0~1��ֱ�߻���
    [r,c] = size(img);
    % y = kx + b;
    img = img';
    %�������img������
    %�� x>=1 �� kx+b>1  ��   x>=1 �� x>=(1-b)/k  ��  x>=max{1,(1-b)/k}
    if( (1-b)/k <1 )
        x0 = 1;
    else
        x0 = (1-b)/k;
    end
    y0 = k*x0+b;
    x0 = ceil(x0);
    y0 = ceil(y0);
    %�������img������
    %�� x<=c �� kx+b<=r  ��   x<=c �� x<=(r-b)/k  ��  x>=min{c,(r-b)/k}
    if( (r-b)/k < c )
        xend = (r-b)/k;
    else
        xend = c;
    end
    yend = k*xend+b;
    xend = floor(xend);
    yend = floor(yend);
    
    y = y0;
    e = 0;
    for x = x0 : xend-1
        img(x,y) = 1;
        e = e + k;
        if(e>=1)
            y = y + 1;
            if( y==yend)
                break;
            end
            img(x,y) = 1;
            e = e - 1;
        end
    end
    img = img';
    img2 = img;

end
