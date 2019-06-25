; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+sse4.1 | FileCheck %s --check-prefix=SSE
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx | FileCheck %s --check-prefix=AVX
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx2 | FileCheck %s --check-prefix=AVX --check-prefix=AVX2
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512vl | FileCheck %s --check-prefix=AVX --check-prefix=AVX512VL
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512vl,+avx512dq | FileCheck %s --check-prefix=AVX --check-prefix=AVX512DQVL

define <2 x i64> @combine_shuffle_sext_pmuldq(<4 x i32> %a0, <4 x i32> %a1) {
; SSE-LABEL: combine_shuffle_sext_pmuldq:
; SSE:       # %bb.0:
; SSE-NEXT:    pmuldq %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: combine_shuffle_sext_pmuldq:
; AVX:       # %bb.0:
; AVX-NEXT:    vpmuldq %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %1 = shufflevector <4 x i32> %a0, <4 x i32> undef, <2 x i32> <i32 0, i32 2>
  %2 = shufflevector <4 x i32> %a1, <4 x i32> undef, <2 x i32> <i32 0, i32 2>
  %3 = sext <2 x i32> %1 to <2 x i64>
  %4 = sext <2 x i32> %2 to <2 x i64>
  %5 = mul nuw <2 x i64> %3, %4
  ret <2 x i64> %5
}

define <2 x i64> @combine_shuffle_zext_pmuludq(<4 x i32> %a0, <4 x i32> %a1) {
; SSE-LABEL: combine_shuffle_zext_pmuludq:
; SSE:       # %bb.0:
; SSE-NEXT:    pmuludq %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: combine_shuffle_zext_pmuludq:
; AVX:       # %bb.0:
; AVX-NEXT:    vpmuludq %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %1 = shufflevector <4 x i32> %a0, <4 x i32> undef, <2 x i32> <i32 0, i32 2>
  %2 = shufflevector <4 x i32> %a1, <4 x i32> undef, <2 x i32> <i32 0, i32 2>
  %3 = zext <2 x i32> %1 to <2 x i64>
  %4 = zext <2 x i32> %2 to <2 x i64>
  %5 = mul nuw <2 x i64> %3, %4
  ret <2 x i64> %5
}

define <2 x i64> @combine_shuffle_zero_pmuludq(<4 x i32> %a0, <4 x i32> %a1) {
; SSE-LABEL: combine_shuffle_zero_pmuludq:
; SSE:       # %bb.0:
; SSE-NEXT:    pmuludq %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: combine_shuffle_zero_pmuludq:
; AVX:       # %bb.0:
; AVX-NEXT:    vpmuludq %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %1 = shufflevector <4 x i32> %a0, <4 x i32> zeroinitializer, <4 x i32> <i32 0, i32 5, i32 2, i32 7>
  %2 = shufflevector <4 x i32> %a1, <4 x i32> zeroinitializer, <4 x i32> <i32 0, i32 5, i32 2, i32 7>
  %3 = bitcast <4 x i32> %1 to <2 x i64>
  %4 = bitcast <4 x i32> %2 to <2 x i64>
  %5 = mul <2 x i64> %3, %4
  ret <2 x i64> %5
}

define <4 x i64> @combine_shuffle_zero_pmuludq_256(<8 x i32> %a0, <8 x i32> %a1) {
; SSE-LABEL: combine_shuffle_zero_pmuludq_256:
; SSE:       # %bb.0:
; SSE-NEXT:    pmuludq %xmm2, %xmm0
; SSE-NEXT:    pmuludq %xmm3, %xmm1
; SSE-NEXT:    retq
;
; AVX2-LABEL: combine_shuffle_zero_pmuludq_256:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpmuludq %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    retq
;
; AVX512VL-LABEL: combine_shuffle_zero_pmuludq_256:
; AVX512VL:       # %bb.0:
; AVX512VL-NEXT:    vpmuludq %ymm1, %ymm0, %ymm0
; AVX512VL-NEXT:    retq
;
; AVX512DQVL-LABEL: combine_shuffle_zero_pmuludq_256:
; AVX512DQVL:       # %bb.0:
; AVX512DQVL-NEXT:    vpmuludq %ymm1, %ymm0, %ymm0
; AVX512DQVL-NEXT:    retq
  %1 = shufflevector <8 x i32> %a0, <8 x i32> zeroinitializer, <8 x i32> <i32 0, i32 9, i32 2, i32 11, i32 4, i32 13, i32 6, i32 15>
  %2 = shufflevector <8 x i32> %a1, <8 x i32> zeroinitializer, <8 x i32> <i32 0, i32 9, i32 2, i32 11, i32 4, i32 13, i32 6, i32 15>
  %3 = bitcast <8 x i32> %1 to <4 x i64>
  %4 = bitcast <8 x i32> %2 to <4 x i64>
  %5 = mul <4 x i64> %3, %4
  ret <4 x i64> %5
}

