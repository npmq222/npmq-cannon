%RUN_CANNON_KINEMATICS_DEMO Demonstrate the 10-DOF cannon kinematic model.
%   This script evaluates the DH-consistent kinematics at the default state
%   and prints the main frame axes and center-of-mass positions.

clear; clc;

params = cannon.defaultParameters();
q = params.initial.q;
dq = params.initial.dq;
kin = cannon.kinematics(q, dq, params);

disp("Generalized coordinates q:");
disp(q.');

disp("Frame-3 axes in ground coordinates [x3 y3 z3]:");
disp(kin.frames.R03);

disp("Center-of-mass positions [C1 C2 C3 C4 C5]:");
disp([kin.bodies.C1.r, kin.bodies.C2.r, kin.bodies.C3.r, kin.bodies.C4.r, kin.bodies.C5.r]);
