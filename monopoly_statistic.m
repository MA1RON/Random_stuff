% this script simulates a game of monopoly without considering money or
% trades, and gives the probability of each square to be stumbled upon, as
% well as the probability of each color.
clc; clear; close all;
format long e

pay_jail_exit = 0.5;

M = zeros(41);
rolldice = zeros(1,40);
rolldice(2:12) = [1, 2, 3, 4, 5, 6, 5, 4, 3, 2, 1]/36;
for s=1:40
        M(s, s+1:40) = rolldice(1:40-s);
        if s~=1
            M(s, 1:s) = rolldice(41-s:40);
        end
end


% from jail equal as from just passage
M(41,:) = M(11,:);

% go to jail (square 41)
M(:,41) = M(:,31);
M(:,31) = 0;

% stay in jail
for pr=1:1e3
    % make double * pay * three turns in jail
    jail_stay_tot_prop = 5 / 6 * (1 - pay_jail_exit) * (1 - M(41,41)^3 );
    M(41,41) = jail_stay_tot_prop;
end
M(41,1:40) = M(41,1:40) / 6;
M(41, 11) = M(41, 11) + M(41,41)^3;

% - - - CHANCHE - - -
% stay there
chance8 = sum(M(:, 8));
chance23 = sum(M(:, 23));
chance37 = sum(M(:, 37));
M(:, 8) = M(:, 8) * 6 / 16;
M(:, 23) = M(:, 23) * 6 / 16;
M(:, 37) = M(:, 37) * 6 / 16;
% go somewhere
M(8, 1) = M(8, 1) + chance8 / 16;
M(23, 1) = M(23, 1) + chance23 / 16;
M(37, 1) = M(37, 1) + chance37 / 16;
M(8, 25) = M(8, 25) + chance8 / 16;
M(23, 12) = M(23, 12) + chance23 / 16;
M(8, 13) = M(8, 13) + chance8 / 16;
M(37, 13) = M(37, 13) + chance37 / 16;
M(23, 29) = M(23, 29) + chance23 / 16;
M(37, 6) = M(37, 6) + chance37*2 / 16;
M(23, 6) = M(23, 6) + chance23 / 16;
M(8, 6) = M(8, 6) + chance8 / 16;
M(8, 16) = M(8, 16) + chance8 / 16;
M(23, 26) = M(23, 26) + chance23 / 16;
M(8, 5) = M(8, 5) + chance8 / 16;
M(23, 20) = M(23, 20) + chance23 / 16;
M(37, 34) = M(37, 34) + chance37 / 16;
M(8, 41) = M(8, 41) + chance8 / 16;
M(23, 41) = M(23, 41) + chance23 / 16;
M(37, 41) = M(37, 41) + chance37 / 16;
M(8, 40) = M(8, 40) + chance8 / 16;
M(23, 40) = M(23, 40) + chance23 / 16;
M(37, 40) = M(37, 40) + chance37 / 16;

% - - - COMMUNITY CHEST - - -
% stay there
chance3 = sum(M(:, 3));
chance18 = sum(M(:, 18));
chance34 = sum(M(:, 34));
M(:, 3) = M(:, 3) * 15 / 17;
M(:, 18) = M(:, 18) * 15 / 17;
M(:, 34) = M(:, 34) * 15 / 17;
% go somewhere
M(3, 1) = M(3, 1) + chance3 / 17;
M(18, 1) = M(18, 1) + chance18 / 17;
M(34, 1) = M(34, 1) + chance34 / 17;
M(3, 41) = M(3, 41) + chance3 / 17;
M(18, 41) = M(18, 41) + chance18 / 17;
M(34, 41) = M(34, 41) + chance34 / 17;

% fine della costruzione di M
% ripeto per turni

fM = M(1,:); % parto dal Go
for turn=1:1000
    fM = fM*M;
    fM = fM/norm(fM);
end

jail_bar = zeros(1,40);
jail_bar(11) = fM(41);
bar(1:40, [fM(1:40)' jail_bar'] / sum(sum([fM(1:40)' jail_bar'])), 'stacked')
figure()

% group by color
fcM = [fM(2) + fM(4), fM(7) + fM(9) + fM(10), fM(12) + fM(14) + fM(15), fM(17) + fM(19) + fM(20), fM(22) + fM(24) + fM(25), fM(27) + fM(29) + fM(30), fM(32) + fM(33) + fM(35), fM(38) + fM(40)];
for j=1:8
    v = zeros(1,8);
    v(j) = fcM(j);
    bar(1:8, v)
    hold on
end
legend({'brown','cyan','pink','orange','red','yellow','green','blue'})
