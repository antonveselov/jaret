function code = EncodeDC(p, DC, prev_DC)

delta_DC = DC - prev_DC;

[bc, mag] = ToBitCategoryAndAmplitude(delta_DC);

% TODO: Replace EncodeUnary for bit_category with Huffman code from
% standard (page 153, Table K.3).
code = EncodeUnary(bc); 

if 0 ~= bc
    code = [code; EncodeToColumnIndex(mag, bc)];
end