function [bc, mag] = ToBitCategoryAndAmplitude(c)

bc = ceil(log2(abs(c)+1));
mag = c;