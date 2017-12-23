% Test image processing software:
%    gradn, hessian, gaussianPyramid, laplacianPyramid (the latter used in
%    both directions)
% Type help <fcn> to find out more about function <fcn>

close all

img = rgb2gray(imread('eye.jpg'));

g = gradn(img);
gmag = sqrt(g{1} .^ 2 + g{2} .^ 2);
H = hessian(img);
p = gaussianPyramid(img);
l = laplacianPyramid(img);
reconstructed = laplacianPyramid(l);

%%% Display the results
clipPercentile = 0.9;
comp = ['y', 'x'];

fig = 1;

fig = imShowGray(img, 0, fig, false, 'I');

for d = 1:2
    fig = imShowGray(g{d}, clipPercentile, fig, true, ...
        sprintf('$\\nabla I_%c$', comp(d)));
end

fig = imShowGray(gmag, clipPercentile, fig, true, '$\|\nabla I\|$');

for i = 1:2
    for j = i:2
        if i == j
            more = '';
        else
            more = sprintf(' = H_{%d, %d}(I)', j, i);
        end
        fig = imShowGray(H{i, j}, clipPercentile, fig, true, ...
            sprintf('Hessian component $H_{%d, %d}(I)%s$', i, j, more));
    end
end

fig = imShowGray(compositePyramid(p, []), clipPercentile, fig, false, ...
    'Gaussian Pyramid of $I$');

fig = imShowGray(compositePyramid(l.h, []), clipPercentile, fig, true, ...
    'Laplacian Pyramid of $I$');

fig = imShowGray(reconstructed, 0, fig, false, ...
    'I as reconstructed from its Laplacian pyramid');

placeFigures;