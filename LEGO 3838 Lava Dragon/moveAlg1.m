function playerPick = moveAlg1(possibleMoves,board,playerIIfrom,playerJJfrom,player)
% this algorithm simply looks for higher spots to go on and goes there

myG = board.g(playerIIfrom,playerJJfrom);

effG = zeros(size(possibleMoves,1),1);
for possibleMove = 1:size(possibleMoves,1)
    possibleMoves2 = findpossibleMoves(possibleMoves(possibleMove,1),possibleMoves(possibleMove,2),board,player);
    effG(possibleMove) = max(diag(board.g(possibleMoves2(:,1),possibleMoves2(:,2))));
end

[~,playerPick] = min(myG - effG);