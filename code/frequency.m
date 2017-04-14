clear all;
close all;
data=xlsread('data_all_bare.xlsx');
names={'surgery'	'age'	'hospital number'	'rectal temperature'     'pulse'     'respiratory rate'	'temperature of extremities'	'peripheral pulse'	'mucous membranes'	'capillary refill time'	'pain'	'peristalsis'	'abdominal distension'	'nasogastric tube'	'nasogastric reflux'	'nasogastric reflux PH'	'rectal examination-feces'	'abdomen'	'packed cell volume'	'total protein'	'abdominocentesis appearance'	'abdomcentesis total protein'	'outcome'	'surgical lesion'	'type of lesion 1'	'type of lesion 2'	'type of lesion 3'	'cp data'};
for i=[1,2,7,8,9,10,11,12,13,14,15,17,18,21,23,24,28] %除去type of lesion的三个属性    
    j=1;
    while(~isempty(find(data(:,i)==j)))%寻找标称属性
        a{i}(j)=0;
        for k=1:368
            if(data(k,i)==j)
                a{i}(j)=a{i}(j)+1;
            end
        end
        j=j+1;
    end
fprintf('%s\t',names{i});
disp(a{i});
end
