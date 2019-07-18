function message = decode_qr(img)
%功能：QR二维码图像的解码
% 
%变量:
%输入：
%   img：QR二维码图像
%输出：
%   message：解码出来的信息，是字符串或者空

%数据类型转化
    javaimg = im2java2d(img);%将其转化为java类型图像格式
    source = com.google.zxing.client.j2se.BufferedImageLuminanceSource(javaimg);
    bitmap = com.google.zxing.BinaryBitmap(com.google.zxing.common.HybridBinarizer(source));
    qr_reader = com.google.zxing.qrcode.QRCodeReader;   %二维码阅读器
    
    try
        result = qr_reader.decode(bitmap);  %读取信息保存为变量
        message = char(result.getText());   %获取信息变量
    catch e
         message = ['无法识别'];
    end
end
