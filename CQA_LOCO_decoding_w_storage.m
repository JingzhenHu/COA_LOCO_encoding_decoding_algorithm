% Algorithm 2 Decoding CQA-LOCO Codes
% by ?ArXiv, abs/2001.02325

function bin_mess = CQA_LOCO_decoding_w_storage(CQA_LOCO,stor_data,m,x,q,s_c) 

% s_c = floor(log2(stor_data{1,1,m+2}-2)); % the length in bits

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
%             a(i)
%             index
%             N_q(1,index)
            rank = rank +stor_data{a(i),gamma(i)+1,index}; % a(i)*(q-1)^gamma(i)*N_q(1,index);
        end
%         i = i - 1;
    end
    bin_mess(sta:sta+s_c-1) = de2bi(rank - 1,s_c);
    sta = sta + s_c;
    pre = pre + m + x;
end

end

