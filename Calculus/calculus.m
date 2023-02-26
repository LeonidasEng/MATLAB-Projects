% *************************** Calculus Program ****************************
% *                           By LeonidasEng                              *
% *     Calculates the roots, y intercept, turning points and integral    * 
% *************************************************************************
clear;
clc;
% Initialising the symbolic functions: %
syms g(t) f(x) C                % Creates sym functions & integral constant
g(t) = 2*t^2-3*t-5;             % Equation for (a)
f(x) = x^3-7*x+6;               % Equation for (b)

% I. Roots of A: %
a = double(solve(g(t), t));     % Converts sym to double                 
disp("The roots of g(t) are:")
disp(a)                         % Roots for (a) are displayed
% I. Roots of B %
b = double(solve(f(x), x));     % Converts sym to double
disp("The roots of f(x) are:")
disp(b)                         % Roots for (b) are displayed
disp("******************************************************************");

% II. Y-intercept when t & x = 0 %
t0 = sprintf("The y-intercept of g(t) is %d", round(g(0)));
x0 = sprintf("The y-intercept of f(x) is %d", round(f(0)));
disp(t0); % Displays y-intercept for g(t) as int
disp(x0); % Displays y-intercept for f(x) as int
disp("******************************************************************");

% III. Turning points of (a) %
dg = diff(g(t),t);                  % The derivative of g(t)
disp("The derivative of g(t) is:")
disp(dg);
dg2 = diff(g(t),t,2);               % The derivative of g'(t)
disp("The 2nd order derivative of g(t) is:")
disp(dg2);
% Co-ordinates of Turning Point: %
dr = solve(dg==0,t); % g'(t) = 0
tp1 = sprintf("The turning point for g(t) is at x = %.4f y = %.4f", double(dr), double(g(dr)));
% The above finds the turning point by setting g'(t) = 0 and finding
% the x,y co-ordinates of the turning point.
disp(tp1)
% Logic to determine nature of turning point:
if dg2 > 0 % if g''(t) is greater than 0 it is min
    disp("Therefore a minimum point");
else       % if g''(t) is less than 0 it is max
    disp("Therefore a maximum point");
end
disp("******************************************************************");

% III. Turning points of (b) %
df = diff(f(x),x);              % The derivative of f(x)
disp("The derivative of f(x) is:")
disp(df);
df2 = diff(f(x),x,2);           % The derivative of f'(x)
disp("The 2nd order derivative of f(x) is:")
disp(df2);
dfroot = double(solve(df==0,x)); % Finds the roots of f'(x) = 0
tp2 = double(f(dfroot));    % y co-ordinates of the turning points
mmi = 6*dfroot;             % f''(x)

disp("The turning points for f(x) are:")
% Logic to look at each vector element, find the x,y co-ordinates and
% determine the nature of the turning points
for i = 1:size(tp2) 
    disp(dfroot(i,1)) % This shows the x co-ordinate
    disp(tp2(i,1));   % This shows the y co-ordinate
    if mmi(i,1) > 0  % if f''(x) is greater than 0 it is min 
        disp("Therefore a minimum point");
    elseif mmi(i,1) < 0 % if f''(x) is less than 0 it is max
        disp("Therefore a maximum point");
    else             % if f''(x) = 0 it is a point of inflection
        disp("Therefore a point of inflection");
    end
    disp("--------------------------------------------------------------");
end
disp("******************************************************************");

% IV. The indefinite integral of (a) %
gint = expand(int(g(t),t)) + C; % Expands brackets to give simplest answer
disp("The Indefinite Integral of g(t) is:")
disp(gint);
disp("******************************************************************");

% IV. The indefinite integral of (b) %
fint = expand(int(f(x),x)) + C; % Expands brackets to give simplest answer
disp("The Indefinite Integral of f(x) is:")
disp(fint);
disp("******************************************************************");

% V. The definite integral of (a) %
gdint = int(g(t),[-3 3]); % Calculates the definite integral from -3 to 3
disp("The Definite Integral of g(t) is:")
disp(gdint);
disp("******************************************************************");

% V. The definite integral of (b) %
fdint = int(f(x),[-3 3]); % Calculates the definite integral from -3 to 3
disp("The Definite Integral of f(x) is:")
disp(fdint);
%********************************* CODE ENDS ******************************