
function bin_mess = store_half_decoding(CQA_LOCO,stor_data,power_of_2,m,x,q,s_c) 

% s_c = floor(log2(stor_data{1,1,m+2}-2)); % the length in bits

tol_len = size(CQA_LOCO,2); 
% split into pieces with each piece equal or less than (m + x)
quto = ceil(tol_len/(m+x));
pre = 1;
bin_mess = zeros(1,s_c*quto);
sta = 1;
r = size(power_of_2,2);
v = zeros(1,q-1);
v(1:2:q-1) = 1:power_of_2(r);
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
            if mod(a(i),2) == 1
                rank = rank + stor_data{v(a(i)),gamma(i)+1,index}; % a(i)*(q-1)^gamma(i)*N_q(1,index);
            else
                rank = rank + stor_data{v(a(i)-1),gamma(i)+1,index} + stor_data{1,gamma(i)+1,index};
            end
        end
    end
    bin_mess(sta:sta+s_c-1) = de2bi(rank - 1,s_c);
    sta = sta + s_c;
    pre = pre + m + x;
end

end