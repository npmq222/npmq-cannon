function kin = kinematics(q, dq, params)
%KINEMATICS Evaluate DH-consistent kinematics for the 10-DOF cannon model.
%   KIN = KINEMATICS(Q, DQ, PARAMS) returns frame rotations, origins,
%   center-of-mass positions, translational velocities, angular velocities,
%   and outrigger deformations. Vectors are expressed in the ground frame.
%
%   Coordinate convention:
%     q1-q3   carriage translation in O0X0Y0Z0
%     q4-q6   small carriage rotations about X1, Y1, Z1
%     q7      azimuth about Z1, positive to the left
%     q8      elevation about Z2=Z3, positive raising the barrels
%     q9      left recoil block displacement along X3, positive forward
%     q10     right recoil block displacement along X3, positive forward

if numel(q) ~= 10 || numel(dq) ~= 10
    error("cannon:kinematics:InvalidStateSize", "q and dq must both have 10 elements.");
end

g = params.geometry;

rO1 = q(1:3);
vO1 = dq(1:3);
theta1 = q(4:6);
omega1 = dq(4:6);

R01 = eye(3) + cannon.skew(theta1);
R0h = R01 * cannon.rotZ(q(7));
Rh2 = [1, 0,  0;
       0, 0, -1;
       0, 1,  0];
R02 = R0h * Rh2;
R03 = R02 * cannon.rotZ(q(8));
R04 = R03;
R05 = R03;

xh = R0h(:, 1);
yh = R0h(:, 2);
zh = R0h(:, 3);
x2 = R02(:, 1);
y2 = R02(:, 2);
z2 = R02(:, 3);
x3 = R03(:, 1);
y3 = R03(:, 2);
z3 = R03(:, 3);

omegah = omega1 + dq(7) * zh;
omega2 = omegah;
omega3 = omega2 + dq(8) * z3;
omega4 = omega3;
omega5 = omega3;

rho12 = R0h * g.a12_h;
rO2 = rO1 + rho12;
vO2 = vO1 + cross(omegah, rho12);
rO3 = rO2;
vO3 = vO2;

rC1 = rO1 + R01 * g.a1C;
vC1 = vO1 + cross(omega1, R01 * g.a1C);

rC2 = rO2 + R02 * g.a2C;
vC2 = vO2 + cross(omega2, R02 * g.a2C);

rC3 = rO3 + R03 * g.a3C;
vC3 = vO3 + cross(omega3, R03 * g.a3C);

r34 = g.a34 + [q(9); 0; 0];
r35 = g.a35 + [q(10); 0; 0];

rC4 = rO3 + R03 * r34;
vC4 = vO3 + cross(omega3, R03 * r34) + dq(9) * x3;

rC5 = rO3 + R03 * r35;
vC5 = vO3 + cross(omega3, R03 * r35) + dq(10) * x3;

b = outriggerLocalPoints(g.outriggerDistance);
outriggers = struct();
labels = fieldnames(b);
for i = 1:numel(labels)
    label = labels{i};
    localPoint = b.(label);
    rho = R01 * localPoint;
    position = rO1 + rho;
    velocity = vO1 + cross(omega1, rho);
    reference = localPoint;
    deformation = position - reference;
    deformationRate = velocity;
    force = -params.ground.K * deformation - params.ground.C * deformationRate;

    outriggers.(label).localPoint = localPoint;
    outriggers.(label).position = position;
    outriggers.(label).velocity = velocity;
    outriggers.(label).deformation = deformation;
    outriggers.(label).deformationRate = deformationRate;
    outriggers.(label).force = force;
end

kin.frames.R01 = R01;
kin.frames.R0h = R0h;
kin.frames.Rh2 = Rh2;
kin.frames.R02 = R02;
kin.frames.R03 = R03;
kin.frames.R04 = R04;
kin.frames.R05 = R05;
kin.frames.xh = xh;
kin.frames.yh = yh;
kin.frames.zh = zh;
kin.frames.x2 = x2;
kin.frames.y2 = y2;
kin.frames.z2 = z2;
kin.frames.x3 = x3;
kin.frames.y3 = y3;
kin.frames.z3 = z3;

kin.origins.O1.r = rO1;
kin.origins.O1.v = vO1;
kin.origins.O2.r = rO2;
kin.origins.O2.v = vO2;
kin.origins.O3.r = rO3;
kin.origins.O3.v = vO3;

kin.angular.omega1 = omega1;
kin.angular.omegah = omegah;
kin.angular.omega2 = omega2;
kin.angular.omega3 = omega3;
kin.angular.omega4 = omega4;
kin.angular.omega5 = omega5;

kin.bodies.C1.r = rC1;
kin.bodies.C1.v = vC1;
kin.bodies.C1.omega = omega1;
kin.bodies.C1.R = R01;
kin.bodies.C2.r = rC2;
kin.bodies.C2.v = vC2;
kin.bodies.C2.omega = omega2;
kin.bodies.C2.R = R02;
kin.bodies.C3.r = rC3;
kin.bodies.C3.v = vC3;
kin.bodies.C3.omega = omega3;
kin.bodies.C3.R = R03;
kin.bodies.C4.r = rC4;
kin.bodies.C4.v = vC4;
kin.bodies.C4.omega = omega4;
kin.bodies.C4.R = R04;
kin.bodies.C5.r = rC5;
kin.bodies.C5.v = vC5;
kin.bodies.C5.omega = omega5;
kin.bodies.C5.R = R05;

kin.outriggers = outriggers;
kin.q = q;
kin.dq = dq;
end

function points = outriggerLocalPoints(distance)
points.front = [ distance; 0; 0];
points.back = [-distance; 0; 0];
points.left = [0;  distance; 0];
points.right = [0; -distance; 0];
end
