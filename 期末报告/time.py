import numpy as np
import matplotlib.pyplot as plt
from scipy.interpolate import make_interp_spline

# 定义关键时间点及其高峰值
time_points = [
    0, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 17.5, 18, 19, 19.5, 20, 21, 22, 23, 24
]
peak_values = [
    0, 0, 10, 40, 80, 100, 70, 50, 40, 30, 40, 50, 60, 70, 90, 100, 100, 80, 60, 40, 20, 10, 0
]

# 生成连续时间点
time_continuous = np.linspace(0, 24, 500)

# 使用插值生成平滑曲线
spline = make_interp_spline(time_points, peak_values, k=3)
peak_values_continuous = spline(time_continuous)

# 绘制图像
plt.figure(figsize=(12, 6))
plt.plot(time_continuous, peak_values_continuous, label='Traffic Peak Value')
plt.scatter(time_points, peak_values, color='red', zorder=5)  # 标出关键时间点
plt.title('Traffic Peak Value Throughout the Day in Shenzhen')
plt.xlabel('Time (Hours)')
plt.ylabel('Peak Value')
plt.xticks(np.arange(0, 25, 1))
plt.grid(True)
plt.legend()
plt.show()
