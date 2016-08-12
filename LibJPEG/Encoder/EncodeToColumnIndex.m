function code = EncodeToColumnIndex(v, num_bits)

if v < 0
   v = 2^num_bits + v - 1;
end
code = de2bi(v, num_bits, 'left-msb');
code = code';
