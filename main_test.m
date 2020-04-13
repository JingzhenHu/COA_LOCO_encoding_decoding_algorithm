% main test page
function run_time_measure = main_test(m,x,q,pre_cal, pre_cal_half, power_of_2, pre_cal_log, all_co_loco)
run_time_measure = zeros(3,2);
tol = size(all_co_loco,1);
s_c = floor(log2(tol));
check = (1:2^s_c)-1;
%% original 
out = zeros(2^s_c,1);
tic
for i = 1:2^s_c
    out(i,:) = bi2de(CQA_LOCO_decoding_w_storage(all_co_loco(i,:),pre_cal,m,x,q,s_c));
end
ori_de = toc;
if isequal(out',check)
    run_time_measure(1,1) = ori_de;
else
    'original decoding sth wrong'
end

test = zeros(2^s_c,m);
tic
for i = 1:2^s_c
    test(i,:) = CQA_LOCO_encoding_w_storage(dec2bin(i-1,s_c),pre_cal,m,x,q);
end
ori_en = toc;
if isequal(test,all_co_loco(1:2^s_c,:))
    run_time_measure(1,2) = ori_en;
else
    'original encoding sth wrong'
end

%% half-storage
out_half = zeros(2^s_c,1);
tic
for i = 1:2^s_c
    out_half(i,:) = bi2de(store_half_decoding(all_co_loco(i,:),pre_cal_half,power_of_2,m,x,q,s_c));
end
half_de = toc;
if isequal(out_half',check)
    run_time_measure(2,1) = half_de;
else
    'half decoding sth wrong'
end

test_half = zeros(2^s_c,m);
tic
for i = 1:2^s_c 
    test_half(i,:) = store_half_encoding(dec2bin(i-1,s_c),pre_cal_half,power_of_2,m,x,q);
end
half_en = toc;
if isequal(test_half,all_co_loco(1:2^s_c,:))
    run_time_measure(2,2) = half_en;
else
    'half encoding sth wrong'
end

%% log-storage
out_log = zeros(2^s_c,1);
tic
for i = 1:2^s_c
    out_log(i,:) = bi2de(store_log_decoding(all_co_loco(i,:),pre_cal_log,m,x,q,s_c));
end
log_de = toc;
if isequal(out_log',check)
    run_time_measure(3,1) = log_de;
else
    'log decoding sth wrong'
end
test_log = zeros(2^s_c,m);
tic
for i = 1:2^s_c % tol-2
    test_log(i,:) = store_log_encoding(dec2bin(i-1,s_c),pre_cal_log,m,x,q);
end
log_en = toc;
if isequal(test_log,all_co_loco(1:2^s_c,:))
    run_time_measure(3,2) = log_en;
else
    'log encoding sth wrong'
end
end




