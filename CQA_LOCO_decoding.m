% Algorithm 1 Decoding CQA-LOCO Codes

function bin_mess = CQA_LOCO_decoding(CQA_LOCO,q,m,x) % s_c

% compute all the cardinalities
N_q = zeros(1,m+x+1); % i = -1,0,1,...,m
for i = 1:x
    N_q(1,i) = (q-1)^(-(x-i+1)); % i = -x,-x+1,..,-1
end
N_q(1,x+1) = 1; % i = 0
N_q(1,x+2) = q; % i = 1

% use the recursive relation to compute the rest of cardinality
for i = x+3:m+x+1
    N_q(1,i) = q*N_q(1,i-1) - (q-1)*N_q(1,i-2) + (q-1)^(x+1)*N_q(1,i-x-2);
end

s_c = floor(log2(N_q(1,m+2)-2)); % the length in bits

tol_len = size(CQA_LOCO,2); 
% split into pieces with each piece equal or less than (m + x)
quto = ceil(tol_len/(m+x));
pre = 1;
bin_mess = zeros(1,s_c*quto);
sta = 1;
for j = 1:quto
    rank = 0;
    a = CQA_LOCO(pre:pre+m-1); 
    a = flip(a);
    gamma = zeros(1,m);
%     i = m;
%     index = i + x;
%     while i > 0 
    for i = 1:m
        index = i + x;
        for k = 1:x 
            if i+k <= m && a(1,i+k) == q-1
                gamma(i) = x - k + 1;
                index = index - gamma(i);
                break
            end
        end
        
        if a(i) ~= 0
            a(i)
            index
            N_q(1,index)
            rank = rank + a(i)*(q-1)^gamma(i)*N_q(1,index);
        end
%         i = i - 1;
    end
    bin_mess(sta:sta+s_c-1) = de2bi(rank - 1,s_c);
    sta = sta + s_c;
    pre = pre + m + x;
end

end

