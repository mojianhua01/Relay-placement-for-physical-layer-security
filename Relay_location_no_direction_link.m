% Numerically find the optimal relay position and plot two-dimensional contours.
clc
clear;
close all;
gamma = 4;
xe = 1/2;
ye = 1/2;
e=(-1/2:0.002:1);
f=(-1/2:0.002:ye+1);
[x y] = meshgrid(e,f);

% e=(0.45:0.00001:0.46);
% f=(-0.1:0.00001:-0.09);
% [x y] = meshgrid(e,f);

dse = sqrt(xe.^2+ye.^2);
dsr = sqrt(x.^2+y.^2);
dre = sqrt((x-xe).^2+(y-ye).^2);
drd = sqrt((x-1).^2+y.^2);
numerator = dse.^gamma.*dre.^gamma;
denominator = (sqrt((dsr.^gamma+dse.^gamma).*(drd.^gamma+dre.^gamma)) + sqrt(dsr.^gamma.*drd.^gamma)).^2;
P_out_DF = 1- numerator./denominator;

% subplot(1,2,1)
figure,
% contourf(x , y, P_out_DF, [0 : 0.1:0.9])
% colormap(jet);
% colorbar;

plot(0,0,'sr','MarkerSize',8,'MarkerFaceColor','r');
hold on;
plot(1,0,'^r','MarkerSize',8,'MarkerFaceColor','r');
[c_1 d_1]=find(P_out_DF==min(min(P_out_DF)));

plot(xe,ye,'dr','MarkerSize',8,'MarkerFaceColor','r');
plot(e(d_1),f(c_1),'.r','MarkerSize',20,'MarkerFaceColor','r');
[C h] = contour(x,y,P_out_DF);
clabel(C,h);
% legend('P_{out}^{DF}','source', 'destination','eavesdropper','optimal relay',2)
h = legend('Source', 'Destination','Eavesdropper','Optimal Relay',2);
set(h,'fontsize',12);
% xlabel('$x$','interpreter','latex');
% ylabel('$y$','interpreter','latex');
axis([-1/2 1 -1/2 ye]);
% title('$P_{out}^{DF}$','interpreter','latex','fontsize',12);
% axis equal;
axis square;
  set(gca, 'Position', get(gca, 'OuterPosition') - ... 
      get(gca, 'TightInset') * [-1 0 1 0; 0 -1 0 1; 0 0 1 0; 0 0 0 1]); 

P_out_RF = 1 - (xe^2 + ye^2)^(gamma/2)./((xe^2 + ye^2)^(gamma/2) + (x.^2 + y.^2).^(gamma/2)).*...
     ((x-xe).^2 + (y-ye).^2).^(gamma/2)./( ((x-xe).^2 + (y-ye).^2).^(gamma/2) + ((x-1).^2 + (y).^2).^(gamma/2) );

figure,
 % subplot(1,2,2);
plot(0,0,'sr','MarkerSize',8,'MarkerFaceColor','r');
hold on;
plot(1,0,'^r','MarkerSize',8,'MarkerFaceColor','r');
[c_2 d_2]=find(P_out_RF==min(min(P_out_RF)));
plot(xe,ye,'dr','MarkerSize',8,'MarkerFaceColor','r');
plot(e(d_2),f(c_2),'.r','MarkerSize',20,'MarkerFaceColor','r');
[C h] = contour(x,y,P_out_RF);
clabel(C,h);
% legend('P_{out}^{RF}','source', 'destination','eavesdropper','optimal relay',2)
% legend('P_{out}','source', 'destination','eavesdropper','optimal relay',-1)
% xlabel('$x$','interpreter','latex');
% ylabel('$y$','interpreter','latex');
axis([-1/2 1 -1/2 ye]);
% title('$P_{out}^{RF}$','interpreter','latex','fontsize',12);
% axis equal;
axis square;
  set(gca, 'Position', get(gca, 'OuterPosition') - ... 
      get(gca, 'TightInset') * [-1 0 1 0; 0 -1 0 1; 0 0 1 0; 0 0 0 1]); 
min(min(P_out_DF))
min(min(P_out_RF))



