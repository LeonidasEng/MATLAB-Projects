% **************************** Ball Impact ********************************
% *                           By LeonidasEng                              *
% *      Calculates the energy of a ball's impact falling from height     * 
% *************************************************************************

clear;
clc;
% Generates the data and stores in table %
x = [0 0.1 0.2 0.5 0.8 1.5 2 3 4 5.5 7 8.5 12 15 25]'; 
E = [0 0.06 0.24 1.5 3.84 13.5 24 54 96 181.5 294 433.5 864 1350 3750]';
data=table(x,E, 'VariableNames',{'x','E'});

% Scatter Plot of Data points from table %
figure(1);
scatter(data.x,data.E,50,"filled", "o", ...
    "MarkerEdgeColor", "#0072BD", ...
    "MarkerFaceColor", "#4DBEEE",...
    "LineWidth", 1, ...
    "MarkerFaceAlpha", 0.5, ...
    "MarkerEdgeAlpha",1);               % Set multiple settings quickly
set(gca, "FontSize", 10);               % Set Current Axes
xlabel("Velocity (m/s)");               % Velocity
ylabel("Energy (J)");
title("Ball falling from various heights");
grid("minor");
grid("on");
legend("Energy","Location","northwest","FontSize", 10);

% Finding the Polynomial Coefficients %
[Pr2]=polyfit(data.x, data.E,2);        % Least Squares, 2nd Order

%Calculating Polynomial Data %
dataFit = polyval(Pr2, data.x);         % Line of Best fit
acoeff = round(Pr2(1));                 % 1st coeffecient of Pr2 = 6
bcoeff = round(Pr2(2));                 % 2nd coeffecient of Pr2 = 0
ccoeff = round(Pr2(3));                 % 3rd coeffecient of Pr2 = 0
hold("on");
plot(data.x,dataFit,'DisplayName','E = 6x^2','LineStyle','-','Color','blue')
hold("off");
equation=sprintf("E = (%d)x^2",acoeff);
disp(equation)


% The mass of the object should be a constant
% Kinetic Energy = (m*v^2)/2 at base Potential Energy = 0 
% Solve for m:
m = (2*E)./x.^2; % = Calculation for mass
m = round(m(2)); % Mass is a constant

% Output %
disp("The form of Energy is Kinetic Energy");
disp("The unknown variable x, is Velocity, it's units are metres/second");
disp("An estimate of the mass of the object is:")
fprintf("%dkg", m); % Shows mass and units of mass
%********************************* CODE ENDS ******************************



