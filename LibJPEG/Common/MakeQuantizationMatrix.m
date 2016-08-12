function q_matrix = MakeQuantizationMatrix(q, block_size)

q_matrix = zeros(8);
for ii = 1 : block_size
    for jj = 1 : block_size
        q_matrix(ii,jj) = 1 + (ii+jj-2)*q;
    end
end