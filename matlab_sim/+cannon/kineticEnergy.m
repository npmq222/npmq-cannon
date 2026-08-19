function T = kineticEnergy(kin, params)
%KINETICENERGY Compute kinetic energy of the five main rigid bodies.

m = params.mass;
I = params.inertia;
T = bodyEnergy(m.m1, I.I1, kin.bodies.C1.v, kin.bodies.C1.omega, kin.bodies.C1.R) ...
  + bodyEnergy(m.m2, I.I2, kin.bodies.C2.v, kin.bodies.C2.omega, kin.bodies.C2.R) ...
  + bodyEnergy(m.m3, I.I3, kin.bodies.C3.v, kin.bodies.C3.omega, kin.bodies.C3.R) ...
  + bodyEnergy(m.m4, I.I4, kin.bodies.C4.v, kin.bodies.C4.omega, kin.bodies.C4.R) ...
  + bodyEnergy(m.m5, I.I5, kin.bodies.C5.v, kin.bodies.C5.omega, kin.bodies.C5.R);
end

function TBody = bodyEnergy(mass, inertiaBody, velocity, omega, rotation)
inertiaGround = rotation * inertiaBody * rotation.';
TBody = 0.5 * mass * (velocity.' * velocity) + 0.5 * omega.' * inertiaGround * omega;
end
