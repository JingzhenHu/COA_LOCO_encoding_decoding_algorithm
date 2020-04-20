
clear
q = [4,8,16,32]; % log2(the number of levels per Flash cell)
% alpha = a primitive root of x^(q-1) = 1
x = [1,2]; % for new device, lower; old device, higher
m = 20:5:50; % choose the smallest length to achieve a good rate based one table
tol_num = 300000; % the size of the random subset of LOCO codes in the tests 

idx1 = size(q,2);
idx2 = size(m,2);


table_encoding_1 = cell(idx1,idx2,3); % x=1 and the last 3 is for the three methods
table_encoding_2 = cell(idx1,idx2,3); % x=2
table_decoding_1 = cell(idx1,idx2,3); % x=1
table_decoding_2 = cell(idx1,idx2,3); % x=2

% x = 1
for i = 1:idx1
    for j = 1:idx2
        measure_1 = outer_test(m(j),1,q(i),tol_num);
        for k = 1:3
            table_encoding_1{i,j,k} = measure_1(k,1);
            table_decoding_1{i,j,k} = measure_1(k,2);
        end
    end
end

% x = 2
for i = 1:idx1
    for j = 1:idx2
        measure_2 = outer_test(m(j),2,q(i),tol_num);
        for k = 1:3
            table_encoding_2{i,j,k} = measure_2(k,1);
            table_decoding_2{i,j,k} = measure_2(k,2);
        end
    end
end




