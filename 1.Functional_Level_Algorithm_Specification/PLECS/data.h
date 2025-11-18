//******************************************************************
//      VOC: UNSW 2018 - c.a.rojas@ieee.org
//******************************************************************

// Measurements 
double Vfcref = 0.0, Vfc = 0.0, Vout = 0.0, Voutref = 0.0;
double ILk = 0.0, ILref = 0.0;
int CCCV = 0.0;

// Actuations
double dV = 0.0, uv = 0.0;
double m = 0.0, ui = 0.0;

// PI Voltage Controller vector
#include <PIvo.h>
#include <PIvf.h>

// Controller Parameters
// External capacitor
double Kpv =  0.025312;
double Kiv = -0.011105;
double Kpc =  0.099087235;
double Kic = -0.097721975;

/*
// Internal capacitor
double Kpv =  0.025312;
double Kiv = -0.011105;
double Kpc =  0.00034278496032795589781;
double Kic = -0.00033510460200346020598;
*/