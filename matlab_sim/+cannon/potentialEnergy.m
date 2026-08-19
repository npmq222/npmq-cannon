function Pi = potentialEnergy(kin, params)
%POTENTIALENERGY Compute placeholder gravitational and elastic potential.

gravity = 9.80665;
m = params.mass;

PiGravity = gravity * (...
    m.m1 * kin.bodies.C1.r(3) + ...
    m.m2 * kin.bodies.C2.r(3) + ...
    m.m3 * kin.bodies.C3.r(3) + ...
    m.m4 * kin.bodies.C4.r(3) + ...
    m.m5 * kin.bodies.C5.r(3));

PiGround = 0;
labels = fieldnames(kin.outriggers);
for i = 1:numel(labels)
    delta = kin.outriggers.(labels{i}).deformation;
    PiGround = PiGround + 0.5 * delta.' * params.ground.K * delta;
end

q = kin.q;
PiAzimuth = 0.5 * params.joint.azimuthStiffness * (q(7) - params.joint.azimuthReference)^2;
PiElevation = 0.5 * params.joint.elevationStiffness * (q(8) - params.joint.elevationReference)^2;

Pi = PiGravity + PiGround + PiAzimuth + PiElevation;
end
