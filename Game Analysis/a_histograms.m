% Histograms

clear all; close all; clc;
set(groot, 'DefaultAxesFontSize', 14);                       % Axis tick labels
set(groot, 'DefaultTextFontSize', 14);                       % Text annotations
set(gcf, 'Units', 'inches', 'Position', [1 1 8 6]);          % 4 by 3 ratio

Data = readtable('1 ME Histograms.csv'); % import data
Data = Data{:,:}; % convert to matrix
Data(Data(:,1)==0,:) = [];
Data = Data(:,2:end);

Rate = Data(:,1:2); ANYA = Data(:,3:4); TANYA = Data(:,5:6); FPA = Data(:,7:8);
RateGame = Rate(:,1); RateSeason = Rate(:,2);
ANYAGame = ANYA(:,1); ANYASeason = ANYA(:,2);
TANYAGame = TANYA(:,1); TANYASeason = TANYA(:,2);
FPAGame = FPA(:,1); FPASeason = FPA(:,2);

HistoRateGame = histogram(RateGame,30);
xlim([0,0.02]); ylim([0,1400]);
xticks([0 0.005 0.01 0.015 0.02]);
xticklabels({'0.000' '0.005' '0.010' '0.015' '0.020'});
xlabel('Game Passer Rating', 'Interpreter', 'LaTeX');
AMERateGame = mean(RateGame); SDMERateGame = std(RateGame); MinMERateGame = min(RateGame); MaxMERateGame = max(RateGame);
text(0.015,1250,sprintf("AME = "+sprintfc('%0.4f',AMERateGame)+"\nSDME = "+sprintfc('%0.4f',SDMERateGame)+"\nMinME = "+sprintfc('%0.4f',MinMERateGame)+"\nMaxME = "+sprintfc('%0.4f',MaxMERateGame)), 'Interpreter', 'LaTeX');
saveas(HistoRateGame,'1 HistoRateGame.png');

HistoRateSeason = histogram(RateSeason,30);
xlim([0,0.02]); ylim([0,1400]);
xticks([0 0.005 0.01 0.015 0.02]);
xticklabels({'0.000' '0.005' '0.010' '0.015' '0.020'});
xlabel('Season Passer Rating', 'Interpreter', 'LaTeX');
AMERateSeason = mean(RateSeason); SDMERateSeason = std(RateSeason); MinMERateSeason = min(RateSeason); MaxMERateSeason = max(RateSeason);
text(0.015,1250,sprintf("AME = "+sprintfc('%0.4f',AMERateSeason)+"\nSDME = "+sprintfc('%0.4f',SDMERateSeason)+"\nMinME = "+sprintfc('%0.4f',MinMERateSeason)+"\nMaxME = "+sprintfc('%0.4f',MaxMERateSeason)), 'Interpreter', 'LaTeX');
saveas(HistoRateSeason,'2 HistoRateSeason.png');

HistoANYAGame = histogram(ANYAGame,30);
xlim([0,0.2]); ylim([0,1400]);
xticks([0 0.05 0.1 0.15 0.2]);
xticklabels({'0.00' '0.05' '0.10' '0.15' '0.20'});
xlabel('Game ANY/A', 'Interpreter', 'LaTeX');
AMEANYAGame = mean(ANYAGame); SDMEANYAGame = std(ANYAGame); MinMEANYAGame = min(ANYAGame); MaxMEANYAGame = max(ANYAGame);
text(0.15,1250,sprintf("AME = "+sprintfc('%0.4f',AMEANYAGame)+"\nSDME = "+sprintfc('%0.4f',SDMEANYAGame)+"\nMinME = "+sprintfc('%0.4f',MinMEANYAGame)+"\nMaxME = "+sprintfc('%0.4f',MaxMEANYAGame)), 'Interpreter', 'LaTeX');
saveas(HistoANYAGame,'3 HistoANYAGame.png');

HistoANYASeason = histogram(ANYASeason,30);
xlim([0,0.2]); ylim([0,1400]);
xticks([0 0.05 0.1 0.15 0.2]);
xticklabels({'0.00' '0.05' '0.10' '0.15' '0.20'});
xlabel('Season ANY/A', 'Interpreter', 'LaTeX');
AMEANYASeason = mean(ANYASeason); SDMEANYASeason = std(ANYASeason); MinMEANYASeason = min(ANYASeason); MaxMEANYASeason = max(ANYASeason);
text(0.15,1250,sprintf("AME = "+sprintfc('%0.4f',AMEANYASeason)+"\nSDME = "+sprintfc('%0.4f',SDMEANYASeason)+"\nMinME = "+sprintfc('%0.4f',MinMEANYASeason)+"\nMaxME = "+sprintfc('%0.4f',MaxMEANYASeason)), 'Interpreter', 'LaTeX');
saveas(HistoANYASeason,'4 HistoANYASeason.png');

