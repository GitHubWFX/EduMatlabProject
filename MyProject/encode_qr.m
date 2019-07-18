function qr = encode_qr(message, width,height)
% 功能：把信息编码生成QR二维码图像，可以指定图像大小
%变量说明:
%输入：
%   message：字符串信息
%   width height：指定生成的图像的尺寸
%输出：
%   qr：得到QR二维码图像

    writer = com.google.zxing.MultiFormatWriter();%创建MultiFormatWriter类的对象
    code = com.google.zxing.BarcodeFormat.QR_CODE;
    M_java = writer.encode(message, code ,width, height );%调用MultiFormatWriter类的成员函数
    %encode方法用于把字符串信息转变成码的二进制字符串，分别用X和空格表示0和1
    %encode()参数依次是  信息  码型(QR、EAN_13等)  宽  高
    
    qr = char(M_java);%数据类型转化
   % clear bitmtx writer;   释放内存
    qr(qr==10) = [];    %ASCII码的10 换行符
    qr = reshape(qr(1:2:end), width, height);   %重新排列矩阵
    qr(qr~='X') = 1;
    qr(qr=='X') = 0;

    qr = double(qr);
    
end