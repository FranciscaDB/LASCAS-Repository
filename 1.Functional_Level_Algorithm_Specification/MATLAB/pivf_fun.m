function out = pivf_fun(Vrk, Vk, Vmin, Vmax, Kpid, Kiid)
    % PI controller with persistent internal states

    % Persistent variables (retain value between function calls)
    persistent Kp Ki KUi KXi
    persistent xVrk xVk xVmax xVmin xXik xUik xVmk

    % Initialize states on first execution
    if isempty(xXik)
        xXik = zeros(1, 2);
        xUik = zeros(1, 2);
    end

    % Assign input parameters
    xVrk = Vrk;
    xVk = Vk;
    xVmax = Vmax;
    xVmin = Vmin;
    Kp = Kpid;
    Ki = Kiid;

    % Compute PI coefficients (recursive form)
    KUi = -(Kp + Ki) / (Kp * Kpid);
    KXi = -Ki / Kp;

    % Update internal states
    xXik(2) = xXik(1);
    xUik(2) = xUik(1);

    % Integrator update
    xXik(1) = KUi * xUik(2) + KXi * xXik(2);

    % PI output computation
    xUik(1) = Kp * (xVrk - xVk - xXik(1));

    % Output saturation
    xUik(1) = min(max(xUik(1), xVmin), xVmax);

    % Output assignment
    xVmk = xUik(1);
    out = xVmk;
end


