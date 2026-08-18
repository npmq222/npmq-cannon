function force = firingForce(t, params)
%FIRINGFORCE Evaluate the cannon firing force at time t.
%   Supports scalar or vector time inputs. The default placeholder is a
%   finite-duration half-sine pulse.

startTime = params.force.startTime;
duration = params.force.duration;
tau = (t - startTime) ./ duration;
active = tau >= 0 & tau <= 1;
force = zeros(size(t));

switch lower(string(params.force.type))
    case "half-sine"
        force(active) = params.force.peak .* sin(pi .* tau(active));
    case "triangular"
        force(active) = params.force.peak .* (1 - abs(2 .* tau(active) - 1));
    otherwise
        error("cannon:firingForce:UnknownType", ...
            "Unknown force type: %s", params.force.type);
end
end
