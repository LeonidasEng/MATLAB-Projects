% *************************** Data Analysis *******************************
% *                          By LeonidasEng                               *
% *                      Demand & Average Energy                          *
% *************************************************************************
%  Monday 15th August to 22nd August 2022

clear;
% Cleaned Data for time period %
load("GridWatch_Data_15082022_22082022.mat");

% Creating the required data %
date = 1:length(timestamp);
date = transpose(date);

% Creating Averages % 
day_sample = 288; % 5 minute data point * 288 = 1 day
n = numel(demand); % Number of Array Elements in Demand
sub_vector = mat2cell(demand,diff([0:day_sample:n-1,n])); 
% creates 1 day subvectors in a cell array and finds the mean for each
MeanCat = cellfun(@mean, sub_vector);

Days = {'Monday', 'Tuesday', 'Wednesday', 'Thursday', ...
      'Friday', 'Saturday', 'Sunday'};

% Creating plot of Week vs Demand %
figure(1);
ax = gca;
plot(date/288, demand/1000);
hold("on");
daytick = 0.5:1:6.5; % For overlay of bar chart
% Bar Chart overlay shows Mean Demand for each day
Bar_Chart = bar(daytick, MeanCat/1000,'BarWidth',0.4, ...
    'FaceColor', "#D95319",'FaceAlpha',0.75);

% Labels %
xlabel("15th August - 22nd August 2022", "FontWeight","bold", ...
    "FontSize", 12);
ylabel("Power Demand in GW", "FontWeight","bold","FontSize",14);
lim = [0 7 20 34];
title("UK Power Demand in a Week Period", "FontSize",18, ...
    "FontWeight","bold");
xticks(daytick);
xticklabels(Days);
axis(lim);
set(gca,'FontSize',14);
hold("off"); 
%********************************* CODE ENDS ******************************



