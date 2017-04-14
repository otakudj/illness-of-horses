clear all;
close all;
names={'surgery'	'age'	'hospital number'	'rectal temperateure'     'pulse'     'respiratory rate'	'temperature of extremities'	'peripheral pulse'	'mucous membranes'	'capillary refill time'	'pain'	'peristalsis'	'abdominal distension'	'nasogastric tube'	'nasogastric reflux'	'nasogastric reflux PH'	'rectal examination-feces'	'abdomen'	'packed cell volume'	'total protein'	'abdominocentesis appearance'	'abdomcentesis total protein'	'outcome'	'surgical lesion'	'type of lesion 1'	'type of lesion 2'	'type of lesion 3'	'cp data'};
data=xlsread('data_all_bare.xlsx');
for i=[4,5,6,16,19,20,22] %数值属性的编号
    figure;
    bar(data(:,i));
    title([names{i},'-Histogram']);
    figure;
    qqplot(data(:,i));
    title([names{i},'-QQ']);
end