function [D1, D2, ui, uv] = fcc(Vfcref, Vfc, Voutref, Vout)
    Kpv =  3.214624;
    Kiv = -1.4105;335;
    Kpc =  12.58407884;
    Kic = -12.410690825;
    MAX_DUTY_CYCLE = (127);
    gain = 4/65535;
    
    ui_aux = pivo_fun(Voutref*gain, Vout*gain, 0.0, 127.0, Kpv, Kiv);
    uv_aux = pivf_fun(Vfcref*gain , Vfc*gain , -38.0, 38.0, Kpc, Kic);


    D1_aux = fix((ui_aux) + (uv_aux));
    D2_aux = fix((ui_aux) - (uv_aux));

    D1 = (min(D1_aux, MAX_DUTY_CYCLE));
    D2 = (min(D2_aux, MAX_DUTY_CYCLE));

    ui = (ui_aux);
    uv = (uv_aux);
end
