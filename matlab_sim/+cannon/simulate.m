function result = simulate(params)
%SIMULATE Integrate the cannon dynamic model with ODE45.

z0 = [params.simulation.initialDisplacement; ...
      params.simulation.initialVelocity];

timeSpan = [params.simulation.tStart, params.simulation.tEnd];
options = odeset( ...
    'RelTol', params.simulation.relativeTolerance, ...
    'AbsTol', params.simulation.absoluteTolerance);

[t, z] = ode45(@(t, z) cannon.stateDerivative(t, z, params), timeSpan, z0, options);

dof = params.model.dof;
result.time = t;
result.displacement = z(:, 1:dof);
result.velocity = z(:, dof+1:end);
end
