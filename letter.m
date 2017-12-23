function C = letter(sz, margin)

if nargin < 2
    margin = 0;
end

A = rgb2gray(imread('A.png'));
C = imresize(A, sz * [1 1]) < 200;

if margin > 0
    H = zeros(size(C) + 2 * margin);
    H(margin + (1:sz), margin + (1:sz)) = C;
    C = H; 
end
