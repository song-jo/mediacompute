
huffdecoded = {};
nheights = size(huffencoded, 1);
nwidths = size(huffencoded, 2);
for i=1:nheights
    for j=1:nwidths
        for k =1:3
            if size(huffencoded{i,j,k},1) == 0
                huffdecoded{i,j,k} = [0 64];
            else
                huffdecoded{i,j,k} = huffmandeco(huffencoded{i,j,k}, dict);
            end
        end
    end
end


finalresult = zeros(size(nheights, nwidths, 3));

for i=1:nheights
    for j=1:nwidths
        for k =1:3
            fftout =real(ifft2(Q.*rleinv(huffdecoded{i,j,k})));
            finalresult((i-1)*8+1:i*8, (j-1)*8+1:j*8, k) = fftout;
            
        end
    end
end

%Show compressed Image 

imshow(ycbcr2rgb(uint8(finalresult)))

