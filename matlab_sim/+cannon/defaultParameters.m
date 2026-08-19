function params = defaultParameters()
%DEFAULTPARAMETERS Return placeholder parameters for the 10-DOF K65 model.
%   The numeric values are deliberately simple placeholders. Replace them
%   with measured geometric, mass and stiffness data before using the model
%   for engineering conclusions.

params.model.name = "Ten-DOF DH-consistent K65 cannon kinematic model";
params.model.dof = 10;
params.model.coordinates = [ ...
    "carriage_x"; ...
    "carriage_y"; ...
    "carriage_z"; ...
    "carriage_roll_x"; ...
    "carriage_pitch_y"; ...
    "carriage_yaw_z"; ...
    "azimuth"; ...
    "elevation"; ...
    "left_recoil_along_x3"; ...
    "right_recoil_along_x3"];

% Geometry, in metres. All center-of-mass vectors are expressed in their
% local body frames unless the field name states otherwise.
params.geometry.a1C = [0.00; 0.00; 0.00];
params.geometry.a12_h = [0.00; 0.00; 0.35];
params.geometry.a2C = [0.05; 0.00; 0.05];
params.geometry.a3C = [0.75; 0.05; 0.00];
params.geometry.a34 = [1.20; 0.00; -0.18];
params.geometry.a35 = [1.20; 0.00;  0.18];
params.geometry.outriggerDistance = 1.50;

% Body masses, in kg. Placeholder values only.
params.mass.m1 = 2500;
params.mass.m2 = 900;
params.mass.m3 = 650;
params.mass.m4 = 120;
params.mass.m5 = 120;

% Diagonal body-frame inertia tensors, in kg*m^2. Placeholder values only.
params.inertia.I1 = diag([900, 1200, 1400]);
params.inertia.I2 = diag([180, 220, 260]);
params.inertia.I3 = diag([120, 450, 430]);
params.inertia.I4 = diag([12, 35, 35]);
params.inertia.I5 = diag([12, 35, 35]);

% Identical ground stiffness and damping at all four outriggers.
params.ground.K = diag([1.0e6, 1.0e6, 2.0e6]);
params.ground.C = diag([1.0e4, 1.0e4, 2.0e4]);

% Torsional stiffness and damping of azimuth and elevation mechanisms.
params.joint.azimuthStiffness = 2.0e5;
params.joint.azimuthDamping = 2.0e3;
params.joint.azimuthReference = 0;
params.joint.elevationStiffness = 1.5e5;
params.joint.elevationDamping = 1.5e3;
params.joint.elevationReference = 0;

% Default state for quick checks.
params.initial.q = zeros(params.model.dof, 1);
params.initial.q(8) = deg2rad(10);
params.initial.dq = zeros(params.model.dof, 1);
end
