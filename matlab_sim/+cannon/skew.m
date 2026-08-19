function S = skew(v)
%SKEW Return the cross-product matrix for a 3-vector.
%   S*w is equal to cross(v, w).

v = v(:);
S = [   0, -v(3),  v(2);
     v(3),     0, -v(1);
    -v(2),  v(1),     0];
end
