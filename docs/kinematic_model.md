# Mô hình động học pháo phòng không hai nòng 37 mm K65

Tài liệu này mô tả lại mô hình động học 10 tọa độ suy rộng của hệ pháo phòng không hai nòng 37 mm K65. Mô hình được đặt lại hệ trục theo quy tắc Denavit-Hartenberg để tránh nhập nhằng giữa hệ xe pháo, hệ quay hướng và hệ quay tầm.

## 1. Tọa độ suy rộng

Véc-tơ tọa độ suy rộng của hệ là:

```text
q = [q1 q2 q3 q4 q5 q6 q7 q8 q9 q10]^T
```

Ý nghĩa các tọa độ:

| Tọa độ | Ý nghĩa |
| --- | --- |
| `q1` | Dịch chuyển của xe pháo theo trục `X0` của hệ mặt đất. |
| `q2` | Dịch chuyển của xe pháo theo trục `Y0` của hệ mặt đất. |
| `q3` | Dịch chuyển của xe pháo theo trục `Z0` của hệ mặt đất. |
| `q4` | Góc lắc nhỏ của xe pháo quanh trục `X1`. |
| `q5` | Góc lắc nhỏ của xe pháo quanh trục `Y1`. |
| `q6` | Góc lắc nhỏ của xe pháo quanh trục `Z1`. |
| `q7` | Góc hướng của bệ pháo quanh trục `Z1`. Chiều dương là quay sang trái. |
| `q8` | Góc tầm của máng pháo quanh trục `Z2 = Z3`. Chiều dương là nâng nòng lên. |
| `q9` | Dịch chuyển khối lùi trái dọc trục máng `X3`. Chiều dương hướng về trước. |
| `q10` | Dịch chuyển khối lùi phải dọc trục máng `X3`. Chiều dương hướng về trước. |

Trong quá trình giật lùi thực tế, `q9` và `q10` thường âm vì hướng dương của chúng được chọn về phía trước.

## 2. Các hệ tọa độ

### 2.1. Hệ mặt đất `O0X0Y0Z0`

Hệ `O0X0Y0Z0` gắn với đất và được xem là hệ quán tính. Ban đầu, các trục của hệ đất cùng hướng với hệ xe pháo:

```text
X0 // X1
Y0 // Y1
Z0 // Z1
```

### 2.2. Hệ xe pháo `O1X1Y1Z1`

`O1` gắn với xe pháo, đặt tại tâm hình học của xe và nằm trên trục quay hướng. Quy ước trục:

```text
X1: hướng về chân chống trước
Y1: hướng sang trái
Z1: hướng lên trên và là trục quay hướng
```

Vị trí của `O1` trong hệ đất là:

```text
r_O1 = [q1 q2 q3]^T
```

Do `q4`, `q5`, `q6` là góc nhỏ, ma trận quay từ hệ 1 sang hệ 0 được xấp xỉ:

```text
R01 = I + skew([q4 q5 q6]^T)
```

với:

```text
skew([a b c]^T) = [ 0 -c  b;
                    c  0 -a;
                   -b  a  0]
```

### 2.3. Hệ sau quay hướng `OhXhYhZh`

Hệ trung gian `h` thu được bằng cách quay hệ 1 quanh `Z1` một góc hướng `q7`:

```text
R0h = R01 * Rz(q7)
```

Trong đó `Zh` trùng trục hướng và `Xh` là phương trước của pháo sau khi quay hướng.

### 2.4. Hệ tầm `O2X2Y2Z2`

`O2` là tâm trục tầm. `O2` nằm cao hơn `O1` một đoạn nhỏ và có thể có offset tổng quát trong hệ `h`:

```text
a12 = [a12x a12y h12]^T
r_O2 = r_O1 + R0h * a12
```

Nếu dùng mô hình tối giản, có thể lấy `a12x = 0`, `a12y = 0`, `h12 > 0`.

Hệ `O2X2Y2Z2` được đặt theo quy tắc tam diện thuận:

```text
X2 cùng hướng Xh
Z2 là trục tầm, hướng sang phải
Y2 hướng lên trên
```

Vì `Y1` hướng sang trái, trục tầm hướng sang phải nên trong hệ sau quay hướng:

```text
z2 = -yh
```

Ma trận đổi trục từ hệ 2 sang hệ h là:

```text
Rh2 = [1 0  0;
       0 0 -1;
       0 1  0]
```

Do đó:

```text
R02 = R0h * Rh2
```

### 2.5. Hệ máng pháo `O3X3Y3Z3`

`O3` trùng `O2`. Hệ 3 thu được bằng cách quay hệ 2 quanh trục tầm `Z2` một góc `q8`:

```text
O3 = O2
Z3 = Z2
R03 = R02 * Rz(q8)
```

Khi `q8 > 0`, trục máng `X3` quay lên trên. Khi bỏ qua các góc nhỏ của xe, các trục hệ 3 trong hệ đất là:

```text
x3 = [cos(q7)*cos(q8); sin(q7)*cos(q8); sin(q8)]
y3 = [-cos(q7)*sin(q8); -sin(q7)*sin(q8); cos(q8)]
z3 = [sin(q7); -cos(q7); 0]
```

Tại `q7 = 0`, `q8 = 0`:

```text
x3 = X0
 y3 = Z0
z3 = -Y0
```

nên `Z3` đúng là hướng sang phải.

### 2.6. Hệ 4 và hệ 5

Hệ 4 và hệ 5 có các trục cùng hướng hệ 3. Gốc `O4` và `O5` lần lượt trùng với trọng tâm của khối lùi trái và phải.

