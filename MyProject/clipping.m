function [ img2 img3 ] = clipping( imgOri )
%���� ����ͼ��
%ѡ��4����
%��� img2�����ı��εľ��� img3 4��Χ�ɵ��ı��ζ�ֵͼ��

    %�ڴ򿪵�ͼ���а�˳��ѡ��Χ�ɶ���Σ��س������������øö����
    
    figure('name','ͼ�����','NumberTitle','off','toolbar','none','menubar','none')  % ����ʾ���������˵���
    imshow(imgOri);
    title('��ѡ���ά��ͼ����ĸ�����');

    [x,y] = ginput(4); %��imshowͼ�����ֶ�����ѡȡ�ı��εĶ���
    
    close('ͼ�����');
    
    x = ceil(x);    %����ȡ��
    y = ceil(y);
    %img2=img(round(y(1)):round(y(2)), round(x(1)):round(x(2)) );

    %������Сͼ��������򣬼��������ģ
    minx = min(x);  maxx = max(x);  miny = min(y);  maxy = max(y);
    
    img2 = imgOri(miny:maxy, minx:maxx, :);   %��ͼ���н�ȡ �����ı��ε� ��С����  ������Χ20�߽�

    x1 = x - minx + 1 ;  %imgOtsu��img2�е�����ӳ��
    y1 = y - miny + 1 ;
    img3 = roipoly(img2,x1,y1); %����ѡ���и�ǰ������,���ؽ��ǰ��ȫ��Ϊ1������ȫ��Ϊ0
 %   img4 = img2.*img3;   %��ͼ�����и�ǰ��
  %  img4 = img4 + (1-img3);
    
   % CutOut = img4;
    
    %CutOut = uint8(ceil(CutOut*255));

end

