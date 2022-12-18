function [board, players] = updateBoard(board,playerMoving,playerMoves,lavaMove,players)

if lavaMove
    [lavaIIfrom,lavaJJfrom,lavaIIto,lavaJJto] = smartlavaMove(board,playerMoving,players);
    
    board.e(lavaIIfrom,lavaJJfrom) = 0;
    board.e(lavaIIto,lavaJJto) = 5;
end

for player = [playerMoving:4 1:playerMoving-1]
    leftMoves = playerMoves(player);
    while leftMoves > 0
        [playerIIfrom,playerJJfrom,playerIIto,playerJJto] = smartplayerMove(board,player);
        
        board.e(playerIIfrom,playerJJfrom) = 0;
        board.e(playerIIto,playerJJto) = player;
        players(player).position = [playerIIto playerJJto];
        
        leftMoves = leftMoves - 1;
    end
end