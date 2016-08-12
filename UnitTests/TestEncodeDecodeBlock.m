function status = TestEncodeDecodeBlock(p)
%ENCODEDECODEDC Summary of this function goes here
%   Detailed explanation goes here

num_tests = 10000;
status = true;
fprintf('%5.1f%%', 0)
for test_no = 1 : num_tests
    fprintf('\b\b\b\b\b\b%5.1f%%', test_no*100/num_tests)
    prev_DC = unidrnd(2041)-1;
    block_data = round(dct2(unidrnd(256, 8, 8)-1));
    block_bit_stream = EncodeBlock(p, block_data, prev_DC);
    block_data_dec = DecodeBlock(p, block_bit_stream, prev_DC);
    if ~isequal(block_data, block_data_dec)
        save(sprintf('TestEncodeDecodeBlock_%d.mat', test_no))
        status = false;
        return
    end
end
fprintf('\b\b\b\b\b\b')

end

