% pre_calculation storage for log2q-storage encoding and decoding

function [pre_cal] = store_log_pre_cal(m,x,q)

% compute all the cardinalities
N_q = cardinality(m,x,q);

% store all the possible data needed for the run-time in a cell
% with O((log2q)^2)
r = log2(q);
pre_cal = cell(r,x+1,m+x+1);
for i = 1:r % only store power of 2
    for j = 1:x+1
        for k = 1:m+x+1
            if k <= x-1 && j > x+1-k
                % to avoid the double storage cause some troubles
                pre_cal{i,j,k} = round(2^(i-1)*(q-1)^(j-1)*N_q(1,k));
            else
                pre_cal{i,j,k} = 2^(i-1)*(q-1)^(j-1)*N_q(1,k);
            end
%             pre_cal{i,j,k} = 2^(i-1)*(q-1)^(j-1)*N_q(1,k);
        end
    end
end
end




