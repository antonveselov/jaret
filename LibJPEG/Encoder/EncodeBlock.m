function bit_stream = EncodeBlock(p, block, prev_DC)

bit_stream_DC = EncodeDC(p, block(1,1), prev_DC);

x = block(p.zz);
x = x(2:end); % skip DC
bit_stream_AC = EncodeAC(p, x);
bit_stream = [
    bit_stream_DC;
    bit_stream_AC];
