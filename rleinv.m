function decoding = rleinv(encoding)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
decoding = [];
zero = 0;
for i=1:size(encoding, 2)
    if encoding(i) == 0
        zero=1;
    else
        if zero==1
            decoding = [decoding zeros(1,encoding(i))];
            zero = 0;
        else
            decoding = [decoding encoding(i)];
        end
    end
end
decoding = reshape(decoding, 8, 8).';
end

