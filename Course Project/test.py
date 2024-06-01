import pandas as pd

# 列名翻译字典
column_translation = {
    "WINDDIRECT": "风向",
    "RELHUMIDITY": "相对湿度",
    "SURFACEMINTEMP": "表面最低温度",
    "GRASSLANDMAXTEMP": "草地最高温度",
    "AUTOPRECIPAMOUNT": "自动降水量",
    "MINSTATIONPRESS": "最低站点气压",
    "HEXMAXWINDD": "最大风向（十六进制）",
    "DEWTEMP": "露点温度",
    "INSTANTWINDV": "瞬时风速",
    "SURFACETEMP": "表面温度",
    "TEMP5CM": "5厘米处温度",
    "STATIONPRESS": "站点气压",
    "SURFACEMAXTEMP": "表面最高温度",
    "TEMP20CM": "20厘米处温度",
    "WINDV10MS": "10米处风速",
    "INSTANTWINDD": "瞬时风向",
    "SEALEVELPRESS": "海平面气压",
    "VISIBILITY": "能见度",
    "MAXTEMP": "最高温度",
    "TEMP160CM": "160厘米处温度",
    "TEMP15CM": "15厘米处温度",
    "MAXWINDV10MS": "10米处最大风速",
    "VAPOURPRESS": "蒸汽压",
    "WINDD10MS": "10米处风向",
    "MINTEMP": "最低温度",
    "MAXWINDD10MS": "10米处最大风向",
    "OSSMOID": "土壤湿度传感器ID",
    "TEMP320CM": "320厘米处温度",
    "GRASSLANDTEMP": "草地温度",
    "TEMP10CM": "10厘米处温度",
    "TIMEHSURFMINT": "表面最低温度时间",
    "CLOUDAMOUNT": "云量",
    "MAXSTATIONPRESS": "最高站点气压",
    "MINRELHUMIDITY": "最低相对湿度",
    "KEYID": "关键ID",
    "LOWCLOUDAMOUNT": "低云量",
    "CLOUDFORM": "云型",
    "DRYBULBTEMP": "干球温度",
    "TEMP80CM": "80厘米处温度",
    "WINDVELOCITY": "风速",
    "AUTOEVAPGAUGE": "自动蒸发量计",
    "CHECKSTR": "校验字符串",
    "CHECKSTS": "校验状态",
    "PRECIPITATIONAMOUNT": "降水量",
    "TEMP40CM": "40厘米处温度",
    "HEXMAXWINDV": "最大风速（十六进制）",
    "GRASSLANDMINTEMP": "草地最低温度"
}

# 创建DataFrame
df = pd.DataFrame(list(column_translation.items()), columns=['English', 'Chinese'])

# 翻转DataFrame，使其列名作为行，并保持两行：英文和中文
df_flipped = pd.DataFrame([df['English'], df['Chinese']])
df_flipped.columns = df_flipped.iloc[0]
df_flipped = df_flipped[1:]

# 输出为Excel文件
output_path_flipped = 'translated_columns_flipped.xlsx'
df_flipped.to_excel(output_path_flipped, index=False, header=False)

print(f"File saved as {output_path_flipped}")
