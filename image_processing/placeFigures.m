%    function placeFigures
%
% Place all the currently open figures in order from first to last,
% staggered on the display so they can be easily inspected

function placeFigures

% Get all figures
ch = get(0, 'Children');
n = length(ch);
fig = zeros(n, 1);
for k = 1:n
    if strcmp(get(ch(k), 'Type'), 'figure')
        fig(k) = get(ch(k), 'Number');
    end
end
ok = fig ~= 0;
ch = ch(ok);
fig = fig(ok);

% Sort figures in order of decreasing number
[fig, order] = sort(fig, 'descend');
ch = ch(order);
n = length(ch);

% Stagger the figures in the bottom-left corner of the display
for k = 1:n
    figure(fig(k))
    pos = get(ch(k), 'Position');
    pos(1:2) = [30 70] + (n - k) * [10 22];
    set(gcf, 'Position', pos);
end
