function co = xcorr(T, I)

co = normxcorr2(T, I);
h = floor(size(T, 1)/2) - 1;
co = co(h + (1:size(I, 1)), h + (1:size(I, 2)));
