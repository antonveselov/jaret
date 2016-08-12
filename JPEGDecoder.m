function JPEGDecoder(compressed_name, image_name, quality)

addpath('./LibJPEG/Common')
addpath('./LibJPEG/Decoder')

p = Bootstrap;
p.q_matrix = MakeQuantizationMatrix(quality, p.bs);

fid = fopen(compressed_name, 'rb');
fid_close = onCleanup(@()fclose(fid));
p.depth = fread(fid, 1, 'uint8');
p.height = fread(fid, 1, 'uint16');
p.width = fread(fid, 1, 'uint16');
bs = cell(p.depth,1);
for ii = 1 : p.depth    
    bs_len = fread(fid, 1, 'uint32');    
    bs{ii} = fread(fid, bs_len, 'ubit1');
end
image = DecodeJPEG(p, bs);

if 3 == p.depth
    image_ycbcr = cat(3, image{1}, image{2}, image{3});
    image_rgb = ycbcr2rgb(image_ycbcr);
    imwrite(image_rgb, image_name);
else
    imwrite(image{1}, image_name);
end

rmpath('./LibJPEG/Common')
rmpath('./LibJPEG/Decoder')

