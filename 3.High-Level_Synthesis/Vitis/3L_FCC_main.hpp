#ifndef __PI_CONTROLLER_H
#define __PI_CONTROLLER_H

#include "data_types.hpp"

void fcc(
    int_z Vfcref, int_z Vfc, int_z Voutref, int_z Vout,
    int_d *D1, int_d *D2, int_t *ui, int_t *uv 
);

#endif