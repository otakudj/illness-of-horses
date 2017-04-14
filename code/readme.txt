整个过程基于MATLAB编程，由于MATLAB不能很方便读取txt文件，我先用excel导入txt文件得到data_all_bare.xlsx，再用MATLAB读取excel，进行一下实验：

2 数据可视化和摘要

2.1 数据摘要
2.1.1 对标称属性，给出每个可能的频数 frequency.m
2.1.2 数值属性，给出最大、最小、均值、中位数、四分位数及缺失值的个数 max_min_mean_etc.m

2.2 数据可视化
2.2.1 绘制直方图，如mxPH，用qq图检验其分布是否为正态分布 histogram_qq.m
2.2.2 绘制盒图，对离群值进行识别 box_plot.m

3 数据缺失的处理 data_preprocess.m
3.1 将缺失部分剔除
3.2 用最高频率值来填补缺失值
3.3 通过属性的相关关系来填补缺失值
3.4 通过数据对象之间的相似性来填补缺失值
3.5 处理后，可视化地对比新旧数据集

最后处理完成的结果保存在data_preprocess.txt中