
% 互信息法求时延
% 使用平台 - Matlab7.1
clc
clear all
close all

%--------------------------------------------------------------------------
% 产生 Lorenz 时间序列
% dx/dt = sigma*(y-x)
% dy/dt = r*x - y - x*z
% dz/dt = -b*z + x*y

sigma = 16;          % Lorenz方程参数
r = 45.92;               
b = 4;          

y = [-1;0;1];        % 起始点 (3x1 的列向量)
h = 0.01;            % 积分时间步长

k1 = 30000;          % 前面的迭代点数
k2 = 5000;           % 后面的迭代点数

Z = LorenzData(y,h,k1+k2,sigma,r,b);
X = Z(k1+1:end,1);   % 时间序列(列向量)
%生成时间序列
%--------------------------------------------------------------------------
% 调用 mex 函数

maxLags = 50;          % 最大时延
Part = 20;             % 每一座标划分的份数
r = Amutual_lzb(X,maxLags,Part);

%--------------------------------------------------------------------------
% 寻找第一个局部极小点

tau = [];
for i = 1:length(r)-1           
    if (r(i)<=r(i+1))
        tau = i;            % 第一个局部极小值位置
        break;
    end
end
if isempty(tau)
    tau = length(r);
end
optimal_tau = tau -1    % r 的第一个值对应 tau = 0,所以要减 1

%--------------------------------------------------------------------------
% 图形显示

plot(0:length(r)-1,r,'.-')
xlabel('Lag');
title('互信息法求时延');
