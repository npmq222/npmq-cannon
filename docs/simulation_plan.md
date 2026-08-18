# Kế hoạch mô phỏng MATLAB cho hệ pháo

Tài liệu gốc trong repo là `TT-Luan-an.pdf`. Phần triển khai dưới đây bám theo cách tổ chức mô hình động lực học nhiều bậc tự do thường dùng trong Chương 2 và quy trình mô phỏng/khảo sát ở Chương 3: xây dựng hệ phương trình, chọn véc-tơ trạng thái, kích thích bằng lực bắn, tích phân số và hậu xử lý đáp ứng.

## 1. Giả thiết mô hình ban đầu

Do các thông số thật chưa được cung cấp, mô hình MATLAB dùng bộ tham số giả định để kiểm tra luồng mô phỏng:

- Hệ 3 bậc tự do tịnh tiến theo phương giật lùi của nòng/thân pháo.
- Bậc tự do 1: khối giật/nòng.
- Bậc tự do 2: giá/khung pháo.
- Bậc tự do 3: nền/xe mang pháo.
- Ma trận quán tính `M`, cản `C`, độ cứng `K` được nhập dạng đối xứng xác định dương.
- Lực bắn tác dụng lên bậc tự do 1, có thể chọn xung nửa sin hoặc xung tam giác.

Phương trình tổng quát:

```text
M*qdd + C*qd + K*q = B*F(t)
```

trong đó `q = [x1; x2; x3]` là chuyển vị các bậc tự do, `B = [1; 0; 0]` là véc-tơ phân bố lực.

## 2. Cấu trúc mã

```text
matlab_sim/
  run_cannon_simulation.m      Script chạy chính trên MATLAB Online
  +cannon/
    defaultParameters.m        Khai báo tham số giả định
    firingForce.m              Hàm lực bắn theo thời gian
    stateDerivative.m          Phương trình trạng thái dùng cho ode45
    simulate.m                 Bộ tích phân mô phỏng
    postprocess.m              Tính gia tốc, lực liên kết, cực trị
    plotResults.m              Vẽ đồ thị kết quả
```

## 3. Luồng mô phỏng

1. Chạy `matlab_sim/run_cannon_simulation.m`.
2. Nạp tham số mặc định từ `cannon.defaultParameters()`.
3. Tạo điều kiện đầu bằng 0.
4. Tích phân hệ phương trình bằng `ode45`.
5. Hậu xử lý chuyển vị, vận tốc, gia tốc, lực bắn và lực đàn hồi/cản tương đương.
6. In bảng cực trị và vẽ các đồ thị phục vụ kiểm tra.

## 4. Những điểm cần thay sau khi có tham số thật

- Cập nhật `params.M`, `params.C`, `params.K` trong `defaultParameters.m`.
- Cập nhật biên độ, thời gian tác dụng và dạng lực trong `params.force`.
- Nếu Chương 2 yêu cầu thêm góc quay hoặc phi tuyến, mở rộng véc-tơ `q` và cập nhật các ma trận trong cùng cấu trúc.
