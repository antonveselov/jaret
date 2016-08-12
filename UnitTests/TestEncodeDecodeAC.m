function status = TestEncodeDecodeAC(p)
%ENCODEDECODEDC Summary of this function goes here
%   Detailed explanation goes here

num_tests = 100000;
status = true;
for test_no = 1 : num_tests
    AC = zeros(1,63);
    pos = randperm(63);
    num_coeffs_non_zero = unidrnd(2);
    AC(pos(1:num_coeffs_non_zero)) = -1023 + unidrnd(2046,num_coeffs_non_zero,1);
    code = EncodeAC(p, AC);
    [AC_dec, code_len] = DecodeAC(p, code);
    if ~isequal(AC, AC_dec) || length(code) ~= code_len
        status = false;
        return
    end
end


end

