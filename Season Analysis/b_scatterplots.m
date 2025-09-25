% Scatter plots
clear all; close all; clc;
set(groot, 'DefaultAxesFontSize', 12);                       % Axis tick labels
set(groot, 'DefaultTextFontSize', 14);                       % Text annotations

% Load data
Data = readtable('2 Scatterplots.csv');
teamNames = unique(Data.Team, 'stable');
numTeams = numel(teamNames);

% Define Color 1 and Color 2 maps
teamColorHex = containers.Map( ...
    {'Baltimore Ravens','Cincinnati Bengals','Cleveland Browns','Pittsburgh Steelers', ...
     'Buffalo Bills','Miami Dolphins','New England Patriots','New York Jets', ...
     'Houston Texans','Indianapolis Colts','Jacksonville Jaguars','Tennessee Titans', ...
     'Denver Broncos','Kansas City Chiefs','Las Vegas Raiders','Los Angeles Chargers', ...
     'Chicago Bears','Detroit Lions','Green Bay Packers','Minnesota Vikings', ...
     'Dallas Cowboys','New York Giants','Philadelphia Eagles','Washington Commanders', ...
     'Atlanta Falcons','Carolina Panthers','New Orleans Saints','Tampa Bay Buccaneers', ...
     'Arizona Cardinals','Los Angeles Rams','San Francisco 49ers','Seattle Seahawks'}, ...
    {'#241773','#FB4F14','#311D00','#FFB612', ...
     '#00338D','#008E97','#002244','#125740', ...
     '#03202F','#002C5F','#101820','#0C2340', ...
     '#FB4F14','#E31837','#000000','#0080C6', ...
     '#0B162A','#0076B6','#203731','#4F2683', ...
     '#003594','#0B2265','#004C54','#5A1414', ...
     '#A71930','#0085CA','#D3BC8D','#D50A0A', ...
     '#97233F','#003594','#AA0000','#002244'} ...
);

teamColorHex2 = containers.Map( ...
    {'Baltimore Ravens','Cincinnati Bengals','Cleveland Browns','Pittsburgh Steelers', ...
     'Buffalo Bills','Miami Dolphins','New England Patriots','New York Jets', ...
     'Houston Texans','Indianapolis Colts','Jacksonville Jaguars','Tennessee Titans', ...
     'Denver Broncos','Kansas City Chiefs','Las Vegas Raiders','Los Angeles Chargers', ...
     'Chicago Bears','Detroit Lions','Green Bay Packers','Minnesota Vikings', ...
     'Dallas Cowboys','New York Giants','Philadelphia Eagles','Washington Commanders', ...
     'Atlanta Falcons','Carolina Panthers','New Orleans Saints','Tampa Bay Buccaneers', ...
     'Arizona Cardinals','Los Angeles Rams','San Francisco 49ers','Seattle Seahawks'}, ...
    {'#000000','#000000','#FF3C00','#101820', ...
     '#C60C30','#FC4C02','#C60C30','#000000', ...
     '#A71930','#A2AAAD','#D7A22A','#4B92DB', ...
     '#002244','#FFB81C','#A5ACAF','#FFC20E', ...
     '#C83803','#B0B7BC','#FFB612','#FFC62F', ...
     '#041E42','#A71930','#A5ACAF','#FFB612', ...
     '#000000','#101820','#101820','#FF7900', ...
     '#000000','#FFA300','#B3995D','#69BE28'} ...
);

hex2rgb = @(hex) sscanf(hex(2:end),'%2x%2x%2x',[1 3])/255;

% === Offense Cap% vs Rookies Cap % ===
% Data for plot
avgRookCapPct = zeros(numTeams,1);
avgOffCapPct = zeros(numTeams,1);
avgQBCapPct = zeros(numTeams,1);
for i = 1:numTeams
    idx = strcmp(Data.Team, teamNames{i});
    avgRookCapPct(i) = 100*mean(Data.RookCapPct(idx));
    avgOffCapPct(i) = 100*mean(Data.OffCapPct(idx));
    avgQBCapPct(i) = 100*mean(Data.QBCapPct(idx));  % For marker sizing
end

% Normalize marker size, and plot data
minSize = 20;
maxSize = 200;
markerSizes = minSize + (avgQBCapPct - min(avgQBCapPct)) / (max(avgQBCapPct) - min(avgQBCapPct)) * (maxSize - minSize);
figure; hold on;
for i = 1:numTeams
    color1 = hex2rgb(teamColorHex(teamNames{i}));
    color2 = hex2rgb(teamColorHex2(teamNames{i}));
    scatter(avgRookCapPct(i), avgOffCapPct(i), ...
        markerSizes(i), 'MarkerFaceColor', color1, 'MarkerEdgeColor', color2, ...
        'LineWidth', 1, 'MarkerFaceAlpha', 0.8);
end

% Plot overall league-average point as an "x"
xRookCapPct = 100*mean(Data.RookCapPct);
xOffCapPct = 100*mean(Data.OffCapPct);
xQBCapPct = 100*mean(Data.QBCapPct);

