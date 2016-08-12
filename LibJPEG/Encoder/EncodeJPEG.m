function bs = EncodeJPEG(p, image)

bs = cell(length(image),1);

for comp_no = 1 : length(image)
    bs{comp_no} = EncodeComponent(p, double(image{comp_no}));
end
