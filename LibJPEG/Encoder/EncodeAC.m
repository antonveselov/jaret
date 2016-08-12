function code = EncodeAC(p, x)

rle = ConvertToRLE(x);

code = [];
for pair_no = 1 : size(rle,1)
    run = rle(pair_no,1);
    level = rle(pair_no,2);
    [bc_level, mag] = ToBitCategoryAndAmplitude(level);
    code = [code; EncodeRunLevelWithHuffman(p, run, bc_level)];
    if 0~=level 
        % should be (run~=15 && run~=0) || level~=0, however everything can
        % defined by "level" only
        code = [code; EncodeToColumnIndex(mag, bc_level)];
    end
%     fprintf('%d\t%d\t%d\t%d\n', length(code), run, bc_level, mag)
end