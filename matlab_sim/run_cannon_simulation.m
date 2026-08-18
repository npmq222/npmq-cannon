%% Cannon recoil/vibration simulation
% Main entry point for MATLAB Online. Upload the repository, open this file,
% and press Run. All numerical values are placeholders until real cannon
% parameters from the reference document are entered.

clear; clc; close all;

scriptFolder = fileparts(mfilename('fullpath'));
addpath(scriptFolder);

params = cannon.defaultParameters();
result = cannon.simulate(params);
summary = cannon.postprocess(result, params);

fprintf('\nCannon simulation completed.\n');
fprintf('Model DOF: %d\n', params.model.dof);
fprintf('Peak firing force: %.3g N\n', max(summary.force));

fprintf('\nPeak absolute displacement by DOF (m):\n');
disp(summary.peakAbsDisplacement);

fprintf('Peak absolute velocity by DOF (m/s):\n');
disp(summary.peakAbsVelocity);

fprintf('Peak absolute acceleration by DOF (m/s^2):\n');
disp(summary.peakAbsAcceleration);

cannon.plotResults(result, summary, params);
