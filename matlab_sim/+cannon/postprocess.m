function summary = postprocess(result, params)
%POSTPROCESS Compute acceleration, force histories and peak responses.

time = result.time;
numSteps = numel(time);
dof = params.model.dof;
acceleration = zeros(numSteps, dof);
force = cannon.firingForce(time, params);

for idx = 1:numSteps
    q = result.displacement(idx, :).';
    qd = result.velocity(idx, :).';
    acceleration(idx, :) = (params.M \ (params.B .* force(idx) - params.C * qd - params.K * q)).';
end

summary.time = time;
summary.force = force;
summary.acceleration = acceleration;
summary.elasticForce = (params.K * result.displacement.').';
summary.dampingForce = (params.C * result.velocity.').';
summary.peakAbsDisplacement = max(abs(result.displacement), [], 1).';
summary.peakAbsVelocity = max(abs(result.velocity), [], 1).';
summary.peakAbsAcceleration = max(abs(acceleration), [], 1).';
end