xMarkerSize = minSize + (xQBCapPct - min(avgQBCapPct)) / (max(avgQBCapPct) - min(avgQBCapPct)) * (maxSize - minSize);
scatter(xRookCapPct, xOffCapPct, ...
    xMarkerSize, ...
    'MarkerFaceColor', '#013369', 'MarkerEdgeColor', '#D50A0A', ...
    'LineWidth', 1, 'MarkerFaceAlpha', 0.8);
dx = 0.2; dy = 0;
text(xRookCapPct + dx, xOffCapPct + dy, ...
        "NFL", 'FontSize', 9, 'FontWeight', 'bold', ...
        'Color', '#013369', 'Interpreter', 'LaTeX');

% QB Cap% size legend
legendSizes = [14, 10.5, 7];  % QB Cap %
legendMarkerSizes = minSize + (legendSizes - min(avgQBCapPct)) / (max(avgQBCapPct) - min(avgQBCapPct)) * (maxSize - minSize);
hold on;
h = zeros(1,length(legendSizes));
for j = 1:length(legendSizes)
    h(j) = plot(NaN, NaN, 'o', ...
        'MarkerFaceColor', '#013369', ...
        'MarkerEdgeColor', '#D50A0A', ...
        'LineWidth', 1, ...
        'LineStyle', 'none');
end
legendStrings = {
    '14.0% QB Cap%'
    '10.5% QB Cap%'
    '  7.0% QB Cap%'   % Adds two thin spaces for visual alignment
};
[out1, out2] = legend(h, legendStrings, 'Location', 'northeast');
set(out1, 'FontSize', 12, 'Interpreter', 'LaTeX');
out2(5).MarkerSize = sqrt(legendMarkerSizes(1));
out2(7).MarkerSize = sqrt(legendMarkerSizes(2));
out2(9).MarkerSize = sqrt(legendMarkerSizes(3));

% x and y axes
xticks(18:1:30);
xt = get(gca, 'XTick'); yt = get(gca, 'YTick');
xticklabels(arrayfun(@(x) sprintf('%d%%', x), xt, 'UniformOutput', false));
yticklabels(arrayfun(@(y) sprintf('%d%%', y), yt, 'UniformOutput', false));
xlabel('Average Rookie Cap\%', 'Interpreter', 'LaTeX');
ylabel('Average Offense Cap\%', 'Interpreter', 'LaTeX');

% Labels with custom positioning
for i = 1:numTeams
    dx = 0.2; dy = 0;
    if strcmp(teamNames{i}, 'Arizona Cardinals')
        dx = 0.2; dy = 0;
    elseif strcmp(teamNames{i}, 'Atlanta Falcons')
        dx = -1.9; dy = 0;
    elseif strcmp(teamNames{i}, 'Carolina Panthers')
        dx = -2.1; dy = 0;
    elseif strcmp(teamNames{i}, 'Cleveland Browns')
        dx = -2.1; dy = 0;
    elseif strcmp(teamNames{i}, 'Dallas Cowboys')
        dx = 0.2; dy = 0.1;
    elseif strcmp(teamNames{i}, 'Detroit Lions')
        dx = -0.5; dy = 0.3;
    elseif strcmp(teamNames{i}, 'Green Bay Packers')
        dx = -2.3; dy = 0;
    elseif strcmp(teamNames{i}, 'Jacksonville Jaguars')
        dx = -2.3; dy = 0;
    elseif strcmp(teamNames{i}, 'Minnesota Vikings')
        dx = 0.2; dy = 0.075;
    elseif strcmp(teamNames{i}, 'New England Patriots')
        dx = -2.5; dy = 0;
    elseif strcmp(teamNames{i}, 'New Orleans Saints')
        dx = 0.2; dy = 0.1;
    elseif strcmp(teamNames{i}, 'Tampa Bay Buccaneers')
        dx = -2.6; dy = 0;
    elseif strcmp(teamNames{i}, 'Tennessee Titans')
        dx = 0; dy = 0.3;
    elseif strcmp(teamNames{i}, 'Washington Commanders')
        dx = -2.9; dy = -0.1;
    end

    color1 = hex2rgb(teamColorHex(teamNames{i}));
    text(avgRookCapPct(i) + dx, avgOffCapPct(i) + dy, ...
        teamNames{i}, 'FontSize', 9, 'FontWeight', 'bold', ...
        'Color', color1, 'Interpreter', 'LaTeX');
end

% Dimensions of plot
xlim([min(avgRookCapPct)-1, max(avgRookCapPct)+1]);
ylim([min(avgOffCapPct)-1, max(avgOffCapPct)+1]);
axis square; box on;
exportgraphics(gcf, '11 ScatterCap.png', 'Resolution', 300);

% === Actual Wins vs. Compensated Wins ===
% Data for plot
avgCompWins = zeros(numTeams, 1);
avgActualWins = zeros(numTeams, 1);
for i = 1:numTeams
    idx = strcmp(Data.Team, teamNames{i});
    avgCompWins(i) = mean(Data.CompWins(idx));
    avgActualWins(i) = mean(Data.Wins(idx));
