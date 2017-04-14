clear all;
close all;
names={'surgery'	'age'	'hospital number'	'rectal temperature'     'pulse'     'respiratory rate'	'temperature of extremities'	'peripheral pulse'	'mucous membranes'	'capillary refill time'	'pain'	'peristalsis'	'abdominal distension'	'nasogastric tube'	'nasogastric reflux'	'nasogastric reflux PH'	'rectal examination-feces'	'abdomen'	'packed cell volume'	'total protein'	'abdominocentesis appearance'	'abdomcentesis total protein'	'outcome'	'surgical lesion'	'type of lesion 1'	'type of lesion 2'	'type of lesion 3'	'cp data'};
data=xlsread('data_all_bare.xlsx');
for i=[4,5,6,16,19,20,22] %数值属性的编号
    a{i}(1)=max(data(:,i)); %max
    a{i}(2)=min(data(:,i)); %min
    a{i}(3)=mean(data(:,i),'omitnan'); %mean
    a{i}(4)=median(data(:,i),'omitnan'); %median
    a{i}(5:6)=quantile(data(:,i),[.25 .75]); %quartile
    a{i}(7)=floor(sum(isnan(data(:,i)))); %missed
%     fprintf('%s\t',names{i});
    disp(a{i});
end
        