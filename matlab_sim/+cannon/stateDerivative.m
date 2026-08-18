function dz = stateDerivative(t, z, params)
%STATEDERIVATIVE First-order state-space form of M*qdd + C*qd + K*q = B*F.

dof = params.model.dof;
q = z(1:dof);
qd = z(dof+1:end);
force = cannon.firingForce(t, params);

qdd = params.M \ (params.B .* force - params.C * qd - params.K * q);
dz = [qd; qdd];
end