HistoTANYAGame = histogram(TANYAGame,30);
xlim([0,0.2]); ylim([0,1400]);
xticks([0 0.05 0.1 0.15 0.2]);
xticklabels({'0.00' '0.05' '0.10' '0.15' '0.20'});
xlabel('Game TANY/A', 'Interpreter', 'LaTeX');
AMETANYAGame = mean(TANYAGame); SDMETANYAGame = std(TANYAGame); MinMETANYAGame = min(TANYAGame); MaxMETANYAGame = max(TANYAGame);
text(0.15,1250,sprintf("AME = "+sprintfc('%0.4f',AMETANYAGame)+"\nSDME = "+sprintfc('%0.4f',SDMETANYAGame)+"\nMinME = "+sprintfc('%0.4f',MinMETANYAGame)+"\nMaxME = "+sprintfc('%0.4f',MaxMETANYAGame)), 'Interpreter', 'LaTeX');
saveas(HistoTANYAGame,'5 HistoTANYAGame.png');

HistoTANYASeason = histogram(TANYASeason,30);
xlim([0,0.2]); ylim([0,1400]);
xticks([0 0.05 0.1 0.15 0.2]);
xticklabels({'0.00' '0.05' '0.10' '0.15' '0.20'});
xlabel('Season TANY/A', 'Interpreter', 'LaTeX');
AMETANYASeason = mean(TANYASeason); SDMETANYASeason = std(TANYASeason); MinMETANYASeason = min(TANYASeason); MaxMETANYASeason = max(TANYASeason);
text(0.15,1250,sprintf("AME = "+sprintfc('%0.4f',AMETANYASeason)+"\nSDME = "+sprintfc('%0.4f',SDMETANYASeason)+"\nMinME = "+sprintfc('%0.4f',MinMETANYASeason)+"\nMaxME = "+sprintfc('%0.4f',MaxMETANYASeason)), 'Interpreter', 'LaTeX');
saveas(HistoTANYASeason,'6 HistoTANYASeason.png');

HistoFPAGame = histogram(FPAGame,30);
xlim([0,2]); ylim([0,1400]);
xticks([0 0.5 1 1.5 2]);
xticklabels({'0.0' '0.5' '1.0' '1.5' '2.0'});
xlabel('Game FP/A', 'Interpreter', 'LaTeX');
AMEFPAGame = mean(FPAGame); SDMEFPAGame = std(FPAGame); MinMEFPAGame = min(FPAGame); MaxMEFPAGame = max(FPAGame);
text(1.5,1250,sprintf("AME = "+sprintfc('%0.4f',AMEFPAGame)+"\nSDME = "+sprintfc('%0.4f',SDMEFPAGame)+"\nMinME = "+sprintfc('%0.4f',MinMEFPAGame)+"\nMaxME = "+sprintfc('%0.4f',MaxMEFPAGame)), 'Interpreter', 'LaTeX');
saveas(HistoFPAGame,'7 HistoFPAGame.png');

HistoFPASeason = histogram(FPASeason,30);
xlim([0,2]); ylim([0,1400]);
xticks([0 0.5 1 1.5 2]);
xticklabels({'0.0' '0.5' '1.0' '1.5' '2.0'});
xlabel('Season FP/A', 'Interpreter', 'LaTeX');
AMEFPASeason = mean(FPASeason); SDMEFPASeason = std(FPASeason); MinMEFPASeason = min(FPASeason); MaxMEFPASeason = max(FPASeason);
text(1.5,1250,sprintf("AME = "+sprintfc('%0.4f',AMEFPASeason)+"\nSDME = "+sprintfc('%0.4f',SDMEFPASeason)+"\nMinME = "+sprintfc('%0.4f',MinMEFPASeason)+"\nMaxME = "+sprintfc('%0.4f',MaxMEFPASeason)), 'Interpreter', 'LaTeX');
saveas(HistoFPASeason,'8 HistoFPASeason.png');