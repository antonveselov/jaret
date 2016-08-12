function bit_stream = EncodeComponent(p, comp)

% DC level shift
comp = comp - 128;

comp_dct = blockproc(comp, [p.bs p.bs], @(block)dct2(block.data));
comp_dct_fq = blockproc(comp_dct, [p.bs p.bs], @(block)round(block.data./p.q_matrix));

d_c = 0 : p.bs - 1;
num_blocks = numel(comp) / (p.bs^2);
block_bit_stream = cell(num_blocks,1);
block_no = 0;
for block_y = 1 : p.bs : size(comp_dct,1)
    % prev_DC should be initialized to zero at the beginning of each scan
    % (F.1.1.5.1), however standard tests (on high quliaty) sometimes 
    % produce better results without this initialization. Check it.
    prev_DC = 0;
    for block_x = 1 : p.bs : size(comp_dct,2)
        if p.verbose
            fprintf('Encoding block at (%d,%d)\n', block_y, block_x)
        end        
        block_no = block_no + 1;
        block_data = comp_dct_fq(block_y+d_c, block_x+d_c);
        block_bit_stream{block_no} = EncodeBlock(p, block_data, prev_DC);
        prev_DC = block_data(1,1);
    end
end
% squeez bit streams into a single stream
bit_stream = cell2mat(block_bit_stream);