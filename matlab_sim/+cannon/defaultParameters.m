function params = defaultParameters()
%DEFAULTPARAMETERS Return placeholder parameters for the cannon model.
%   Replace these values with the actual inertia, stiffness, damping and
%   firing-force parameters after they are identified from the reference.

params.model.name = "Three-DOF placeholder cannon recoil model";
params.model.dof = 3;
params.model.coordinates = ["barrel_recoil"; "carriage"; "platform"];

% Placeholder inertia matrix (kg).
params.M = diag([1.0e3, 2.5e3, 5.0e3]);

% Placeholder stiffness matrix (N/m), assembled from serial couplings.
k12 = 8.0e5;
k23 = 4.0e5;
k30 = 2.0e5;
params.K = [ k12,      -k12,       0;
            -k12,  k12+k23,    -k23;
               0,     -k23, k23+k30];

% Placeholder damping matrix (N*s/m), assembled like the stiffness matrix.
c12 = 1.5e4;
c23 = 9.0e3;
c30 = 5.0e3;
params.C = [ c12,      -c12,       0;
            -c12,  c12+c23,    -c23;
               0,     -c23, c23+c30];

% Force distribution: firing load acts on the barrel/recoil coordinate.
params.B = [1; 0; 0];

% Placeholder firing force definition.
params.force.type = "half-sine";
params.force.peak = 1.0e5;       % N
params.force.startTime = 0.02;   % s
params.force.duration = 0.04;    % s

% Simulation settings.
params.simulation.tStart = 0.0;
params.simulation.tEnd = 1.2;
params.simulation.relativeTolerance = 1.0e-7;
params.simulation.absoluteTolerance = 1.0e-9;
params.simulation.initialDisplacement = zeros(params.model.dof, 1);
params.simulation.initialVelocity = zeros(params.model.dof, 1);
end