end

% Plot data
figure; hold on;
for i = 1:numTeams
    color1 = hex2rgb(teamColorHex(teamNames{i}));
    color2 = hex2rgb(teamColorHex2(teamNames{i}));
    scatter(avgCompWins(i), avgActualWins(i), ...
        50, 'MarkerFaceColor', color1, 'MarkerEdgeColor', color2, ...
        'LineWidth', 1, 'MarkerFaceAlpha', 0.8);
end

% x and y axes
xticks(7:0.5:9); yticks(5:0.5:11);
xticklabels(arrayfun(@(x) sprintf('%.1f', x), 7:0.5:9, 'UniformOutput', false));
yticklabels(arrayfun(@(y) sprintf('%.1f', y), 5:0.5:11, 'UniformOutput', false));
xlabel('Average Compensated Wins', 'Interpreter', 'LaTeX');
ylabel('Average Actual Wins', 'Interpreter', 'LaTeX');

% Plot 45 degree line
minVal = min([avgCompWins; avgActualWins]) - 0.5;
maxVal = max([avgCompWins; avgActualWins]) + 0.5;
plot([minVal, maxVal], [minVal, maxVal], 'k--', 'LineWidth', 1, 'Color', [0 0 0 0.5]);

% Labels with custom positioning
for i = 1:numTeams
    dx = 0.05; dy = 0;
    if strcmp(teamNames{i}, 'Atlanta Falcons')
        dx = -0.34; dy = 0;
    elseif strcmp(teamNames{i}, 'Baltimore Ravens')
        dx = 0.04; dy = -0.05;
    elseif strcmp(teamNames{i}, 'Buffalo Bills')
        dx = 0.04; dy = -0.05;
    elseif strcmp(teamNames{i}, 'Chicago Bears')
        dx = 0.04; dy = -0.05;
    elseif strcmp(teamNames{i}, 'Cincinnati Bengals')
        dx = 0.05; dy = -0.05;
    elseif strcmp(teamNames{i}, 'Houston Texans')
        dx = -0.34; dy = 0;
    elseif strcmp(teamNames{i}, 'Los Angeles Chargers')
        dx = -0.44; dy = 0.09;
    elseif strcmp(teamNames{i}, 'Miami Dolphins')
        dx = 0.03; dy = -0.1;
    elseif strcmp(teamNames{i}, 'New England Patriots')
        dx = -0.45; dy = 0;
    elseif strcmp(teamNames{i}, 'Philadelphia Eagles')
        dx = -0.4; dy = 0.05;
    elseif strcmp(teamNames{i}, 'Seattle Seahawks')
        dx = 0.04; dy = 0.1;
    elseif strcmp(teamNames{i}, 'Tampa Bay Buccaneers')
        dx = 0.04; dy = -0.08;
    elseif strcmp(teamNames{i}, 'Tennessee Titans')
        dx = -0.37; dy = 0;
    end

    color1 = hex2rgb(teamColorHex(teamNames{i}));
    text(avgCompWins(i) + dx, avgActualWins(i) + dy, ...
        teamNames{i}, 'FontSize', 9, 'FontWeight', 'bold', ...
        'Color', color1, 'Interpreter', 'LaTeX');
end

% Dimensions of plot
xlim([min(avgCompWins)-0.25, max(avgCompWins)+0.25]);
ylim([min(avgActualWins)-0.25, max(avgActualWins)+0.25]);
axis square; box on;

% Compute correlation coefficient
R = corr(avgCompWins, avgActualWins);
signStr = '';
if R < 0
    signStr = '-';
end
formattedR = sprintf('%s.%04d', signStr, round(abs(R)*10000));

% Create the text object (initial placement will be updated immediately)
t = text(0, 0, sprintf('$\\rho = %s$', formattedR), ...
    'Interpreter', 'latex', ...
    'FontSize', 12, ...
    'FontWeight', 'bold', ...
    'BackgroundColor', 'w', ...
    'EdgeColor', 'k', ...
    'HorizontalAlignment', 'right', ...
    'VerticalAlignment', 'top', ...
    'Margin', 4);

% Function to update position based on current axis limits
function updateRhoPosition(ax, tObj)
    xl = xlim(ax);
    yl = ylim(ax);
    xOffset = 0.03 * range(xl);  % 3% from right
    yOffset = 0.03 * range(yl);  % 3% from top
    tObj.Position = [xl(2) - xOffset, yl(2) - yOffset];
end

% Call it once to set the initial position
updateRhoPosition(gca, t);

% Attach automatic updating for zoom, pan, or resize
axHandle = gca;
addlistener(axHandle, 'MarkedClean', @(~,~) updateRhoPosition(axHandle, t));
set(gcf, 'SizeChangedFcn', @(~,~) updateRhoPosition(axHandle, t));
exportgraphics(gcf, '12 ScatterWins.png', 'Resolution', 300);