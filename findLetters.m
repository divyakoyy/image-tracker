function [p, corr] = findLetters(I, tau)

T = letter(10, 5);
dim_t = size(T);
img = imread(I);
pyr = gaussianPyramid(img, 0.75);
corr = zeros(size(img));

for l = 1:length(pyr)
    dim_pyr = size(pyr{l});
    if dim_pyr(1) < dim_t(1) || dim_pyr(2) < dim_t(2)
        break;
    else
        % compute correlation with level of the pyramid
        C = xcorr(T, pyr{l});
        % resize the correlation to the size of I
        C = imresize(C, size(img));
        maxima = findPeaks(C, tau);

        for i = 1:size(maxima,1)
            r = maxima(i, 1);
            c = maxima(i, 2);        
            corr(r,c) = max(corr(r,c), C(r,c));         
        end
    end   
end

tau_thres = corr > tau;
[rows,cols] = find(tau_thres);
p = [rows, cols];
imagesc(img);
hold on;
plot(p(:, 2), p(:, 1), '.r', 'MarkerSize', 36);
        
end