Vì `Z3` hướng sang phải:

```text
a34z < 0: khối lùi trái
a35z > 0: khối lùi phải
```

Trong mô hình đối xứng ban đầu có thể lấy:

```text
a34x = a35x
a34y = a35y
a34z = -b
a35z =  b
```

## 3. Phương trình vị trí

### 3.1. Tâm các khớp

```text
r_O1 = [q1 q2 q3]^T
r_O2 = r_O1 + R0h * a12
r_O3 = r_O2
```

### 3.2. Trọng tâm các vật

Vật 1, xe pháo:

```text
r_C1 = r_O1 + R01 * a1C
```

Vật 2, bệ pháo / khối hướng:

```text
r_C2 = r_O2 + R02 * a2C
```

Vật 3, máng pháo / khối lên xuống:

```text
r_C3 = r_O3 + R03 * a3C
```

Vật 4, khối lùi trái:

```text
r_C4 = r_O3 + R03 * [a34x + q9; a34y; a34z]
```

Vật 5, khối lùi phải:

```text
r_C5 = r_O3 + R03 * [a35x + q10; a35y; a35z]
```

## 4. Phương trình vận tốc góc

Vận tốc góc của hệ 1:

```text
omega1 = [dq4 dq5 dq6]^T
```

Vận tốc góc của hệ sau quay hướng và hệ 2:

```text
omegah = omega1 + dq7 * zh
omega2 = omegah
```

Vận tốc góc của hệ 3, hệ 4, hệ 5:

```text
omega3 = omega2 + dq8 * z3
omega4 = omega3
omega5 = omega3
```

Trong đó:

```text
zh = R0h * [0 0 1]^T
z3 = R03 * [0 0 1]^T
```

## 5. Phương trình vận tốc tịnh tiến

Với một điểm cố định trong vật rắn có véc-tơ tương đối `rho`, vận tốc tuyệt đối là:

```text
v = v_base + omega_body x rho
```

Do đó:

```text
v_O1 = [dq1 dq2 dq3]^T
v_O2 = v_O1 + omegah x (R0h * a12)
v_O3 = v_O2
```

Trọng tâm vật 1:

```text
v_C1 = v_O1 + omega1 x (R01 * a1C)
```

Trọng tâm vật 2:

```text
v_C2 = v_O2 + omega2 x (R02 * a2C)
```

Trọng tâm vật 3:

```text
v_C3 = v_O3 + omega3 x (R03 * a3C)
```

Khối lùi trái:

```text
v_C4 = v_O3 + omega3 x (R03 * [a34x + q9; a34y; a34z]) + dq9 * x3
```

Khối lùi phải:

```text
v_C5 = v_O3 + omega3 x (R03 * [a35x + q10; a35y; a35z]) + dq10 * x3
```

Trong đó:

```text
x3 = R03 * [1 0 0]^T
```

## 6. Động học bốn chân chống

Với khoảng cách đối xứng `L` từ `O1` đến mỗi chân chống, tọa độ chân chống trong hệ 1 là:

```text
b_front = [ L  0 0]^T
b_back  = [-L  0 0]^T
b_left  = [ 0  L 0]^T
b_right = [ 0 -L 0]^T
```

Vị trí và vận tốc chân chống `s`:

```text
r_s = r_O1 + R01 * b_s
v_s = v_O1 + omega1 x (R01 * b_s)
```

Biến dạng nền và vận tốc biến dạng:

```text
delta_s = r_s - r_s0
delta_dot_s = v_s
```

Trong xấp xỉ góc nhỏ, nếu `r_s0 = b_s`:

```text
delta_s ~= [q1 q2 q3]^T + [q4 q5 q6]^T x b_s
delta_dot_s ~= [dq1 dq2 dq3]^T + [dq4 dq5 dq6]^T x b_s
```

Nền giống nhau tại bốn chân và có độ cứng, cản theo ba phương:

```text
Kg = diag([kx ky kz])
Cg = diag([cx cy cz])
F_s = -Kg * delta_s - Cg * delta_dot_s
```

## 7. Dạng Jacobi

Với mỗi vật:

```text
v_Ci = Jv_i(q) * dq
omega_i = Jw_i(q) * dq
```

trong đó:

```text
Jv_i(q) = partial(r_Ci) / partial(q)
```

Jacobi quay vật 1:

```text
Jw1 = [zeros(3,3), eye(3), zeros(3,4)]
```

Jacobi quay vật 2:

```text
Jw2 = [zeros(3,3), eye(3), zh, zeros(3,1), zeros(3,2)]
```

Jacobi quay vật 3, 4, 5:

```text
Jw3 = Jw4 = Jw5 = [zeros(3,3), eye(3), zh, z3, zeros(3,2)]
```

## 8. Dạng đưa vào phương trình Lagrange

Từ động học, động năng của 5 vật chính là:

```text
T = 1/2 * sum_i mi * v_Ci' * v_Ci
  + 1/2 * sum_i omega_i' * I_i0 * omega_i
```

với `I_i0 = R0i * I_i_body * R0i'` nếu tensor quán tính được cho trong hệ thân.

Phương trình Lagrange loại II:

```text
d/dt(partial(T)/partial(dqj)) - partial(T)/partial(qj)
  + partial(Pi)/partial(qj)
  + partial(D)/partial(dqj)
  = Qj, j = 1..10
```

Dạng ma trận:

```text
M(q) * ddq + H(q, dq) = Q(q, dq, t)
```
