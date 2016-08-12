function p = Bootstrap

p.bs = 8;
p.quality = 1; % default
p.q_matrix = MakeQuantizationMatrix(p.quality, p.bs);
p.zz = [1 9 2 3 10 17 25 18 11 4 5 12 19 26 33 41 34 27 20 13 6 7 14 ...
    21 28 35 42 49 57 50 43 36 29 22 15 8 16 23 30 37 44 51 58 59 52 45 38 ...
    31 24 32 39 46 53 60 61 54 47 40 48 55 62 63 56 64];  % zigzag order for DCT scan

% TODO: add support for different huff tables for different color
% components
[p.huff_table_fw, p.huff_table_bw, p.min_huff_length] = GetHuffTable();
p.verbose = false;