function status = TestEncodeDecodeDC(p)
%ENCODEDECODEDC Summary of this function goes here
%   Detailed explanation goes here
status = true;
possible_DC = 0 : 2040;
for prev_DC = possible_DC
    for DC = possible_DC
        code = EncodeDC(p, DC, prev_DC);
        dec_DC = DecodeDC(p, code, prev_DC);
        if DC ~= dec_DC
            fprintf('Test error (original ~= decoded): %d ~= %d. Previous DC: %d\n', DC, dec_DC, prev_DC)
            status = false;
            return
        end
    end
end


end

