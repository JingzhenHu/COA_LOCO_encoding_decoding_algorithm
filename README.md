# QA_LOCO_encoding_decoding_algorithm

Readme.txt

Three main implementations here are

1. Encoding & Decoding method in ArXiv, abs/2001.02325.by A. Hareedy, B. Dabak, and R. Calderbank. (2020) (Managing Device Lifecycle: Reconfigurable Constrained Codes for M/T/Q/P-LC Flash Memories) It has two versions: one (CQA_LOCO_encoding.m & CQA_LOCO_decoding.m) is the direct implementation without pre-storage, the other (CQA_LOCO_encoding_w_storage.m & CQA_LOCO_decoding_w_storage.m & CQA_LOCO_pre_cal.m) is using pre-storage to reduce everything in adder sizes.

2. The half-storage method for encoding & decoding the CQA-LOCO codes(store_half_encoding.m & store_half_decoding.m & store_half_pre_cal.m)

3. The least-storage method for encoding & decoding the CQA-LOCO codes(store_least_encoding.m & store_least_decoding.m & store_log_pre_cal.m)

The outer_test.m and wrapper.m tests and measures the running time of the encodong and decoding algorithms for the original method, half-storage method, and the least storage method for a subset (with given size) of LOCO codes of given m,q,x (m is the number of symbols; q is the log2(the number of levels per Flash cell); x describes the constraints).





