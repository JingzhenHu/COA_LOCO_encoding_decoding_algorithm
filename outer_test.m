% test for randomly pick up ranks of symbols between 20-50 for encoding and
% feed the results back to decoding to see whether they match and measure
% the running time for each methods

clear
q = 32; % log2(the number of levels per Flash cell)
% alpha = a primitive root of x^(q-1) = 1
x = 1; % for new device, lower; old device, higher
m = 50; % choose the smallest length to achieve a good rate based one table

run_time_measure = zeros(3,2);

% compute all the cardinalities
N_q = cardinality(m,x,q);

% pre_calculation storage for encoding and decoding
pre_cal = CQA_LOCO_pre_cal(N_q,m,x,q);
pre_cal_half = store_half_pre_cal(N_q,m,x,q); % it is a subset of pre_cal
pre_cal_least = store_least_pre_cal(N_q,m,x,q); % the least storage

tol = N_q(1,m+x+1);
s_c = floor(log2(tol-2));
% randomly choose a subset of loco_index with fixed size
test_num = 30000;
check = zeros(test_num,1);
if s_c < 53
    check = randi(2^s_c,test_num,1)-1;
else
    check = randi(2^52,test_num,1)-1;
end
bin_string = dec2bin(check,s_c);
%% original 
test = zeros(test_num,m);
tic
for i = 1:test_num
    test(i,:) = CQA_LOCO_encoding_w_storage(bin_string(i,:),pre_cal,m,x,q);
end
ori_en = toc;
run_time_measure(1,1) = ori_en;

out = zeros(test_num,1);
tic
for i = 1:test_num
    out(i,:) = bi2de(CQA_LOCO_decoding_w_storage(test(i,:),pre_cal,m,x,q,s_c));
end
ori_de = toc;
if isequal(out,check)
    run_time_measure(1,2) = ori_de;
else
    'original encoding/decoding sth wrong'
end


%% half-storage
test_half = zeros(test_num,m);
tic
for i = 1:test_num 
    test_half(i,:) = store_half_encoding(bin_string(i,:),pre_cal_half,m,x,q);
end
half_en = toc;
run_time_measure(2,1) = half_en;

out_half = zeros(test_num,1);
tic
for i = 1:test_num
    out_half(i,:) = bi2de(store_half_decoding(test_half(i,:),pre_cal_half,m,x,q,s_c));
end
half_de = toc;
if isequal(out_half,check)
    run_time_measure(2,2) = half_de;
else
    'half encoding/decoding sth wrong'
end


%% least-storage
test_least = zeros(test_num,m);
tic
for i = 1:test_num
    test_least(i,:) = store_least_encoding(bin_string(i,:),pre_cal_least,m,x,q);
end
least_en = toc;
run_time_measure(3,1) = least_en;

out_least = zeros(test_num,1);
tic
for i = 1:test_num
    out_least(i,:) = bi2de(store_least_decoding(test_least(i,:),pre_cal_least,m,x,q,s_c));
end
least_de = toc;
if isequal(out_least,check)
    run_time_measure(3,2) = least_de;
else
    'least encoding/decoding sth wrong'
end






