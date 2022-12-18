function showBoard(board)

boardToshow = zeros(30,30);
for ii = 1:30
    for jj = 1:30
        if mod(jj,3) == 2 && mod(ii,3) == 2
            boardToshow(ii,jj) = -2*board.e(ceil(ii/3),ceil(jj/3));
        else
            boardToshow(ii,jj) = board.g(ceil(ii/3),ceil(jj/3));
        end
    end
end

if board.t == 1
    figure('Position',[520 10 900 700])
end
heatmap(boardToshow,...
        'Colormap',copper,...
        'ColorbarVisible','off',...
        'fontsize',24)

Ax = gca;
Ax.XDisplayLabels = nan(size(Ax.XDisplayData));
Ax.YDisplayLabels = nan(size(Ax.YDisplayData));
    
title(['Turn ' num2str(board.t)])
fprintf(['Turn ' num2str(board.t) '.\n'])
