function RunUnitTests

    addpath('./LibJPEG/Common')
    addpath('./LibJPEG/Encoder')
    addpath('./LibJPEG/Decoder')
    addpath('./UnitTests')

    tests = {...
        'TestEncodeDecodeDC'
        'TestRLE'
        'TestRLEWithHuffman'
        'TestEncodeDecodeAC'
        'TestEncodeDecodeBlock'
        };
    
    p = Bootstrap;
    
    num_tests = length(tests);
    passed = 0;
    failed = 0;
    for test_no = 1 : num_tests
        if true == RunUnitTest(tests{test_no}, p)
            passed = passed + 1;
        else
            failed = failed + 1;
        end
    end    
    fprintf('\n\nTOTAL: %d, PASSED: %d, FAILED: %d\n', num_tests, passed, failed);

    rmpath('./LibJPEG/Common')
    rmpath('./LibJPEG/Encoder')
    rmpath('./LibJPEG/Decoder')
    rmpath('./UnitTests')
end

function status = RunUnitTest(test_name, params)
    exec_test_command = sprintf('%s(params)', test_name);
    fprintf('%s : ', test_name)
    status = eval(exec_test_command);
    if true == status
        fprintf('OK')
    else
        fprintf('FAIL')
    end
    fprintf('\n')
end