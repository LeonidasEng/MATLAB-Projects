% ************************ Statistical Anaylsis ***************************
% *                           By LeonidasEng                              *
% *       Statistical analysis of annual daily temperatures for 2019      * 
% *************************************************************************

clear;
clc;
% This file requires Daily_Temps.mat be accessible to run.
load("Daily_Temps.mat"); % Loads the Daily Temps file into the workspace.

% Mean temps %
% Identifies mean for each column omitting NaN values for missing days:
mu = mean(Year_2019_Daily_Temp, 1, "omitnan"); 
disp("The mean for each month is:");
disp(mu);

% Month with highest mean temp %
[M, a] = max(mu); % Finds max of mean from each month and displays which month it is.
MaxMean = sprintf("The highest mean temperature was: %f°C for the %dth month, July.", M,a);
disp(MaxMean)

% Month with the most Variance %
% Calcuate variance using "var" function nested inside "max" to find most
% variance:
[V, b]=max(var(Year_2019_Daily_Temp,0,1, "omitnan"));
MaxVar = sprintf("The %dth month, April had the most variance with a value of %f°C.", b,V);
disp(MaxVar);

% Calculation of Stability %
% Stability must be the element with least variance, can use the "min" function: 
[S, c]=min(var(Year_2019_Daily_Temp,0,1, "omitnan"));
Stab = sprintf("The %drd month, March was the most stable with only a variance of %f°C.",c,S);
disp(Stab);

% Total Annual Mean %
% Calculate total mean for all elements by using the "all" option 
% (omitting NaN values):
Mu = mean(Year_2019_Daily_Temp,"all","omitnan");
ToMu = sprintf("The daily mean of all temperatures for the year is %f°C.", Mu);
disp(ToMu);

% Standard Deviation %
% Calculate the standard deviation for the year using the "std" function: 
sig = std(Year_2019_Daily_Temp,0,"all","omitnan");
sigma = sprintf("The standard deviation for annual temperatures is %f°C.", sig);
disp(sigma);

% Temps < 10°C %
% Find all elements below a temp by using a condition to produce a
% logical matrix, then combine all "trues" to work out the number of
% values below 10°C:
trues = sum(Year_2019_Daily_Temp < 10,"all","omitnan");
Cool = sprintf("The number of days that were cooler than 10°C were %d.", trues);
disp(Cool);

% Annual Median Temperature %
% Calculate the median by using the "median" function making sure include
% all values and omit non-numbers:
med = median(Year_2019_Daily_Temp,"all","omitnan");
Med = sprintf("The annual median temperature is %.1f°C.", med);
disp(Med);
%********************************* CODE ENDS ******************************


