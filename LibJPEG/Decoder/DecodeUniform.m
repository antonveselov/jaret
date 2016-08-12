function v = DecodeUniform(bits, code_len)

v = bi2de(bits(1:code_len), 'left-msb');