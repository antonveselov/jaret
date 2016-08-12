function [AC, bs_ptr] = DecodeAC(p, bits)

EOB = [0, 0];

rle = [];
[run, bc_level, shift] = DecodeRunLevelWithHuffman(p, bits(1:end));
bs_ptr = 1 + shift;
while ~isequal([run, bc_level], EOB)
    if 0 ~= bc_level
        mag = DecodeFromColumnIndex(bits(bs_ptr:end), bc_level);
        bs_ptr = bs_ptr + bc_level;
        rle = [rle; run, mag];
    else
        rle = [rle; run, 0];
    end    
    [run, bc_level, shift] = DecodeRunLevelWithHuffman(p, bits(bs_ptr:end));
    bs_ptr = bs_ptr + shift;
end
rle = [rle; EOB];

bs_ptr = bs_ptr - 1; % number of symbols read
AC = RestoreFromRLE(rle);
    