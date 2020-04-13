% Algorithm 1 Encoding CQA-LOCO Codes with pre_storage

function encoded_CQA_LOCO = store_half_encoding(bin_mess,stor_data,power_of_2,m,x,q)

s_c = floor(log2(stor_data{1,1,m+x+1}-2)); % the length in bits

tol_len = size(bin_mess,2); 
% split into pieces with each piece equal or less than s_c
quto = ceil(tol_len/s_c);
pre = 1;
post = s_c;
% -x in size as the no bridging for the first codeword
encoded_CQA_LOCO = zeros(1,(m+x)*quto-x); 
s_ta = 1;
e_nd = m;

% it use the L-function in paper to represent the CQA_LOCO codewords
% {0,1,alpha,alpha^2,...,alpha^(q-2)} = {0,1,2,3,...,q-1} 
for j = 1:quto
    rank = bin2dec(bin_mess(pre:post)) + 1; %+ 1;
    pre = pre + s_c;
    if j == quto-1
        post = tol_len;
    else
        post = post + s_c;
    end
    res = rank; % initialize residual to be the rank
    a = zeros(1,m); % initialize the current CQA-LOCO words flash charge level
    gamma = zeros(1,m);
    i = m;
    while i > 0 
        for k = 1:x
            if i+k <= m && a(1,i+k) == q-1
                gamma(i) = x - k + 1;
                break
            end
        end
        index = i - gamma(i) + x;
        r = size(power_of_2,2);
        
        if res >= stor_data{power_of_2(r),gamma(i)+1,index} % (q-1)^(gamma(i)+1)*N_q(1,index)
            a(i) = q-1;
            res = res - stor_data{power_of_2(r),gamma(i)+1,index}; % (q-1)^(gamma(i)+1)*N_q(1,index);
        else
            L = 0;
            R = stor_data{power_of_2(r),gamma(i)+1,index};
            l = r-1;
            trace = 0;
            while l > 0 %(R-L) > (stor_data{1,gamma(i)+1,index} + stor_data{1,gamma(i)+1,index})
                % l>0
                mid = power_of_2(l)+trace;
                T = stor_data{mid,gamma(i)+1,index};
                if res >= T
                    L = T;
                    trace = trace + power_of_2(l);
                else
                    R = T;
                end
                l = l-1;
            end
            if L ~= 0
                if (res - L) < (R - res)
                    a(i) = trace + trace - 1;%stor_data{trace,1,1+x};
                    res = res - L; %a(i)*(q-1)^gamma(i)*N_q(1,index);
                else
                    a(i) = trace + trace; %stor_data{trace,1,1+x}+1;
                    res = res - L - stor_data{1,gamma(i)+1,index}; %l*(q-1)^gamma(i)*N_q(1,index);
                end
            end
        end
        if j ~= 1 && i == m
            if encoded_CQA_LOCO(e_nd) == q-1 && a(i) == q-1
                encoded_CQA_LOCO(1,s_ta:s_ta + x - 1) = (q-1)*ones(1,x); 
            else
                encoded_CQA_LOCO(1,s_ta:s_ta + x - 1) = zeros(1,x);
            end
            s_ta = s_ta + x;
            e_nd = e_nd + x;
        end
        encoded_CQA_LOCO(s_ta:e_nd) = flip(a); % flip since the order is reversed
        i = i - 1;
    end
    s_ta = s_ta + m;
    e_nd = e_nd + m;
end

