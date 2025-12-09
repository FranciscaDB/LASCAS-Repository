#include "ap_fixed.h"

typedef ap_fixed<22, 8, AP_RND, AP_SAT> dec_t;
typedef ap_fixed<32, 16, AP_RND, AP_SAT> prod_t;
typedef ap_ufixed<16, 16, AP_RND, AP_SAT> int_z;
    

void pivo_fun(int_z Vrk, int_z Vk, dec_t pivo_x1, dec_t pivo_u1, dec_t*pivo_x0, dec_t*pivo_u0)
{  
    dec_t KUi = -0.174601;
    dec_t KXi = 0.438725;
    dec_t Kpid =  3.214624;
    dec_t Vmax = 127.0;
    dec_t Vmin = 0.0;
    dec_t gain = 4.0 * 0.0000152588;

    dec_t Vrkg;
    dec_t Vkg;
    prod_t tmp;

    tmp = (prod_t)Vrk * (prod_t)gain;
    Vrkg = (dec_t)tmp;

    tmp = (prod_t)Vk * (prod_t)gain;
    Vkg = (dec_t)tmp;


    prod_t a, b;
    dec_t pivo_x0_tmp;
    dec_t pivo_u0_tmp;
    a = (prod_t)KUi * (prod_t)pivo_u1;
    b = (prod_t)KXi*(prod_t)pivo_x1;
    pivo_x0_tmp = (dec_t)a + (dec_t)b;//para ahcer calculos
    //pivo_x0 = (dec_t)a + (dec_t)b;//salida
    a = (prod_t)Vrkg - (prod_t)Vkg - (prod_t)pivo_x0_tmp;
    b = (prod_t)Kpid * (prod_t)a;
    pivo_u0_tmp = (dec_t)b;//falta limitar y es salida


    // Actuation limitation
    pivo_u0_tmp = ( pivo_u0_tmp > Vmax ) ? Vmax : ( pivo_u0_tmp < Vmin ) ? Vmin : pivo_u0_tmp; //ESTA ES LA SALIDA

    // Actuation application
    *pivo_u0 = pivo_u0_tmp;
    *pivo_x0 = pivo_x0_tmp;
}