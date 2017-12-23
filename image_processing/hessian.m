%    function [H, skernel, dkernel] = hessian(img, sigma)
%
% Compute the Hessian of img with smoothing factor sigma (default 1 pixel).
%
% Also return the kernels used in the computation if enough output
% arguments are provided.

function [H, skernel, dkernel] = hessian(img, sigma)

% Assign a default standard deviation if needed
if nargin < 2 || isempty(sigma)
    sigma = 1;
end

nd = ndims(img);

% Convert to doubles if needed
img = double(img);

[g, skernel, dkernel] = gradn(img, sigma);

% Allocate storage for the upper triangle of H
H = cell(nd, nd);

% Compute half of the matrix, and copy the other half by symmetry
for j = 1:nd
    h = gradn(g{j}, sigma, j);
    for i = 1:j
        H{i, j} = h{i};
        if i ~= j
            H{j, i} = h{i};
        end
    end
end