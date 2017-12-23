%    function img = compositePyramid(h, l)
%
% Composite the pyramid in h into a single image img for display.
% For Gaussian pyramids as returned by pyr = gaussianPyramid(I),
% set h to pyr and l to [].
% For Laplacian pyramids as returned by pyr = laplacianPyramid(I),
% set h to pyr.h and l to pyr.l (or to [])

function img = compositePyramid(h, l)

if nargin < 2
    l = [];
end

s = size(h{1});
img = zeros([s(1) ceil(1.5 * s(2))]);
img(1:s(1), 1:s(2)) = h{1};
roff = 0;
coff = s(2);
for k = 2:length(h)
    t = size(h{k});
    img(roff + (1:t(1)), coff + (1:t(2))) = h{k};
    roff = roff + t(1);
end
if ~isempty(l)
    t = size(l);
    img(roff + (1:t(1)), coff + (1:t(2))) = l;
end