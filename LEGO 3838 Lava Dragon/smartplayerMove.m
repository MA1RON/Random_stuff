function [playerIIfrom,playerJJfrom,playerIIto,playerJJto] = smartplayerMove(board,player)

playerPositions = find(board.e == player);

playerIIfrom = mod(playerPositions,10);
if playerIIfrom == 0
    playerIIfrom = 10;
end
playerJJfrom = ceil(playerPositions/10);

possibleMoves = findpossibleMoves(playerIIfrom,playerJJfrom,board,player);

% chose between the remaining
% playerPick = ceil(rand()*size(possibleMoves,1)); % 0th algorithm
% playerPick = moveAlg1(possibleMoves,board,playerIIfrom,playerJJfrom,player); % 1st algorithm
playerPick = moveAlg2(board,playerIIfrom,playerJJfrom,player); % 2nd algorithm

playerIIto = possibleMoves(playerPick,1);
playerJJto = possibleMoves(playerPick,2);