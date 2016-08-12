function status = TestRLE(p)
%ENCODEDECODEDC Summary of this function goes here
%   Detailed explanation goes here

num_tests = 1000;
status = true;
for test_no = 1 : num_tests
    v = zeros(1,63);
    pos = randperm(63);
    num_coeffs_non_zero = unidrnd(63);
    v(pos(1:num_coeffs_non_zero)) = -1024 + unidrnd(2048,num_coeffs_non_zero,1);
    rle = ConvertToRLE(v);
    v_rec = RestoreFromRLE(rle);
    if ~isequal(v, v_rec)
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

