function [run, bc_level, bs_ptr] = DecodeRunLevelWithHuffman(p, bits)

code_word_hash = bi2de(bits(1:p.min_huff_length)', 'left-msb');
bs_ptr = p.min_huff_length;
pos = find(code_word_hash == p.huff_table_bw(:,1),1);
while isempty(pos)
    bs_ptr = bs_ptr + 1;
    code_word_hash = code_word_hash*2 + bits(bs_ptr);
    pos = find(code_word_hash == p.huff_table_bw(:,1),1);
end

run = p.huff_table_bw(pos,2);
bc_level = p.huff_table_bw(pos,3);

