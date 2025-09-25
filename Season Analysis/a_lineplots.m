% Line plots
clear all; close all; clc;
set(groot, 'DefaultAxesFontSize', 20);                       % Axis tick labels
set(groot, 'DefaultTextFontSize', 20);                       % Text annotations

Data = readtable('1 Lineplots.csv');
Data = Data{:,:};

% Cap% from 0 to max%
capPct50 = linspace(0,50,200); capPct30 = linspace(0,30,200); capPct10 = linspace(0,10,200);

% AV = Intercept + Slope * log(Cap%), i.e. intensive margin
AV = Data(:,3) + Data(:,1) * log(capPct50);

% Rookie plots
figure; hold on; box on;
plot(capPct50,AV(1,:),'LineWidth',2);
xt = get(gca, 'XTick');
xticklabels(arrayfun(@(x) sprintf('%d%%', x), xt, 'UniformOutput', false));
xlabel('Cap\%', 'Interpreter', 'LaTeX');
ylabel('AV', 'Interpreter', 'LaTeX');
title('QB', 'Interpreter', 'LaTeX');
exportgraphics(gcf, '1 RookQB.png', 'Resolution', 300);

figure; box on;
plot(capPct50,AV(2,:),capPct50,AV(3,:),capPct50,AV(4,:),capPct50,AV(5,:),capPct50,AV(6,:),capPct50,AV(7,:),capPct50,AV(8,:),'LineWidth',2);
xt = get(gca, 'XTick');
xticklabels(arrayfun(@(x) sprintf('%d%%', x), xt, 'UniformOutput', false));
xlabel('Cap\%', 'Interpreter', 'LaTeX');
ylabel('AV', 'Interpreter', 'LaTeX');
title('Offense$-$QB', 'Interpreter', 'LaTeX');
legend("RB","WR","TE","LT","G","C","RT",'Location','northwest');
exportgraphics(gcf, '2 RookOffNonQB.png', 'Resolution', 300);

figure; box on;
plot(capPct50,AV(9,:),capPct50,AV(10,:),capPct50,AV(11,:),capPct50,AV(12,:),capPct50,AV(13,:),capPct50,AV(14,:),capPct50,AV(15,:),'LineWidth',2);
xt = get(gca, 'XTick');
xticklabels(arrayfun(@(x) sprintf('%d%%', x), xt, 'UniformOutput', false));
xlabel('Cap\%', 'Interpreter', 'LaTeX');
ylabel('AV', 'Interpreter', 'LaTeX');
title('Defense', 'Interpreter', 'LaTeX');
legend("DE","DT","ILB","OLB","CB","FS","SS",'Location','northwest');
exportgraphics(gcf, '3 RookDef.png', 'Resolution', 300);

figure; box on;
plot(capPct10,AV(16,:),capPct10,AV(17,:),capPct10,AV(18,:),'LineWidth',2);
xt = get(gca, 'XTick');
xticklabels(arrayfun(@(x) sprintf('%d%%', x), xt, 'UniformOutput', false));
xlabel('Cap\%', 'Interpreter', 'LaTeX');
ylabel('AV', 'Interpreter', 'LaTeX');
title('Special Teams', 'Interpreter', 'LaTeX');
legend("K","P","LS",'Location','northwest');
exportgraphics(gcf, '4 RookST.png', 'Resolution', 300);

% Veteran plots
figure; box on;
plot(capPct30,AV(18+1,:),'LineWidth',2);
xt = get(gca, 'XTick');
xticklabels(arrayfun(@(x) sprintf('%d%%', x), xt, 'UniformOutput', false));
xlabel('Cap\%', 'Interpreter', 'LaTeX');
ylabel('AV', 'Interpreter', 'LaTeX');
title('QB', 'Interpreter', 'LaTeX');
exportgraphics(gcf, '5 VetQB.png', 'Resolution', 300);

figure; box on;
plot(capPct30,AV(18+2,:),capPct30,AV(18+3,:),capPct30,AV(18+4,:),capPct30,AV(18+5,:),capPct30,AV(18+6,:),capPct30,AV(18+7,:),capPct30,AV(18+8,:),'LineWidth',2);
xt = get(gca, 'XTick');
xticklabels(arrayfun(@(x) sprintf('%d%%', x), xt, 'UniformOutput', false));
xlabel('Cap\%', 'Interpreter', 'LaTeX');
ylabel('AV', 'Interpreter', 'LaTeX');
title('Offense$-$QB', 'Interpreter', 'LaTeX');
legend("RB","WR","TE","LT","G","C","RT",'Location','northwest');
exportgraphics(gcf, '6 VetOffNonQB.png', 'Resolution', 300);

figure; box on;
plot(capPct30,AV(18+9,:),capPct30,AV(18+10,:),capPct30,AV(18+11,:),capPct30,AV(18+12,:),capPct30,AV(18+13,:),capPct30,AV(18+14,:),capPct30,AV(18+15,:),'LineWidth',2);
xt = get(gca, 'XTick');
xticklabels(arrayfun(@(x) sprintf('%d%%', x), xt, 'UniformOutput', false));
xlabel('Cap\%', 'Interpreter', 'LaTeX');
ylabel('AV', 'Interpreter', 'LaTeX');
title('Defense', 'Interpreter', 'LaTeX');
legend("DE","DT","ILB","OLB","CB","FS","SS",'Location','northwest');
exportgraphics(gcf, '7 VetDef.png', 'Resolution', 300);

figure; box on;
plot(capPct10,AV(18+16,:),capPct10,AV(18+17,:),capPct10,AV(18+18,:),'LineWidth',2);
xt = get(gca, 'XTick');
xticklabels(arrayfun(@(x) sprintf('%d%%', x), xt, 'UniformOutput', false));
xlabel('Cap\%', 'Interpreter', 'LaTeX');
ylabel('AV', 'Interpreter', 'LaTeX');
title('Special Teams', 'Interpreter', 'LaTeX');
legend("K","P","LS",'Location','northwest');
exportgraphics(gcf, '8 VetST.png', 'Resolution', 300);