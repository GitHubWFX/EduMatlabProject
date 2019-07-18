function [ img2 ] = myCorrode( img, n )
%输入im2double灰度图像img  腐蚀程度n
%输出im2double
    
    S = ones(n,n);  %构建腐蚀模板
    sumS = sum(sum(S));
    
    [r,c] = size(img);
    [rr,cc] = size(S);
    
    for i= 1 : r-rr+1
        
        for j=1 : c-cc+1
            
            imgt = img(i : i+rr-1, j : j+cc-1);
            
            if( sum(sum(imgt.*S))== sumS )     %若S中为1的位置全为1则为1
                
                img(i,j)=1;    %正向判断1
                
            else  %右、下无1相连
                
                img(i,j)=0; 
                
            end
            
        end
        
    end
    
    img2 = img;
    
end

