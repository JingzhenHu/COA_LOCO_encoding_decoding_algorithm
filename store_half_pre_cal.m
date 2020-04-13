% pre_calculation storage for 1/2-storage encoding and decoding

function [pre_cal,power_of_2] = store_half_pre_cal(m,x,q)

% compute all the cardinalities
N_q = zeros(1,m+x+1); % i = -x,-x+1,...,0,1,...,m
for i = 1:x
    N_q(1,i) = (q-1)^(-(x-i+1)); % i = -x,-x+1,..,-1
end
N_q(1,x+1) = 1; % i = 0
N_q(1,x+2) = q; % i = 1

% use the recursive relation to compute the rest of cardinality
for i = x+3:m+x+1
    N_q(1,i) = q*N_q(1,i-1) - (q-1)*N_q(1,i-2) + (q-1)^(x+1)*N_q(1,i-x-2);
end

% store all the possible data needed for the run-time in a cell
% with O((qx/2+1)log2q)

pre_cal = cell(q/2,x+1,m+x+1);
for i = 1:2:q-1 % only odd of them
    for j = 1:x+1
        for k = 1:m+x+1
            if k <= x-1 && j > x+1-k
                % to avoid the double storage cause some troubles
                pre_cal{(i+1)/2,j,k} = round(i*(q-1)^(j-1)*N_q(1,k));
            else
                pre_cal{(i+1)/2,j,k} = i*(q-1)^(j-1)*N_q(1,k);
            end
        end
    end
end

power_of_2 = 2.^(0:log2(q)-1);

end




