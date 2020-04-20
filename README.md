Readme.txt

Three main implementations here are

1. Encoding & Decoding method in ArXiv, abs/2001.02325.by A. Hareedy, B. Dabak, and R. Calderbank. (2020) (Managing Device Lifecycle: Reconfigurable Constrained Codes for M/T/Q/P-LC Flash Memories) It has two versions: one (CQA_LOCO_encoding.m & CQA_LOCO_decoding.m) is the direct implementation without pre-storage, the other (CQA_LOCO_encoding_w_storage.m & CQA_LOCO_decoding_w_storage.m & CQA_LOCO_pre_cal.m) is using pre-storage to reduce everything in adder sizes.

2. The half-storage method for encoding & decoding the CQA-LOCO codes(store_half_encoding.m & store_half_decoding.m & store_half_pre_cal.m)

3. The least-storage method for encoding & decoding the CQA-LOCO codes(store_least_encoding.m & store_least_decoding.m & store_log_pre_cal.m)

The outer_test.m and wrapper.m tests and measures the running time of the encodong and decoding algorithms for the original method, half-storage method, and the least storage method for a subset (with given size) of LOCO codes of given m,q,x (m is the number of symbols; q is the log2(the number of levels per Flash cell); x describes the constraints).

-----------------------------------------------------------------------
For all the encoding algorithms with briding:
their inputs are 
bin_mess: a specific binary string,
stor_data: the pre-calculation storage in a cell with the format {index for a_i, index for gamma, index for cardinality}
and m,x,q, which are mentioned above.

and their output is  
encoded_CQA_LOCO: the loco code corresponding to the input binary string

------------------------------------------------------------------------
For all the decoding algorithms:
their inputs are 
CQA_LOCO: a given LOCO code
stor_data: the pre-calculation storage in a cell with the format {index for a_i, index for gamma, index for cardinality}
and m,x,q,s_c = log2(N_q(m,x)-2).

and their output is
bin_mess: the binary string that is associated to the input LOCO code
------------------------------------------------------------------------
outer_test.m

The function is called by wrapper.m, of which purpose is to check the correctness of the implementations and measure the running time of both encoding and decoding algorithms of the original method, half-storage method, and the least storage method.

It feeds in by m,x,q,and 
test_num: the fixed size of the subset of idices of loco code that is generated randomly

Output: the measure for running time 
run_time_measure: it is a 3*2 matrix with the first column encoding time and the secodn column decoding time.
run_time_measure(1,1): running time of encoding algorithm for the original method,
run_time_measure(2,1): running time of encoding algorithm for the half-storage method, 
run_time_measure(3,1): running time of encoding algorithm for the least storage method,
run_time_measure(1,2): running time of decoding algorithm for the original method,
run_time_measure(2,2): running time of decoding algorithm for the half-storage method, 
run_time_measure(3,2): running time of decoding algorithm for the least storage method.

------------------------------------------------------------------------
wrapper.m

It is designed for running the outer_test.m multiple times with different values of m,x,q and the size of the tested subset of indices.







