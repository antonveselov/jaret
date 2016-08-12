function JPEGEncoder(image_name, compressed_name, quality)

image_rgb = imread(image_name);
image_ycbcr = rgb2ycbcr(image_rgb);
image{1} = image_ycbcr(:,:,1);
image{2} = image_ycbcr(:,:,2);
image{3} = image_ycbcr(:,:,3);

addpath('./LibJPEG/Common')
addpath('./LibJPEG/Encoder')

p = Bootstrap;
p.q_matrix = MakeQuantizationMatrix(quality, p.bs);
bs = EncodeJPEG(p, image);

fid = fopen(compressed_name, 'wb');
fid_close = onCleanup(@()fclose(fid));
fwrite(fid, length(bs), 'uint8');
fwrite(fid, size(image{1},1), 'uint16');
fwrite(fid, size(image{1},2), 'uint16');
for ii = 1 : length(bs)
    fwrite(fid, length(bs{ii}), 'uint32');
    fwrite(fid, bs{ii}, 'ubit1');
end

rmpath('./LibJPEG/Common')
rmpath('./LibJPEG/Encoder')