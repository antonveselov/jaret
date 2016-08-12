function v = DecodeFromColumnIndex(bits, num_bits)

v = bi2de(bits(1:num_bits)', 'left-msb');

if v < 2^num_bits/2
    % It was negative
    v = v + 1 - 2^num_bits;
end