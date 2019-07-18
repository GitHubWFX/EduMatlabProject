function [ imgResult1, imgResult2 ] = PickUp( imgOriginal )

    %2.��ͼ����ѡ���ȡ,ȡim2double�Ҷ�ͼ�񣬻�ȡ��ȡ��ͼ���ģ��
    [imgClipArea , imgRip] = clipping(imgOriginal); %���Ѵ򿪵�imgͼ����ѡ�����

    %3.�任�Ҷ�ͼ��
    imgGray = toGray(imgClipArea);  %����ͼ��ͳһΪ��ͨ���Ҷ�ͼ��

    %4.�Աȶ���ǿ
    %٤��任
    imgGray = im2double(imgGray);
    Gamma = 1.5; 
    imgGamma = 1*(imgGray.^Gamma); 

    %5.��ֵ����
    imgOtsu = myOtsu(imgGamma);   %����ǰ����

    %6.����ǰ��
    imgCutOut = im2double(imgOtsu).*imgRip;   %��ͼ�����и�ǰ��
    imgCutOut = imgCutOut + (1-imgRip);

    %��������
    imgUpDown = im2double(imgCutOut);   %��һ��
    MinSize = 200;
    imgUpDown = RRDoubleUpDownTo(imgUpDown,MinSize);  %���ص㱶��������ֱ�����ص���n*n~2n*2n֮��

    %7.��Ե����
    [r,c] = size(imgUpDown);
    imgEx = BorderExtend(imgUpDown,1,ceil(r/10),ceil(c/10)); %��Ե����  1����  100���

    %8.��ʴ
    %��ʴ�ĺ�, ��img(i:i+3,j:3)��ӦSλ��ȫΪ1ʱimg(i,j)����1������Ϊ0;
    Cn = ceil(min(size(imgEx))/30); %ģ�ⸯʴ�̶�,��ʴ�̶�Խ��
    imgCorrode = myCorrode(imgEx, Cn);  %��ʴ

    %9.ͼ���Ե���,ȡ�����ر߽�
    imgEdgeCanny = edge(imgCorrode, 'canny');%Canny��ͼ����б�Ե���

    %10.����ֱ��
    %��ȡֱ�߲���(�����linesΪÿ����ֱ�߾����ĵ����� �� ������ϵ����)  imgLinesTemp(),imgLines()
    [H,T,R] = hough(imgEdgeCanny);
    P  = houghpeaks(H,4,'threshold',ceil(0.2*max(H(:))));
    lines= houghlines(imgEdgeCanny,T,R,P,'FillGap',2000,'MinLength',10);
    
%     %����
%     imgLinesTemp = imgEdgeCanny;
%     [r,c] = size(imgEdgeCanny);
%     imgLines = zeros(r,c);
%     for i = 1 : length(lines)
%         x1 = lines(i).point1(1);
%         y1 = lines(i).point1(2);
%         x2 = lines(i).point2(1);
%         y2 = lines(i).point2(2);
%         imgLinesTemp = myBresenhamDraw(imgLinesTemp,x1,y1,x2,y2);
%         imgLines = myBresenhamDraw(imgLines,x1,y1,x2,y2);
%     end
% 
%     %11.���ƽ���
%     %��(����)����
      [r,c] = size(imgEdgeCanny);
      [XXs,YYs] = myFindeCrossoverPoints(lines,r,c);
%     CPx = ceil(XXs);
%     CPy = ceil(YYs);
%     imgPoints = imgLines;
%     for i = 1 : length(CPx)
%         imgPoints( CPy(i)-5:CPy(i)+5,CPx(i)-5:CPx(i)+5 ) = 1;
%     end

    %12.ͼ����� ����任 ���ݸ���4������,��ͼ������ֱ��ˮƽ����任����
    IMG = (1-im2double(imgClipArea));
    [a,b,c] = size(IMG);
    for h = 1:c
       IMG(:,:,h) = IMG(:,:,h).*imgRip; %Ԥ����  ΪʹmyTransformOrderPoints()���ɵ�ͼ�񱳾�ͳһΪ��ɫ  
    end
    IMG = 1-IMG;
    imgResult1 = myTransformOrderPoints( IMG ,XXs,YYs );
    imgResult2 = myTransformOrderPoints( imgCutOut ,XXs,YYs );


end

