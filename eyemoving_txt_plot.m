filename = '.\record_19_02_25_12_40_39-12_41_35\record_left_eye_19_02_25_12_40_39-12_41_35.txt';

data=importdata(filename);

%�������ɼ����ݱ��浽matlab�еľ�����
DATA=zeros(length(data),2);
for i=1 : length(data)
    
   new=data{i,1} ;%��cell��ȡ���ַ�
   new_data=str2num(new);%���ַ�ת��������
   
   DATA(i,1)=new_data(1);
   DATA(i,2)=new_data(2);%����������֮ǰ�����ľ����У���һ��Ϊ�۶���x���ڶ���Ϊ�۶���y
    
end

%���ƹ���ͼ
figure(1)
plot(DATA(:,1),DATA(:,2),'-*')
grid on
ha=gca;
set(ha,'xlim',[-1,1])
set(ha,'ylim',[-1,1])
title('Eye moving trajectory diagram')
%�������ʱ��

%--------------------------------------------------------------------------
% ���� mex ����
X=DATA(:,2);

maxLags = 50;          % ���ʱ��
Part = 20;             % ÿһ���껮�ֵķ���
r = Amutual_lzb(X,maxLags,Part);

%--------------------------------------------------------------------------
% Ѱ�ҵ�һ���ֲ���С��

tau = [];
for i = 1:length(r)-1           
    if (r(i)<=r(i+1))
        tau = i;            % ��һ���ֲ���Сֵλ��
        break;
    end
end
if isempty(tau)
    tau = length(r);
end
optimal_tau = tau -1    % r �ĵ�һ��ֵ��Ӧ tau = 0,����Ҫ�� 1

%--------------------------------------------------------------------------
% ͼ����ʾ
figure(2)
plot(0:length(r)-1,r,'.-')
xlabel('Lag');
title('����Ϣ����ʱ��X');







