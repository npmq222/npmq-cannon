function D = rayleighDissipation(kin, params)
%RAYLEIGHDISSIPATION Compute placeholder Rayleigh dissipation.

DGround = 0;
labels = fieldnames(kin.outriggers);
for i = 1:numel(labels)
    deltaDot = kin.outriggers.(labels{i}).deformationRate;
    DGround = DGround + 0.5 * deltaDot.' * params.ground.C * deltaDot;
end

D = DGround ...
  + 0.5 * params.joint.azimuthDamping * kin.dq(7)^2 ...
  + 0.5 * params.joint.elevationDamping * kin.dq(8)^2;
end
