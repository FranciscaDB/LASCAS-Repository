% Load reference data
data = readmatrix('Gold_Ref_Sim.csv');

% Extract input and reference signals
Vfcref = data(2, :);
Vfc     = data(3, :);
Voutref = data(4, :);
Vout    = data(5, :);

D1_ref  = data(6, :);
D2_ref  = data(7, :);
ui_ref  = data(8, :);
uv_ref  = data(9, :);

N = size(data, 2);  % Number of samples

% Initialize error vectors
err_D1 = zeros(1, N);
err_D2 = zeros(1, N);
err_ui = zeros(1, N);
err_uv = zeros(1, N);

% Main test loop
for k = 1:N
    [D1, D2, ui, uv] = fcc(Vfcref(k), Vfc(k), Voutref(k), Vout(k));

    err_D1(k) = abs(D1 - D1_ref(k));
    err_D2(k) = abs(D2 - D2_ref(k));
    err_ui(k) = abs(ui - ui_ref(k));
    err_uv(k) = abs(uv - uv_ref(k));

    fprintf('Iter %3d | ΔD1 = %.8f | ΔD2 = %.8f | Δui = %.10f | Δuv = %.10f\n', ...
            k, err_D1(k), err_D2(k), err_ui(k), err_uv(k));
end

% Display maximum errors
fprintf('\nMaximum Errors:\n');
fprintf('Max ΔD1: %.6f\n', max(err_D1));
fprintf('Max ΔD2: %.6f\n', max(err_D2));
fprintf('Max Δui: %.6f\n', max(err_ui));
fprintf('Max Δuv: %.6f\n', max(err_uv));

