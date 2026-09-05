%figue
%outage probability of cellular network without relay, both from direct solution and from numerical integration
clc;
clear;
close all;
N = 1;
i=0.01:0.01:1;
P2= i.^2.*log(1+1./(i.^2));
P4= i.^2.*atan(1./(i.^2));

r = 3;
for dsd = 0.01:0.01:1
    func = @(dse)(dsd.^r./(dsd.^r+dse.^r).*2.*dse);
    P3_numerical(1,round(dsd*100))=1 - (1-quad(func, 0,1)).^N;
end;

figure,
plot(i,P2,'-','linewidth',2);
hold on;
grid on;
plot(i,P3_numerical,'--k','linewidth',2)
plot(i,P4,'-.r','linewidth',2);

xlabel('$$x = {d_{sd}}/{R}$$','Interpreter','latex','fontsize',14);
ylabel('$P_{Direct}^{N}$','Interpreter','latex','fontsize',14)

% N = 2;
% P2_N = 1 - (1 - P2).^N;
% P4_N = 1 - (1 - P4).^N;
% r = 3;
% for dsd = 0.01:0.01:1
%     func = @(dse)(dsd.^r./(dsd.^r+dse.^r).*2.*dse);
%     P3_numerical_N(1,round(dsd*100))=1 - (1-quad(func, 0,1)).^N;
% end;
% plot(i,P2_N,'-','linewidth',2);
% plot(i,P3_numerical_N,'--k','linewidth',2)
% plot(i,P4_N,'-.r','linewidth',2);
% 
% legend('\alpha=2','\alpha=3','\alpha=4',0)

% legend('\alpha=2, N=1','\alpha=3, N=1','\alpha=4, N=1','\alpha=2, N=5','\alpha=3, N=5','\alpha=4, N=5',2)

N = 2;
P2_N = 1 - (1 - P2).^N;
P4_N = 1 - (1 - P4).^N;
r = 3;
for dsd = 0.01:0.01:1
    func = @(dse)(dsd.^r./(dsd.^r+dse.^r).*2.*dse);
    P3_numerical_N(1,round(dsd*100))=1 - (1-quad(func, 0,1)).^N;
end;
plot(i,P2_N,'-','linewidth',2);
plot(i,P3_numerical_N,'--k','linewidth',2)
plot(i,P4_N,'-.r','linewidth',2);

legend('\alpha=2','\alpha=3','\alpha=4',0)


N = 10;
P2_N = 1 - (1 - P2).^N;
P4_N = 1 - (1 - P4).^N;
r = 3;
for dsd = 0.01:0.01:1
    func = @(dse)(dsd.^r./(dsd.^r+dse.^r).*2.*dse);
    P3_numerical_N(1,round(dsd*100))=1 - (1-quad(func, 0,1)).^N;
end;
plot(i,P2_N,'-','linewidth',2);
plot(i,P3_numerical_N,'--k','linewidth',2)
plot(i,P4_N,'-.r','linewidth',2);

legend('\alpha=2','\alpha=3','\alpha=4',0)


radium = 1;
N = 2;
K = 1e5;
R=radium.*sqrt(rand(N,K));
alpha = 4;
Channel_se = 1./(R.^alpha).*exprnd(1,N,K);
max_Channel_se = max(Channel_se);
fading_sd = exprnd(1,1,K);
i = 1;
dsd = 0.01:0.01:1;
for i = 1:1:length(dsd)
    Channel_sd = 1./(dsd(i)^alpha).*fading_sd;
    Outage_4(i) = (sum(Channel_sd < max_Channel_se))./K;
    i = i + 1;
end;

alpha = 3;
Channel_se = 1./(R.^alpha).*exprnd(1,N,K);
max_Channel_se = max(Channel_se);
fading_sd = exprnd(1,1,K);
i = 1;
dsd = 0.01:0.01:1;
for i = 1:1:length(dsd)
    Channel_sd = 1./(dsd(i)^alpha).*fading_sd;
    Outage_3(i) = (sum(Channel_sd < max_Channel_se))./K;
    i = i + 1;
end;

alpha = 2;
Channel_se = 1./(R.^alpha).*exprnd(1,N,K);
max_Channel_se = max(Channel_se);
fading_sd = exprnd(1,1,K);
i = 1;
dsd = 0.01:0.01:1;
for i = 1:1:length(dsd)
    Channel_sd = 1./(dsd(i)^alpha).*fading_sd;
    Outage_2(i) = (sum(Channel_sd < max_Channel_se))./K;
    i = i + 1;
end;

% figure,
% plot(i,P2_N,'-','linewidth',2);
% plot(i,P3_numerical_N,'--k','linewidth',2)
% plot(i,P4_N,'-.r','linewidth',2);
plot(dsd, Outage_2,'-','linewidth',2);
plot(dsd, Outage_3,'--k','linewidth',2);
plot(dsd, Outage_4,'-.r','linewidth',2)
grid on;


radium = 1;
N = 10;
K = 1e5;
R=radium.*sqrt(rand(N,K));
alpha = 4;
Channel_se = 1./(R.^alpha).*exprnd(1,N,K);
max_Channel_se = max(Channel_se);
fading_sd = exprnd(1,1,K);
i = 1;
dsd = 0.01:0.01:1;
for i = 1:1:length(dsd)
    Channel_sd = 1./(dsd(i)^alpha).*fading_sd;
    Outage_4(i) = (sum(Channel_sd < max_Channel_se))./K;
    i = i + 1;
end;

alpha = 3;
Channel_se = 1./(R.^alpha).*exprnd(1,N,K);
max_Channel_se = max(Channel_se);
fading_sd = exprnd(1,1,K);
i = 1;
dsd = 0.01:0.01:1;
for i = 1:1:length(dsd)
    Channel_sd = 1./(dsd(i)^alpha).*fading_sd;
    Outage_3(i) = (sum(Channel_sd < max_Channel_se))./K;
    i = i + 1;
end;

alpha = 2;
Channel_se = 1./(R.^alpha).*exprnd(1,N,K);
max_Channel_se = max(Channel_se);
fading_sd = exprnd(1,1,K);
i = 1;
dsd = 0.01:0.01:1;
for i = 1:1:length(dsd)
    Channel_sd = 1./(dsd(i)^alpha).*fading_sd;
    Outage_2(i) = (sum(Channel_sd < max_Channel_se))./K;
    i = i + 1;
end;

% figure,
% plot(i,P2_N,'-','linewidth',2);
% plot(i,P3_numerical_N,'--k','linewidth',2)
% plot(i,P4_N,'-.r','linewidth',2);
plot(dsd, Outage_2,'-','linewidth',2);
plot(dsd, Outage_3,'--k','linewidth',2);
plot(dsd, Outage_4,'-.r','linewidth',2)
grid on;




