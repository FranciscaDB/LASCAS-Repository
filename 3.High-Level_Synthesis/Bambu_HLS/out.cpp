#include "ap_fixed.h"

typedef ap_fixed<22, 8, AP_RND, AP_SAT> dec_t;
typedef ap_ufixed<7, 7, AP_RND, AP_SAT> int_t;
typedef ap_ufixed<7, 7, AP_TRN_ZERO, AP_SAT> int_d;
    

void out(dec_t ui_22, dec_t uv_22, int_d*D1, int_d*D2, int_t*ui, int_t*uv)
{  
    int_d MAX_DUTY_CYCLE = 127;
    int_d D1_aux, D2_aux;
    
    D1_aux = ui_22 + uv_22;
    D2_aux = ui_22 - uv_22;

    if (D1_aux > MAX_DUTY_CYCLE) D1_aux = MAX_DUTY_CYCLE;
    if (D2_aux > MAX_DUTY_CYCLE) D2_aux = MAX_DUTY_CYCLE;

    *D1 = D1_aux;
    *D2 = D2_aux;
    *ui = (int_t)ui_22;
    *uv = (int_t)uv_22;
}