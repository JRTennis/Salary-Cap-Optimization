% Simulations

clear all; close all; clc;
set(groot, 'DefaultAxesFontSize', 14);                       % Axis tick labels
set(groot, 'DefaultTextFontSize', 14);                       % Text annotations

data = readtable('3 Simulations.xlsx'); % import data
data = data{:,:}; % convert to matrix

Type = 2;
if Type == 1
    data = data(:,1:8);
elseif Type == 2
    data = data(:,10:17);
end

Mean = zeros(1,8);
SD = zeros(1,8);
Min = zeros(1,8);
Max = zeros(1,8);
for i = 1:8
    Mean(i) = mean(data(:,i));
    SD(i) = std(data(:,i));
    Min(i) = min(data(:,i));
    Max(i) = max(data(:,i));
end

set(gcf, 'Units', 'inches', 'Position', [1 1 8 6]);
h1 = histogram(data(:,1),'FaceColor','#D50A0A');
hold on;
h2 = histogram(data(:,2),'FaceColor','#34302B');
hold off;
xlim([0,16]);
xlabel('Wins (2019 Tampa Bay Buccaneers)', 'Interpreter', 'LaTeX');
legend({'Baseline','Counterfactual'});
if Type == 1
    ylim([0,5500]);
    text(0.5,2750,sprintf("Baseline:"+"\nMean = "+sprintfc('%0.4f',Mean(1))+"\nSD = "+sprintfc('%0.4f',SD(1))+"\nMin = "+sprintfc('%0.0f',Min(1))+"\nMax = "+sprintfc('%0.0f',Max(1))), 'Interpreter', 'LaTeX');
    text(12,2750,sprintf("Counterfactual:"+"\nMean = "+sprintfc('%0.4f',Mean(2))+"\nSD = "+sprintfc('%0.4f',SD(2))+"\nMin = "+sprintfc('%0.0f',Min(2))+"\nMax = "+sprintfc('%0.0f',Max(2))), 'Interpreter', 'LaTeX');
    saveas(h1,'10 2019_Buccaneers_game.png');
elseif Type == 2
    ylim([0,4500]);
    text(0.5,2250,sprintf("Baseline:"+"\nMean = "+sprintfc('%0.4f',Mean(1))+"\nSD = "+sprintfc('%0.4f',SD(1))+"\nMin = "+sprintfc('%0.0f',Min(1))+"\nMax = "+sprintfc('%0.0f',Max(1))), 'Interpreter', 'LaTeX');
    text(12,2250,sprintf("Counterfactual:"+"\nMean = "+sprintfc('%0.4f',Mean(2))+"\nSD = "+sprintfc('%0.4f',SD(2))+"\nMin = "+sprintfc('%0.0f',Min(2))+"\nMax = "+sprintfc('%0.0f',Max(2))), 'Interpreter', 'LaTeX');
    saveas(h1,'11 2019_Buccaneers_season.png');
end

figure;
set(gcf, 'Units', 'inches', 'Position', [1 1 8 6]);
h3 = histogram(data(:,3),'FaceColor','#773141');
hold on;
h4 = histogram(data(:,4),'FaceColor','#FFB612');
hold off;
xlim([0,16]);
xlabel('Wins (2019 Washington Redskins)', 'Interpreter', 'LaTeX');
legend({'Baseline','Counterfactual'});
if Type == 1
    ylim([0,5500]);
    text(8,2750,sprintf("Baseline:"+"\nMean = "+sprintfc('%0.4f',Mean(3))+"\nSD = "+sprintfc('%0.4f',SD(3))+"\nMin = "+sprintfc('%0.0f',Min(3))+"\nMax = "+sprintfc('%0.0f',Max(3))), 'Interpreter', 'LaTeX');
    text(12,2750,sprintf("Counterfactual:"+"\nMean = "+sprintfc('%0.4f',Mean(4))+"\nSD = "+sprintfc('%0.4f',SD(4))+"\nMin = "+sprintfc('%0.0f',Min(4))+"\nMax = "+sprintfc('%0.0f',Max(4))), 'Interpreter', 'LaTeX');
    saveas(h3,'12 2019_Redskins_game.png');
elseif Type == 2
    ylim([0,4500]);
    text(8,2250,sprintf("Baseline:"+"\nMean = "+sprintfc('%0.4f',Mean(3))+"\nSD = "+sprintfc('%0.4f',SD(3))+"\nMin = "+sprintfc('%0.0f',Min(3))+"\nMax = "+sprintfc('%0.0f',Max(3))), 'Interpreter', 'LaTeX');
    text(12,2250,sprintf("Counterfactual:"+"\nMean = "+sprintfc('%0.4f',Mean(4))+"\nSD = "+sprintfc('%0.4f',SD(4))+"\nMin = "+sprintfc('%0.0f',Min(4))+"\nMax = "+sprintfc('%0.0f',Max(4))), 'Interpreter', 'LaTeX');
    saveas(h3,'13 2019_Redskins_season.png');
