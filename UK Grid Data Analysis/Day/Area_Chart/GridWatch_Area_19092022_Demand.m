% *********************** Data Analysis: Area Chart ***********************
% *                            By LeonidasEng                             *
% *                Area Chart for Total UK Power Demand                   *
% *************************************************************************

% Area Graph for Power usage - Monday 19th September 2022 %
clear;
load("GridWatch_Data_19092022_Demand.mat");

% Preparing Data for Plot %
timestamp.Format = 'hh-mm-ss';

% Creating Area graph %
area(timestamp, demand/1000);
set(gca,'FontSize',14);
xlabel("Time (24 hrs)", "FontWeight","bold","FontSize",15);
ylabel("Power Demand in GW","FontWeight","bold","FontSize",15); 
% Great Scott!
ylim([20 32]);
grid("on");
title("UK Grid Demand in 24 hour period", "FontSize",18, ...
    "FontWeight", "bold");
%********************************* CODE ENDS ******************************