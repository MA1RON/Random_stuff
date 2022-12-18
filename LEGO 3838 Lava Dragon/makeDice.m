function dice = makeDice()

dice = zeros(6,4);
dice([1,3],[1,2]) = -1; % lava blocks