%    function nextFig = imShowGray(img, clip, fig, bar, tle)
%
% Display the image img as a gray-level image in figure fig, or in the
% current figure if fig is either unsepcified or set to []. Return the next
% available figure number.
%
% If img is a color image, it is first converted to gray.
%
% If img contains both positive and negative values, the color map is set
% so that zero is mapped to mid gray. If img contains only nonnegative
% values, then zero is mapped to black. If img contains only nonpositive
% values, then zero is mapped to white.
%
% If clip is specified and is a real number between 0 and 50, the image
% values are first clipped to remove the top and bottom 'clip' percentiles
% from a signed image, the top 'clip' percentile from a nonnegative image,
% or the bottom 'clip' percentile from a nonpositive image.
% Clip can be left unspecified or set to [], in which cases no clipping
% occurs.
%
% If bar is unspecified, set to [], or  set to true, a colorbar is shown.
% If bar is set to false, no colorbar is shown.
%
% If tle is a nonempty string, it is set as the figure's title. If tle is
% empty or nuspecified, no title is added.

function nextFig = imShowGray(img, clip, fig, bar, tle)

if nargin < 2 || isempty(clip)
    clip = 0;
elseif clip < 0
    clip = 0;
elseif clip > 50
    clip = 50;
end

if nargin < 3 || isempty(fig)
    fig = get(gcf, 'Number');
end

if nargin < 4 || isempty(bar)
    bar = true;
end

if ndims(img) == 3
    img = rgb2gray(img);
end

if ~ismatrix(img)
    error('The first input must be a color or gray-level image')
end

img = double(img);

pos = false;
neg = false;
if any(img(:) > 0)
    pos = true;
    cmax = prctile(img(:), 100 - clip);
    img(img > cmax) = cmax;
end
if any(img(:) < 0)
    neg = true;
    cmin = prctile(img(:), clip);
    img(img < cmin) = cmin;
end

mn = min(img(:));
mx = max(img(:));

if pos && neg
    range = [mn, mx];
elseif neg
    range = [mn, 0];
else
    range = [0, mx];
end

figure(fig)
clf

imshow(img, range);
title(tle, 'Interpreter', 'latex', 'FontSize', 14);

nextFig = fig + 1;

if bar
    colorbar
end