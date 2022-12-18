function [lavaIIto, lavaJJto] = lavaAlg1(board,playerMoving,players)

lenPath = zeros(4,1);

playerArray = 1:4;
for player = playerArray(playerArray ~= playerMoving)
    % find position of player
    playerPositions = find(board.e == player);
    playerIIfrom = mod(playerPositions,10);
    if playerIIfrom == 0
        playerIIfrom = 10;
    end
    playerJJfrom = ceil(playerPositions/10);
    
    [~, parentsHistory] = moveAlg2(board,playerIIfrom,playerJJfrom,player);
    lenPath(player) = length(parentsHistory);
end

lenPath(playerMoving) = nan;
[~, minPlayer] = min(lenPath);

playerPositions = find(board.e == minPlayer);
playerIIfrom = mod(playerPositions,10);
if playerIIfrom == 0
    playerIIfrom = 10;
end
playerJJfrom = ceil(playerPositions/10);

targetpossibleMoves = findpossibleMoves(playerIIfrom,playerJJfrom,board,minPlayer);
if size(targetpossibleMoves,1) > 1
    targetplayerPick = moveAlg2(board,playerIIfrom,playerJJfrom,minPlayer);

    lavaIIto = targetpossibleMoves(targetplayerPick,1);
    lavaJJto = targetpossibleMoves(targetplayerPick,2);
    while board.e(lavaIIto,lavaJJto)
        if targetplayerPick < length(targetpossibleMoves) - 1
            targetplayerPick = targetplayerPick + 1;
        else
            targetplayerPick = 1;
        end

        lavaIIto = targetpossibleMoves(targetplayerPick,1);
        lavaJJto = targetpossibleMoves(targetplayerPick,2);
    end
else
    lavaFlag = false;
    while ~lavaFlag
        lavaIIto = ceil(rand()*10); lavaJJto = ceil(rand()*10); % lava alg 0

        if ~board.e(lavaIIto,lavaJJto)
            lavaFlag = true;
        end
    end
end

% it may block the player itself but whatever
