function [lavaIIfrom,lavaJJfrom,lavaIIto,lavaJJto] = smartlavaMove(board,playerMoving,players)

lavaPick = ceil(rand()*12);
lavaPositions = find(board.e == 5);

lavaIIfrom = mod(lavaPositions(lavaPick),10);
if lavaIIfrom == 0
    lavaIIfrom = 10;
end

lavaJJfrom = ceil(lavaPositions(lavaPick)/10);

lavaFlag = false;
while ~lavaFlag
    % lavaIIto = ceil(rand()*10); lavaJJto = ceil(rand()*10); % lava alg 0
    [lavaIIto, lavaJJto] = lavaAlg1(board,playerMoving,players); % laga alg 1
    
    if ~board.e(lavaIIto,lavaJJto)
        lavaFlag = true;
    end
end