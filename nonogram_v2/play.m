function [MM,end_type] = play(uu,vv,show_flag)

nn = length(uu);
MM = zeros(nn,nn);

%% build the hypotesis from the outside
hyp_tot = build_hyp_tot(nn); % equal for all rows and cols

hyp_w_task_cols = zeros(2.^nn,nn,nn);
% cols: left to right
for col = 1:nn
    hyp_w_task_cols(:,:,col) = build_hyp_w_task(hyp_tot,uu(:,col));
end
hyp_w_task_rows = zeros(2.^nn,nn,nn);
% rows: up to down
for row = 1:nn
    hyp_w_task_rows(:,:,row) = build_hyp_w_task(hyp_tot,vv(:,row));
end

%% works on the hypotesis from the inside
uu_finished = zeros(1,nn); % cols
vv_finished = zeros(1,nn); % rows
turn = 0;
end_flag = false; end_type = -1;
while not(end_flag)
    MM_last_turn = MM;
    
    col_to_do = 1:nn; col_to_do(uu_finished == 1) = [];
    for col = col_to_do
        hyp_w_info = build_hyp_w_info(hyp_w_task_cols(:,:,col),MM(:,col)');
        MM(:,col) = update_MM(hyp_w_info,MM(:,col)')';
        if all(MM(:,col))
            uu_finished(col) = 1;
        end
        
        if show_flag
            plot_square(MM,uu,vv)
        end
    end
    
    row_to_do = 1:nn; row_to_do(vv_finished == 1) = [];
    for row = row_to_do
        hyp_w_info = build_hyp_w_info(hyp_w_task_rows(:,:,row),MM(row,:));
        MM(row,:) = update_MM(hyp_w_info,MM(row,:));
        if all(MM(row,:))
            vv_finished(row) = 1;
        end
        
        if show_flag
            plot_square(MM,uu,vv)
        end
    end
    
    turn = turn + 1;
    
    if MM_last_turn == MM
        end_flag = true;
        fprintf('No single solution!\n')
        end_type = 1;
        
    elseif all(MM)
        end_flag = true;
        fprintf('You win.\n')
        end_type = 0;
    end
end

if show_flag
    plot_square(MM,uu,vv)
end

end