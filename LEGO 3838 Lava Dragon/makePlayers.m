function players = makePlayers()

players = [struct('movementSquares',9,...
                 'position',[10 1]);...
           struct('movementSquares',9,...
                 'position',[1 1]);...
           struct('movementSquares',9,...
                 'position',[1 10]);...
           struct('movementSquares',9,...
                 'position',[10 10])];