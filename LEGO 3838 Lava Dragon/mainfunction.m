function [endFlag,finalTurn] = mainfunction(alg)
dice = makeDice();
players = makePlayers();
board = makeBoard();
playerMoving = 1;
endFlag = 0;

while ~endFlag
    [dice,lavaMove,playerMoves,players] = rollDice(dice,players,playerMoving,0);
    
    [board, players] = updateBoardfunction(board,playerMoving,playerMoves,lavaMove,players,alg);
    
    playerMoving = updateplayerMoving(playerMoving);
    endFlag = updateendFlag(players,board);
    board.t = board.t + 1;
end
finalTurn = board.t;