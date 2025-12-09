#ifndef datatype_H
#define datatype_H

#include <ap_fixed.h>
typedef ap_fixed<22,8,AP_RND,AP_SAT> dec_t;

typedef ap_ufixed<7,7,AP_RND,AP_SAT> int_t;

typedef ap_ufixed<16,16,AP_RND,AP_SAT> int_z;

typedef ap_ufixed<7,7,AP_TRN_ZERO,AP_SAT> int_d;

#endif

