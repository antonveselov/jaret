function v = RestoreFromRLE(rle)

v = zeros(1,63);
if isempty(rle)
    return
end
rle = rle(1:end-1,:);
pos_non_zero = cumsum(rle(1:end,1)+1);
v(pos_non_zero) = rle(1:end,2)';