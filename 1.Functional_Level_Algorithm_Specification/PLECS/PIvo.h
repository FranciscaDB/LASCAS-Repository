//******************************************************************
//      PVCTRL: UNSW 2018 - c.a.rojas@ieee.org
//      3L-FC: UTFSM 2025 - christian.rojas@usm.cl
//******************************************************************

//#ifndef pi_fun_H
//#define pi_fun_H

// Discrete PI
// Y(z)    Kpid*z + Kiid
// ---  = ---------------    by using ZOH
// X(z)    z - 1

// Discrete PI + anti-windup and saturation
extern double pivo_fun(double Vrk, double Vk, double Vmin, double Vmax, double Kpid, double Kiid)
{  
    // PI parameters
    static double Kp;
    static double Ki;
    static double KUi;
    static double KXi;
    
 	// PI variables
    static double xVrk;
    static double xVk;
    static double xVmax;
    static double xVmin;
    static double xXik[2];
    static double xUik[2];
    static double xVmk;
    
    // PI variables initialization
	xVrk = Vrk;
	xVk	= Vk;
	xVmax = Vmax;
	xVmin = Vmin;
	Kp = Kpid;
	Ki = Kiid;
	KUi = -(Kp + Ki)/(Kp*Kpid);
	KXi = -Ki/Kp;

	// PI implementation
	xXik[1] = xXik[0];
	xUik[1] = xUik[0];
	xXik[0] = KUi*xUik[1] + KXi*xXik[1];
    xUik[0] = Kp*(xVrk - xVk - xXik[0]);
	// Actuation limitation
    xUik[0] = ( xUik[0] > xVmax ) ? xVmax : ( xUik[0] < xVmin ) ? xVmin : xUik[0];
	// Actuation application
    xVmk = xUik[0];
	// return
    return xVmk;

}
//#endif


