% Numerically find the optimal relay position and plot two-dimensional contours.
clc
clear;
close all;
gamma_range = 2:1:4;
ye_position_range = 1:0.5:10;
for j = 1:1:length(gamma_range)
    gamma = gamma_range(j);
    e=(0.25:0.005:0.75);
    f=(-0.3:0.005:0);
    [x y] = meshgrid(e,f);
    
    
    for i=1:1:length(ye_position_range)
        xe = 0;
        ye = ye_position_range(i);
        
        dse = sqrt(xe.^2+ye.^2);
        dsr = sqrt(x.^2+y.^2);
        dre = sqrt((x-xe).^2+(y-ye).^2);
        drd = sqrt((x-1).^2+y.^2);
        dsd = 1;
        P_out_direct(j,i) = dsd^gamma./(dsd^gamma + dse^gamma);
        numerator = dse.^gamma.*dre.^gamma;
        denominator = (sqrt((dsr.^gamma+dse.^gamma).*(drd.^gamma+dre.^gamma)) + sqrt(dsr.^gamma.*drd.^gamma)).^2;
        P_out_DF = 1- numerator./denominator;
        
        P_out_DF_min(j,i) = min(min(P_out_DF));
        [c_1 d_1]=find(P_out_DF==min(min(P_out_DF)));
        
        DF_position(j,i,:) = [e(d_1),f(c_1)];
        Distance_DF(j,i)= sqrt((e(d_1)-1/2)^2 + f(c_1)^2);
        
        P_out_RF = 1 - (xe^2 + ye^2)^(gamma/2)./((xe^2 + ye^2)^(gamma/2) + (x.^2 + y.^2).^(gamma/2)).*...
            ((x-xe).^2 + (y-ye).^2).^(gamma/2)./( ((x-xe).^2 + (y-ye).^2).^(gamma/2) + ((x-1).^2 + (y).^2).^(gamma/2) );
        P_out_RF_min(j,i) = min(min(P_out_RF));
        [c_2 d_2]=find(P_out_RF==min(min(P_out_RF)));
        RF_position(j,i,:) = [e(d_2),f(c_2)];
        Distance_RF(j,i)= sqrt((e(d_2)-1/2)^2 + f(c_2)^2);
    end;
end;
figure;
h1 = semilogy(ye_position_range,P_out_direct,'-b+','linewidth',2);
hold on;
h2 = semilogy(ye_position_range, P_out_DF_min,'-ks','linewidth',2);
h3 = semilogy(ye_position_range, P_out_RF_min,'-r^','linewidth',2);
% semilogy(ye_position_range, -Distance_DF);
% semilogy(ye_position_range, -Distance_RF);
grid on;

h = legend([h1(1), h2(1) ,h3(1)],{'$P_{Direct}(\textbf{d})$','$P_{DF}(\textbf{d})$','$P_{RF}(\textbf{d})$'},'Interpreter','latex',0);
set(h,'fontsize',12);
xlabel('$$Eavesdropper\ position\ (0,1)\rightarrow(0,10)$$','Interpreter','latex','fontsize',12);
ylabel('$Outage\ Probability$','Interpreter','latex','fontsize',12)

% [AX,H1,H2] = plotyy(ye_position_range, [log(P_out_DF_min); log(P_out_RF_min) ], ye_position_range, [-Distance_DF; -Distance_RF])
%
% % set(AX(1),'XTick',[2:0.5:4]);
% % set(AX(2),'XTick',[2:0.5:4]);
%
% set(get(AX(1),'Ylabel'),'String','$Minimal Outage probability$','Interpreter','latex','fontsize',14)
% set(get(AX(2),'Ylabel'),'String','$The distance between best relay position and point(1/2,0) $','Interpreter','latex','fontsize',14)
%
%
% xlabel('coordinate of eavesdropper','fontsize',14);
% grid on;
% set(H1(1),'LineStyle','-', 'Marker','o','Linewidth',2)
% set(H1(2),'LineStyle','-','Marker','s','Linewidth',2)
% set(H2(1),'LineStyle', '--', 'Marker','o','Linewidth',2 )
% set(H2(2),'LineStyle','--', 'Marker','s','Linewidth',2)
% legend({'$P_{DF}$','$P_{RF}$','$D_{DF}$','$D_{RF}$'},'Interpreter','latex',0)

