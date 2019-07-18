function [ img2 ] = myCorrode( img, n )
%����im2double�Ҷ�ͼ��img  ��ʴ�̶�n
%���im2double
    
    S = ones(n,n);  %������ʴģ��
    sumS = sum(sum(S));
    
    [r,c] = size(img);
    [rr,cc] = size(S);
    
    for i= 1 : r-rr+1
        
        for j=1 : c-cc+1
            
            imgt = img(i : i+rr-1, j : j+cc-1);
            
            if( sum(sum(imgt.*S))== sumS )     %��S��Ϊ1��λ��ȫΪ1��Ϊ1
                
                img(i,j)=1;    %�����ж�1
                
            else  %�ҡ�����1����
                
                img(i,j)=0; 
                
            end
            
        end
        
    end
    
    img2 = img;
    
end

