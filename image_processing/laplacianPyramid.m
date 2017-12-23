%    function out = laplacianPyramid(in, factor)
%
% If 'in' is a structure, it is assumed to be a Laplacian pyramid, wihch is
% then used to reconstruct the original image.
%
% If 'in' is not a structure, it is assumed to be an image, for which a
% Laplacian pyramid is built with the given sampling factor.
%
% It is an error to provide factor when the first input is a pyramid.

function out = laplacianPyramid(in, factor)

if isstruct(in)
    operation = 'reconstruct';
    if nargin > 1
        error('Cannot specify sampling factor for reconstruction')
    end
else
    operation = 'decompose';
    if nargin < 2 || isempty(factor)
        factor = 1/2;
    else
        if factor <= 0 || factor >= 1
            error('Sampling factor must be between 0 and 1 not inclusive')
        end
    end
    
    levels = floor(-log(min(size(in)))/log(factor));
end

switch operation
    case 'decompose'
        p.class = class(in);
        in = double(in);
        p.h = cell(1, levels);
        p.l = in;
        for k = 1:levels
            d = down(p.l);
            p.h{k} = p.l - up(d, size(p.l));
            p.l = d;
        end
        out = p;
    case 'reconstruct'
        levels = length(in.h);
        out = in.l;
        for k = levels:-1:1
            out = up(out, size(in.h{k}));
            out = out + in.h{k};
        end
        out = cast(out, in.class);
    otherwise
end

    function small = down(big)
        small = imresize(big, factor);
    end

    function big = up(small, s)
        big = imresize(small, s);
    end

end