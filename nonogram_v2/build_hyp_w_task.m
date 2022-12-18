function hyp_new = build_hyp_w_task(hyp,uu)

nn = size(hyp,2);
hyp_new = zeros(2.^nn,nn);
uu_to_use = uu(uu~=0);
jj_w_task = 1;

jj = 1;
while jj <= size(hyp,1)
    uu_used = 0;
    counter = 0;
    broke_flag = false;
    
    kk = 1;
    while kk <= nn
        if hyp(jj,kk) == 1
            counter = counter + 1;
        end
        if hyp(jj,kk) == -1
            % a -1 after a 1
            if uu(uu_used+1) == counter && counter
                uu_used = uu_used + 1;
                counter = 0;
            % wrong order
            elseif counter
                broke_flag = true;
            end
        end
        
        % last iteration
        if kk == nn
            % 1 just before the end of the row, with the right combination
            if counter && uu(uu_used+1) == counter && counter
                uu_used = uu_used + 1;
            % wrong order
            elseif counter
                broke_flag = true;
            end
            
            % used all info in the task
            if uu_used == length(uu_to_use) && not(broke_flag)
                hyp_new(jj_w_task,1:nn) = hyp(jj,:); % store it
                jj_w_task = jj_w_task + 1;
                hyp(jj,:) = [];
                jj = jj - 1;
            % didn't use all the info (or more or in the wrong order): delete it
            else
                hyp(jj,:) = [];
                jj = jj - 1;
            end
        end
        
        kk = kk + 1;
    end
    jj = jj + 1;
end

end