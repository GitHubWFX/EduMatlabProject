function message = decode_qr(img)
%���ܣ�QR��ά��ͼ��Ľ���
% 
%����:
%���룺
%   img��QR��ά��ͼ��
%�����
%   message�������������Ϣ�����ַ������߿�

%��������ת��
    javaimg = im2java2d(img);%����ת��Ϊjava����ͼ���ʽ
    source = com.google.zxing.client.j2se.BufferedImageLuminanceSource(javaimg);
    bitmap = com.google.zxing.BinaryBitmap(com.google.zxing.common.HybridBinarizer(source));
    qr_reader = com.google.zxing.qrcode.QRCodeReader;   %��ά���Ķ���
    
    try
        result = qr_reader.decode(bitmap);  %��ȡ��Ϣ����Ϊ����
        message = char(result.getText());   %��ȡ��Ϣ����
    catch e
         message = ['�޷�ʶ��'];
    end
end
