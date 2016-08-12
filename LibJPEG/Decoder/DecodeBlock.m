function [block, shift] = DecodeBlock(p, bit_stream, prev_DC)

[DC, shiftDC] = DecodeDC(p, bit_stream(1:end), prev_DC);
[AC, shiftAC] = DecodeAC(p, bit_stream(1+shiftDC:end));

block = zeros(p.bs);

try
    block(p.zz) = [DC, AC];
    shift = shiftDC + shiftAC;
catch
    aaa = 1;
end
