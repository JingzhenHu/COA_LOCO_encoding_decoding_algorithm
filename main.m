
clear
q = 8; % log2(the number of levels per Flash cell)
% alpha = a primitive root of x^(q-1) = 1
x = 1; % for new device, lower; old device, higher
m = 6; % choose the smallest length to achieve a good rate based one table

% pre_calculation storage for encoding and decoding
pre_cal = CQA_LOCO_pre_cal(m,x,q);
[pre_cal_half,power_of_2] = store_half_pre_cal(m,x,q); % it is a subset of pre_cal
pre_cal_log = store_log_pre_cal(m,x,q); % it is also a subset of pre_cal

% brute_forth to generate all the CQA_LOCO
all_co_loco = generatinng_co_loco(m,x,q);
tol = size(all_co_loco,1);
% isequal(tol,pre_cal{1,1,1+m+x})
all_co_loco([1,tol],:) = []; % remove the all-zeros and all-ones vector

times = 30;
measure = zeros(3,2);
for i = 1:times
    measure = measure + main_test(m,x,q, pre_cal,pre_cal_half,power_of_2,pre_cal_log,all_co_loco);
end

measure = measure/times;