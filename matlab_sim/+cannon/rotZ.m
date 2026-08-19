function R = rotZ(angle)
%ROTZ Rotation matrix about the local z-axis.

c = cos(angle);
s = sin(angle);
R = [c, -s, 0;
     s,  c, 0;
     0,  0, 1];
end
