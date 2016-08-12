function image = DecodeJPEG(p, bit_stream)

image = cell(p.depth, 1);

for comp_no = 1 : p.depth
    image{comp_no} = uint8(DecodeComponent(p, bit_stream{comp_no}));
end