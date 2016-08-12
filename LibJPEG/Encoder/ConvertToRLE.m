function rle = ConvertToRLE(x)

pos_non_zero = find(x ~= 0);
if isempty(pos_non_zero)
    rle = [0, 0];
    return
end

runs = [pos_non_zero(1)-1, pos_non_zero(2:end) - pos_non_zero(1:end-1)-1]';
levels = x(pos_non_zero)';
rle = [runs, levels];
rle = [rle; 0, 0]; % append End of Block (EOB) code

% insert Zero Run Length (ZRL) codes
while any(rle(:,1) > 15)
    long_sequence_pos = find(rle(:,1) > 15, 1);
    rle(long_sequence_pos,1) = rle(long_sequence_pos,1) - 16;
    rle = [
        rle(1:long_sequence_pos-1,:);
        [15, 0];
        rle(long_sequence_pos:end,:);
        ];
end