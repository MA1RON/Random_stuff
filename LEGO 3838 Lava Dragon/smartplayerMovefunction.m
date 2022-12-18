function [playerIIfrom,playerJJfrom,playerIIto,playerJJto] = smartplayerMovefunction(board,player,alg)

playerPositions = find(board.e == player);

playerIIfrom = mod(playerPositions,10);
if playerIIfrom == 0
    playerIIfrom = 10;
end
playerJJfrom = ceil(playerPositions/10);

possibleMoves = findpossibleMoves(playerIIfrom,playerJJfrom,board,player);

% chose between the remaining
if alg == 0
    playerPick = ceil(rand()*size(possibleMoves,1)); % 0th algorithm
elseif alg == 1
    playerPick = moveAlg1(possibleMoves,board,playerIIfrom,playerJJfrom,player); % 1st algorithm
elseif alg == 2
    playerPick = moveAlg2(board,playerIIfrom,playerJJfrom,player); % 2nd algorithm
end

playerIIto = possibleMoves(playerPick,1);
playerJJto = possibleMoves(playerPick,2);