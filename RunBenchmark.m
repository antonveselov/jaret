addpath('./LibJPEG/Common')
addpath('./LibJPEG/Encoder')
addpath('./LibJPEG/Decoder')

p = Bootstrap;

images = {...
    './Benchmark/Images/lena.bmp'
    './Benchmark/Images/airplane.bmp'
    './Benchmark/Images/baboon.bmp'
    './Benchmark/Images/peppers.bmp'
    };

for image_no = 1 : length(images)
    fprintf('Image %s (%d/%d)\n', images{image_no}, image_no, length(images));
    image_rgb = imread(images{image_no});
    image_ycbcr = rgb2ycbcr(image_rgb);
    image{1} = double(uint8(image_ycbcr(:,:,1)));
    [p.height, p.width] = size(image{1});
    p.depth = length(image);
    
    ind = 0;
    quality = 1:5:100;
    psnr = zeros(length(quality), 1);
    rate = zeros(length(quality), 1);
    psnr_ref = zeros(length(quality), 1);
    rate_ref = zeros(length(quality), 1);
    for ii = 1 : length(quality)
        fprintf('Processing %d/%d\n', ii, length(quality));

        q = quality(ii);
        p.q_matrix = MakeQuantizationMatrix(q, p.bs);

        fprintf('Encoding...\n');
        tic
        bs = EncodeJPEG(p, image);
        toc
        fprintf('Size: %d\n', length(cell2mat(bs)))

        fprintf('Decoding...\n');
        tic
        image_dec = DecodeJPEG(p, bs);
        toc

        ind = ind + 1;
        psnr(ind) = psnr_mse_maxerr(image{1}, image_dec{1});
        rate(ind) = sum(cell2mat(bs));

        imwrite(uint8(image{1}), 'tmp.jpg', 'Quality', q)
        image_dec_ref = imread('tmp.jpg');
        psnr_ref(ind) = psnr_mse_maxerr(image{1}, image_dec_ref);
        img_info = dir('tmp.jpg');
        rate_ref(ind) = img_info.bytes*8;
    end

    figure
    hold on
    plot(rate, psnr)
    plot(rate_ref(end:-1:1), psnr_ref(end:-1:1))
    grid on
    legend('JARET', 'Matlab')
    title(images{image_no})
    hold off
end

delete('tmp.jpg')

rmpath('./LibJPEG/Common')
rmpath('./LibJPEG/Encoder')
rmpath('./LibJPEG/Decoder')