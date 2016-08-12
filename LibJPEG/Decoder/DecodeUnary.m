function v = DecodeUnary(bit_stream)

pos_of_zero = find(bit_stream == 0, 1);
v = pos_of_zero - 1;