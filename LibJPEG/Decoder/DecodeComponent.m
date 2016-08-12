function comp = DecodeComponent(p, bit_stream)

comp_dct_fq = zeros(p.height, p.width);
bs_ptr = 1;

d_c = 0 : p.bs - 1;
block_no = 0;
for block_y = 1 : p.bs : p.height
    prev_DC = 0;
    for block_x = 1 : p.bs : p.width
        if p.verbose
            fprintf('Decoding block at (%d,%d)\n', block_y, block_x)
        end
        block_no = block_no + 1;
        [block_data, shift] = DecodeBlock(p, bit_stream(bs_ptr:end), prev_DC);
        bs_ptr = bs_ptr + shift;
        prev_DC = block_data(1,1);        
        comp_dct_fq(block_y+d_c, block_x+d_c) = block_data;
    end
end
comp_dct_iq = blockproc(comp_dct_fq, [p.bs p.bs], @(block)block.data.*p.q_matrix);
comp = blockproc(comp_dct_iq, [p.bs p.bs], @(block)idct2(block.data));

comp = comp + 128;
