function status = TestRLEWithHuffman(p)
%ENCODEDECODEDC Summary of this function goes here
%   Detailed explanation goes here

num_tests = 100000;
run_tests = unidrnd(16, num_tests, 1)-1;
bc_level_tests = unidrnd(10, num_tests, 1);
run_tests(1:2) = [0; 15];       % test ZRL
bc_level_tests(1:2) = [0; 0];   % test EOB

status = true;
for test_no = 1 : num_tests
    run = run_tests(test_no);
    bc_level = bc_level_tests(test_no);
    code = EncodeRunLevelWithHuffman(p, run, bc_level);
    [run_dec, bc_level_dec, code_len] = DecodeRunLevelWithHuffman(p, code);
    if run~=run_dec || bc_level~=bc_level_dec || length(code)~=code_len
        fprintf('Test error:\n')
        fprintf('%d ', v)
        fprintf('\n')
        fprintf('%d ', v_rec)
        fprintf('\n')
        status = false;
        return
    end
end


end

