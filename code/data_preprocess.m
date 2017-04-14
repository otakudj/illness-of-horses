clear all;
close all;
names={'surgery'	'age'	'hospital number'	'rectal temperature'     'pulse'     'respiratory rate'	'temperature of extremities'	'peripheral pulse'	'mucous membranes'	'capillary refill time'	'pain'	'peristalsis'	'abdominal distension'	'nasogastric tube'	'nasogastric reflux'	'nasogastric reflux PH'	'rectal examination-feces'	'abdomen'	'packed cell volume'	'total protein'	'abdominocentesis appearance'	'abdomcentesis total protein'	'outcome'	'surgical lesion'	'type of lesion 1'	'type of lesion 2'	'type of lesion 3'	'cp data'};
data=xlsread('data_all_bare.xlsx');
%% delete the datas with more than (including)10 NaNs
num1=find(sum(isnan(data),2)<10);
data1=data(num1,:);
%[1,2,9,10,12,23,24,28]
%% replace the NaN by the most frequent data or median (missing rate≤10%)
num2=find(sum(isnan(data1),1)/size(data1,1)<=0.1);
b=zeros(1,28);
for i=intersect([1,2,7,8,9,10,11,12,13,14,15,17,18,21,23,24,28],num2) %标称属性损失率≤10%的数据
    j=1;
    while(~isempty(find(data(:,i)==j)))%寻找标称属性
        a{i}(j)=0;
        for k=1:size(data1,1)
            if(data1(k,i)==j)
                a{i}(j)=a{i}(j)+1;
            end
        end
        j=j+1;
    end
    b(i)=find(a{i}==max(a{i}));
end
for i=intersect([4,5,6,16,19,20,22],num2)
    b(i)=median(data(:,i),'omitnan'); %数值属性用中位数替换
end
data2=data1;
for i=num2
    for j=1:size(data1,1)
        if(isnan(data1(j,i)))
            data2(j,i)=b(i);
        end
    end
end
%% inter-altribute complication
data_temp=data2(:,[14,15]);
c=zeros(3,3);
for i=1:size(data_temp,1)
    if(~sum(isnan(data_temp(i,:))))
        c(data_temp(i,1),data_temp(i,2))=c(data_temp(i,1),data_temp(i,2))+1;
    end
end
for i=1:size(data_temp,1)
    if(sum(isnan(data_temp(i,:))))
        if(data_temp(i,1)==1 && isnan(data_temp(i,2)))
            data_temp(i,2)=find(c(1,:)==max(c(1,:)));
        elseif(data_temp(i,1)==2 && isnan(data_temp(i,2)))
            data_temp(i,2)=find(c(2,:)==max(c(2,:)));
        elseif(data_temp(i,1)==3 && isnan(data_temp(i,2)))
            data_temp(i,2)=find(c(3,:)==max(c(3,:)));
        elseif(isnan(data_temp(i,1)) && data_temp(i,2)==1)
            data_temp(i,1)=find(c(:,1)==max(c(:,1)));
        elseif(isnan(data_temp(i,1)) && data_temp(i,2)==2)
            data_temp(i,1)=find(c(:,2)==max(c(:,2)));
        elseif(isnan(data_temp(i,1)) && data_temp(i,2)==3)
            data_temp(i,1)=find(c(:,3)==max(c(:,3)));
        else
            [x,y]=find(c==max(max(c)));
            data_temp(i,:)=[x,y];
        end
    end
end
data3=data2;
data3(:,[14,15])=data_temp;
%% inter-sample complication
altribution=find(sum(isnan(data3)));
sample=find(~sum(isnan(data3),2));
test=1:size(data3,1);
test(sample)=[];
data4=data3;
for i=1:size(test,2)
    nan_altribute=find(isnan(data3(test(i),:)));
    label_altribute=setdiff(altribution,nan_altribute);
    test_vector=data3(test(i),label_altribute);
    rank=sum((data3(sample,label_altribute)-ones(size(sample,1),1)*test_vector).^2,2);
    similarity=sample(find(rank==min(rank)));   
    data4(test(i),nan_altribute)=data4(similarity(1),nan_altribute);
    sample=[sample;test(i)];
end
% figure;
% subplot(1,2,1);
% bar(data(:,18),1);
% title('data');
% subplot(1,2,2);
% bar(data4(:,18),1);
% title('data4');
% figure;
% subplot(1,2,1);
% qqplot(data(:,18));
% title('data');
% subplot(1,2,2);
% qqplot(data4(:,18));
% title('data4');
dlmwrite('data_preprocess.txt',data4,'delimiter',' ','precision',7);