end

figure;
set(gcf, 'Units', 'inches', 'Position', [1 1 8 6]);
h5 = histogram(data(:,5),'FaceColor','#FB4F14');
hold on;
h6 = histogram(data(:,6),'FaceColor','#002244');
hold off;
xlim([0,16]);
xlabel('Wins (2015 Denver Broncos)', 'Interpreter', 'LaTeX');
legend({'Baseline','Counterfactual'});
if Type == 1
    ylim([0,5500]);
    text(0.5,2750,sprintf("Baseline:"+"\nMean = "+sprintfc('%0.4f',Mean(5))+"\nSD = "+sprintfc('%0.4f',SD(5))+"\nMin = "+sprintfc('%0.0f',Min(5))+"\nMax = "+sprintfc('%0.0f',Max(5))), 'Interpreter', 'LaTeX');
    text(4.5,2750,sprintf("Counterfactual:"+"\nMean = "+sprintfc('%0.4f',Mean(6))+"\nSD = "+sprintfc('%0.4f',SD(6))+"\nMin = "+sprintfc('%0.0f',Min(6))+"\nMax = "+sprintfc('%0.0f',Max(6))), 'Interpreter', 'LaTeX');
    saveas(h5,'14 2015_Broncos_game.png');
elseif Type == 2
    ylim([0,4500]);
    text(0.5,2250,sprintf("Baseline:"+"\nMean = "+sprintfc('%0.4f',Mean(5))+"\nSD = "+sprintfc('%0.4f',SD(5))+"\nMin = "+sprintfc('%0.0f',Min(5))+"\nMax = "+sprintfc('%0.0f',Max(5))), 'Interpreter', 'LaTeX');
    text(4.5,2250,sprintf("Counterfactual:"+"\nMean = "+sprintfc('%0.4f',Mean(6))+"\nSD = "+sprintfc('%0.4f',SD(6))+"\nMin = "+sprintfc('%0.0f',Min(6))+"\nMax = "+sprintfc('%0.0f',Max(6))), 'Interpreter', 'LaTeX');
    saveas(h5,'15 2015_Broncos_season.png');
end

figure;
set(gcf, 'Units', 'inches', 'Position', [1 1 8 6]);
h7 = histogram(data(:,7),'FaceColor','#97233F');
hold on;
h8 = histogram(data(:,8),'FaceColor','#000000');
hold off;
xlim([0,16]);
xlabel('Wins (2014 Arizona Cardinals)', 'Interpreter', 'LaTeX');
legend({'Baseline','Counterfactual'});
if Type == 1
    ylim([0,5500]);
    text(0.5,2750,sprintf("Baseline:"+"\nMean = "+sprintfc('%0.4f',Mean(7))+"\nSD = "+sprintfc('%0.4f',SD(7))+"\nMin = "+sprintfc('%0.0f',Min(7))+"\nMax = "+sprintfc('%0.0f',Max(7))), 'Interpreter', 'LaTeX');
    text(4.5,2750,sprintf("Counterfactual:"+"\nMean = "+sprintfc('%0.4f',Mean(8))+"\nSD = "+sprintfc('%0.4f',SD(8))+"\nMin = "+sprintfc('%0.0f',Min(8))+"\nMax = "+sprintfc('%0.0f',Max(8))), 'Interpreter', 'LaTeX');
    saveas(h7,'16 2014_Cardinals_game.png');
elseif Type == 2
    ylim([0,4500]);
    text(0.5,2250,sprintf("Baseline:"+"\nMean = "+sprintfc('%0.4f',Mean(7))+"\nSD = "+sprintfc('%0.4f',SD(7))+"\nMin = "+sprintfc('%0.0f',Min(7))+"\nMax = "+sprintfc('%0.0f',Max(7))), 'Interpreter', 'LaTeX');
    text(4.5,2250,sprintf("Counterfactual:"+"\nMean = "+sprintfc('%0.4f',Mean(8))+"\nSD = "+sprintfc('%0.4f',SD(8))+"\nMin = "+sprintfc('%0.0f',Min(8))+"\nMax = "+sprintfc('%0.0f',Max(8))), 'Interpreter', 'LaTeX');
    saveas(h7,'17 2014_Cardinals_season.png');
end