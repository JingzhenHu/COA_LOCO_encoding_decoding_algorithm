% store_least method pre calculation

function [pre_cal] = store_least_pre_cal(N_q,m,x,q)

% store all the possible data needed for the run-time in a cell
% with O(xlog2q)
pre_cal = cell(x+1,m+x+1);
for i = 1:x+1
    for j = 1:m+x+1
            pre_cal{i,j} = (q-1)^(i-1)*N_q(1,j);
    end
end

end


