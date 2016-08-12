function [DC, shift] = DecodeDC(p, bit_stream, prev_DC)

bc = DecodeUnary(bit_stream);
shift = bc + 1;
if 0 == bc
    DC = prev_DC;
    return
end

delta_DC = DecodeFromColumnIndex(bit_stream(1+shift:end), bc);
DC = prev_DC + delta_DC;
shift = 2*shift - 1;