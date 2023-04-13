%Question 1
origin = imread("marina_bay.jpg");
x = rgb2ycbcr(origin);
figure(Name ="Fig1a")
imshow(x)

s = size(x);
x = padarray(x, [8 - rem(size(x, 1), 8), 8 - rem(size(x, 2), 8)], 'replicate', 'post');

nheights = floor(size(x, 1)/8);
nwidths= floor(size(x, 2)/8);

%https://www.mathworks.com/matlabcentral/answers/89757-how-to-divide-256x256-matrix-into-sixteen-16x16-blocks
blockMatrix = mat2cell(x, ...
    8*ones(1, nheights), ...
    8*ones(1, nwidths), 3);

freqMatrix = zeros(size(x)); % dont need this line, easier to work with cell arrays (dynamic size)

Q = [16 11 10 16 24 40 51 61 ;
     12 12 14 19 26 28 60 55 ;
     14 13 16 24 40 57 69 56 ;
     14 17 22 29 51 87 80 62 ;
     18 22 37 56 68 109 103 77 ;
     24 35 55 64 81 104 113 92 ;
     49 64 78 87 103 121 120 101;
     72 92 95 98 112 100 103 99];

freqCells = {};

for i=1:nheights
    for j=1:nwidths
        for k =1:3
            block = double(blockMatrix{i, j}(:, :, k));
            %fftout = chebfun.dct(chebfun.dct(block).').';%Replace with dct implementation using fft
            fftout = real(fft2(block));
            result = fix(fftout./Q);
            freqMatrix((i-1)*8+1:i*8, (j-1)*8+1:j*8, k) = result; %dont need this either
            freqCells{i, j, k} = result; 
        end
    end
end

imshow(freqMatrix(:, :, 1))

%Run length encoding of 0's
rlencoded = {};
for i=1:nheights
    for j=1:nwidths
        for k =1:3
            rlencoded{i,j,k} = rle(freqCells{i,j,k});
        end
    end
end



%symbols = unique(b);
%#prob = histcounts(b,length(symbols))/length(b);
%dict = huffmandict(symbols, prob);
%enco = huffmanenco(b, dict);


