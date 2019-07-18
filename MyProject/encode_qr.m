function qr = encode_qr(message, width,height)
% ���ܣ�����Ϣ��������QR��ά��ͼ�񣬿���ָ��ͼ���С
%����˵��:
%���룺
%   message���ַ�����Ϣ
%   width height��ָ�����ɵ�ͼ��ĳߴ�
%�����
%   qr���õ�QR��ά��ͼ��

    writer = com.google.zxing.MultiFormatWriter();%����MultiFormatWriter��Ķ���
    code = com.google.zxing.BarcodeFormat.QR_CODE;
    M_java = writer.encode(message, code ,width, height );%����MultiFormatWriter��ĳ�Ա����
    %encode�������ڰ��ַ�����Ϣת�����Ķ������ַ������ֱ���X�Ϳո��ʾ0��1
    %encode()����������  ��Ϣ  ����(QR��EAN_13��)  ��  ��
    
    qr = char(M_java);%��������ת��
   % clear bitmtx writer;   �ͷ��ڴ�
    qr(qr==10) = [];    %ASCII���10 ���з�
    qr = reshape(qr(1:2:end), width, height);   %�������о���
    qr(qr~='X') = 1;
    qr(qr=='X') = 0;

    qr = double(qr);
    
end