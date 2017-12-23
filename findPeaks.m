function p = fp(I, tau)

middle = I(2:(end-1), 2:(end-1));
sm = size(middle) - 1;
ismax = middle >= tau;
for dr = 1:3
    for dc = 1:3
        if dr ~= 2 || dc ~= 2
            ismax = ismax & (middle > I(dr:(dr+sm(1)), dc:(dc+sm(2))));
        end
    end
end

[row, col] = find(ismax);
p = [row, col] + 1;