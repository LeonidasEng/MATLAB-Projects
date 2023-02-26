% ************************ Deflection Program *****************************
% *                          By LeonidasEng                               *
% *        This calculates the max deflection of a wind turbine           * 
% *************************************************************************
clear;
% First, enter deflect into Command Window

% Surpress Warning - Related to performance does not prevent execution
warning('off');
%warning % Debug

% User input, any input can now be entered %
prompt = "What is the required length? (m)"; %  Prompts user for input
L_input = input(prompt);                     %  User Inputs required length
L = L_input;
%disp(L); % Debug
 
% Variables and Calculations %
W = 8500;               %  Max Load (N)
E = 4.2e10;             %  Mod of Elasticitiy (N/m^2)
I = 1e-5;               %  Moment of Inertia (m^4)
DeltaFun = @(L) (W*L.^3)/(8*E*I);   %  Function (Anon) for Delta
Del = DeltaFun(L);                  %  DeltaFun assigned to variable Del 
disp("Solution for Delta (m):")
disp(Del);

% Logic to determine maximum deflection within acceptable parameters %
if Del/L > 0.1
    disp("The maximum deflection will be exceeded");
else
    disp("Maximum deflection is tolerable");
end

% 10% of Delta sent to output in Command Window %
disp("10% of Delta (m):");
Del = Del/10;           %  Divides Delta by 10 = 10%
disp(Del);

% Calculate Maximum Tolerance for Delta %
% Max length of material with a deflection of 10% of Length
% 1m to 10m (range is only for plot)

% Can display the Max as Delta/L as L = sqrt((0.8*E*I)/W) but one can
% also achieve the same thing using fzero function:
disp("Maximum Tolerance for Delta (m)");
MaxL = fzero(@(L) DeltaFun(L)/L-0.1,[1 10]);
% Divide by L to get the ratio Delta/L Deflection per Length.
% 0.1 is required so this is the threshold.
% To find the root subtract 0.1 to get the maximum value at 10%

disp(MaxL);                   % Shows the max tolerance in meters


% Plot of the function %
% Plots the function to see clearly where the max is:
fplot(@(L) DeltaFun(L)/L, [1 10],"blue"); % Plots function
line(xlim,[0.1 0.1], 'Color', 'black','LineStyle', '--'); % Plots threshold
hold on % Allows for multiple plots on same figure
plot(MaxL,0.1,'Marker','o'); % Shows Max
hold off

% Labels for Plot %
xlabel("Blade Length (m)");
ylabel("Deflection of Blade (\Delta/L)")
title("Maximum Deflection of a Wind Turbine Blade")
ax = gca;
chart = ax.Children(1);
datatip(chart,MaxL,0.1);    % Displays data point of the max
%********************************* CODE ENDS ******************************