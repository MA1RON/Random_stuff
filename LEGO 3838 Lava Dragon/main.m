clc; clear; close all;

dice = makeDice();
players = makePlayers();
board = makeBoard();
playerMoving = 1;
endFlag = 0;

while ~endFlag
    showBoard(board)
    [dice,lavaMove,playerMoves,players] = rollDice(dice,players,playerMoving,1);
    
    input('');
    
    [board, players] = updateBoard(board,playerMoving,playerMoves,lavaMove,players);
    
    playerMoving = updateplayerMoving(playerMoving);
    endFlag = updateendFlag(players,board);
    board.t = board.t + 1;
end

if endFlag > -1
    fprintf(['Player ' num2str(endFlag) ' won.\n'])
else
    fprintf('Reached maximum number of moves.\n')
end
showBoard(board)