define <8 x i64> @combine_zext_pmuludq_256(<8 x i32> %a) {
; SSE-LABEL: combine_zext_pmuludq_256:
; SSE:       # %bb.0:
; SSE-NEXT:    pshufd {{.*#+}} xmm3 = xmm1[2,2,3,3]
; SSE-NEXT:    pmovzxdq {{.*#+}} xmm2 = xmm1[0],zero,xmm1[1],zero
; SSE-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[2,2,3,3]
; SSE-NEXT:    pmovzxdq {{.*#+}} xmm0 = xmm0[0],zero,xmm0[1],zero
; SSE-NEXT:    movdqa {{.*#+}} xmm4 = [715827883,715827883]
; SSE-NEXT:    pmuludq %xmm4, %xmm0
; SSE-NEXT:    pmuludq %xmm4, %xmm1
; SSE-NEXT:    pmuludq %xmm4, %xmm2
; SSE-NEXT:    pmuludq %xmm4, %xmm3
; SSE-NEXT:    retq
;
; AVX2-LABEL: combine_zext_pmuludq_256:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vextracti128 $1, %ymm0, %xmm1
; AVX2-NEXT:    vpmovzxdq {{.*#+}} ymm1 = xmm1[0],zero,xmm1[1],zero,xmm1[2],zero,xmm1[3],zero
; AVX2-NEXT:    vpmovzxdq {{.*#+}} ymm0 = xmm0[0],zero,xmm0[1],zero,xmm0[2],zero,xmm0[3],zero
; AVX2-NEXT:    vpbroadcastq {{.*#+}} ymm2 = [715827883,715827883,715827883,715827883]
; AVX2-NEXT:    vpmuludq %ymm2, %ymm0, %ymm0
; AVX2-NEXT:    vpmuludq %ymm2, %ymm1, %ymm1
; AVX2-NEXT:    retq
;
; AVX512VL-LABEL: combine_zext_pmuludq_256:
; AVX512VL:       # %bb.0:
; AVX512VL-NEXT:    vpmovzxdq {{.*#+}} zmm0 = ymm0[0],zero,ymm0[1],zero,ymm0[2],zero,ymm0[3],zero,ymm0[4],zero,ymm0[5],zero,ymm0[6],zero,ymm0[7],zero
; AVX512VL-NEXT:    vpmuludq {{.*}}(%rip){1to8}, %zmm0, %zmm0
; AVX512VL-NEXT:    retq
;
; AVX512DQVL-LABEL: combine_zext_pmuludq_256:
; AVX512DQVL:       # %bb.0:
; AVX512DQVL-NEXT:    vpmovzxdq {{.*#+}} zmm0 = ymm0[0],zero,ymm0[1],zero,ymm0[2],zero,ymm0[3],zero,ymm0[4],zero,ymm0[5],zero,ymm0[6],zero,ymm0[7],zero
; AVX512DQVL-NEXT:    vpmuludq {{.*}}(%rip){1to8}, %zmm0, %zmm0
; AVX512DQVL-NEXT:    retq
  %1 = zext <8 x i32> %a to <8 x i64>
  %2 = mul nuw nsw <8 x i64> %1, <i64 715827883, i64 715827883, i64 715827883, i64 715827883, i64 715827883, i64 715827883, i64 715827883, i64 715827883>
  ret <8 x i64> %2
}

define void @PR39398(i32 %a0) {
; SSE-LABEL: PR39398:
; SSE:       # %bb.0: # %bb
; SSE-NEXT:    .p2align 4, 0x90
; SSE-NEXT:  .LBB5_1: # %bb10
; SSE-NEXT:    # =>This Inner Loop Header: Depth=1
; SSE-NEXT:    cmpl $232, %edi
; SSE-NEXT:    jne .LBB5_1
; SSE-NEXT:  # %bb.2: # %bb34
; SSE-NEXT:    retq
;
; AVX-LABEL: PR39398:
; AVX:       # %bb.0: # %bb
; AVX-NEXT:    .p2align 4, 0x90
; AVX-NEXT:  .LBB5_1: # %bb10
; AVX-NEXT:    # =>This Inner Loop Header: Depth=1
; AVX-NEXT:    cmpl $232, %edi
; AVX-NEXT:    jne .LBB5_1
; AVX-NEXT:  # %bb.2: # %bb34
; AVX-NEXT:    retq
bb:
  %tmp9 = shufflevector <4 x i64> undef, <4 x i64> undef, <4 x i32> zeroinitializer
  br label %bb10

bb10:                                             ; preds = %bb10, %bb
  %tmp12 = phi <4 x i32> [ <i32 9, i32 8, i32 7, i32 6>, %bb ], [ zeroinitializer, %bb10 ]
  %tmp16 = add <4 x i32> %tmp12, <i32 -4, i32 -4, i32 -4, i32 -4>
  %tmp18 = zext <4 x i32> %tmp12 to <4 x i64>
  %tmp19 = zext <4 x i32> %tmp16 to <4 x i64>
  %tmp20 = xor <4 x i64> %tmp18, <i64 -1, i64 -1, i64 -1, i64 -1>
  %tmp21 = xor <4 x i64> %tmp19, <i64 -1, i64 -1, i64 -1, i64 -1>
  %tmp24 = mul <4 x i64> %tmp9, %tmp20
  %tmp25 = mul <4 x i64> %tmp9, %tmp21
  %tmp26 = select <4 x i1> undef, <4 x i64> zeroinitializer, <4 x i64> %tmp24
  %tmp27 = select <4 x i1> undef, <4 x i64> zeroinitializer, <4 x i64> %tmp25
  %tmp28 = add <4 x i64> zeroinitializer, %tmp26
  %tmp29 = add <4 x i64> zeroinitializer, %tmp27
  %tmp33 = icmp eq i32 %a0, 232
  br i1 %tmp33, label %bb34, label %bb10

bb34:                                             ; preds = %bb10
  %tmp35 = add <4 x i64> %tmp29, %tmp28
  ret void
}
