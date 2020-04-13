% brute-force generating all the co-loco for any input m, x, q
%

function co_loco = generatinng_co_loco(m,x,q)
% q>=2, m>=1, m-2>x>=1
% compute the cardinality at first
N_q = zeros(1,m+x+1); % i = -x,-x+1,...,-1,0,1,...,m
for i = 1:x
    N_q(1,i) = (q-1)^(-(x-i+1)); % i = -x,-x+1,..,-1
end
N_q(1,x+1) = 1; % i = 0
N_q(1,x+2) = q; % i = 1

% use the recursive relation to compute the needed of cardinality
for i = x+3:m+x+1
    N_q(1,i) = q*N_q(1,i-1) - (q-1)*N_q(1,i-2) + (q-1)^(x+1)*N_q(1,i-x-2);
end

% define all the constraints
% note that the bijective mapping is {0,1,alpha,alpha^2,...,alpha^(q-2)} = {0,1,2,3,...,q-1} 
constraint = {};
if m >= 3
    trace = 1;
    for i=1:x
        comb = permn(0:q-2,i); 
        sz = size(comb,1);
        side = (q-1)*ones(sz,1);
        comb = [side, comb, side];
        for k = 1:size(comb,1)
            constraint{trace,1} = comb(k,:);
            trace = trace + 1;
        end
    end

end
% begin generating 
co_loco = permn(0:q-1,m); 
% size(co_loco,1)
con = size(constraint,1);
elim_idx = [];
if con ~= 0
    for j = 1:size(co_loco,1)
        for k=1:con
            if pattern(co_loco(j,:),constraint{k,1})
                elim_idx = [elim_idx, j];
                break
            end
        end
    end
end

co_loco(elim_idx,:) = [];
% check the cardinality
num = size(co_loco,1);
% N_q(1,m+x+1) == num

end


function iscontains = pattern(B, A)
     sz = length(B) - length(A) + 1;
     iscontains = 0;
     for i=1:sz
         iscontains = all(B(i:i-1+length(A)) == A);
         if iscontains == 1
             break;
         end
     end
 end

