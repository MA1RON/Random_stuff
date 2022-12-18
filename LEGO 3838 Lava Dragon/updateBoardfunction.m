function [board, players] = updateBoardfunction(board,playerMoving,playerMoves,lavaMove,players,alg)

if alg == 3
    pAlg = 2;
    lAlg = 1;
else
    pAlg = alg;
    lAlg = 0;
end

if lavaMove
    [lavaIIfrom,lavaJJfrom,lavaIIto,lavaJJto] = smartlavaMovefunction(board,playerMoving,players,lAlg);
    
    board.e(lavaIIfrom,lavaJJfrom) = 0;
    board.e(lavaIIto,lavaJJto) = 5;
end

for player = [playerMoving:4 1:playerMoving-1]
    leftMoves = playerMoves(player);
    while leftMoves > 0
        [playerIIfrom,playerJJfrom,playerIIto,playerJJto] = smartplayerMovefunction(board,player,pAlg);
        
        board.e(playerIIfrom,playerJJfrom) = 0;
        board.e(playerIIto,playerJJto) = player;
        players(player).position = [playerIIto playerJJto];
        
        leftMoves = leftMoves - 1;
    end
end