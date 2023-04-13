function encoding = rle(freqCells)
%Encodes a string in special '0' run length encoding
% Will only shorten strings of 0's because chance of consecutive numbers>1 is small
    encoding = [];
    zerocount = 0;
    for row=1:size(freqCells,1)
        for col = 1:size(freqCells,2)
            val = freqCells(row,col);
            if val == 0
                zerocount = zerocount +1;
                
            else
                if zerocount>0
                    encoding = [encoding 0 zerocount val];
                    zerocount = 0;
                else
                    encoding = [encoding val];
                end
            end
        end
    end
    if zerocount>0
        encoding = [encoding 0 zerocount];
    end

end


