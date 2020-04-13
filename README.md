# QA_LOCO_encoding_decoding_algorithm

Three main implementations here are 
1. Encoding & Decoding method in ArXiv, abs/2001.02325.by A. Hareedy, B. Dabak, and R. Calderbank. (2020)
(Managing Device Lifecycle: Reconfigurable Constrained Codes for M/T/Q/P-LC Flash Memories)
It has two versions: one (CQA_LOCO_encoding.m & CQA_LOCO_decoding.m) is the direct implementation without pre-storage, 
                     the other (CQA_LOCO_encoding_w_storage.m & CQA_LOCO_decoding_w_storage.m & CQA_LOCO_pre_cal.m) is using pre-storage to reduce everything in adder sizes.
2. The half-storage method for encoding & decoding the CQA-LOCO codes(store_half_encoding.m & store_half_decoding.m & store_half_pre_cal.m)

3. The log-storage method for encoding & decoding the CQA-LOCO codes(store_log_encoding.m & store_log_decoding.m & store_log_pre_cal.m)

The main_test.m and main.m are the checking files for the three implementations, in which it uses the generatinng_co_loco.m (brute-forth) to store all the LOCO codewords for certain m,q,x.

