% ************************ Golf on Earth v Moon ***************************
% *                           By LeonidasEng                              *
% *            Trajectory of a golf ball shot on Earth & Moon             * 
% *************************************************************************

% Numerical computation of the trajectory of a projectile launched at an 
% angle theta with a desired launch speed on the Earth or Moon.
% Enter "filename" to begin script.
clear;


% Prompt for user to select environment type
% Infinite loop allows for user to select any option without ending the
% script:
while 1
    n = newline;
    disp(n);
    disp("-------------------- Program Menu --------------------");
    prompt = "Which environment do you want to test on?" + n + ...
    "1. The Earth?" + n + ...
    "2. The Moon?" + n + ...
    "Enter '1' or '2' to confirm your selection or 'x' to quit."+ n;
    txt = input(prompt,"s"); % Prompts user for input

    % OPTION 1: Golf on the Earth - how boring %
    if txt == "1" % if user enter 1, Earth calculations will run:
    disp(n);
        for Vs = 10:10:60 % launch speed, 6 velocities m/s
        % Specified constants:
        k = 0.02;   % Air resistance constant
        g = 9.81;   % Gravitational Constant
        dt = 0.01;  % A small change in time
        rad = pi/180;
        r = 1;      % Rows
        c = Vs/10;  % Columns - ensures correct dimensions
        for theta = 3:3:90 
            u(1) = Vs * cos(theta*rad); % A velocity * length = Horizontal
            v(1) = Vs * sin(theta*rad); % A velocity * height = Vertical
            % Launch pad location:
            x(1) = 0; % Starting point in x
            y(1) = 0; % Starting Point in y
            %
            % Compute approximate solution of the trajectory of flight.
            % Repeat up to 2000 times, i.e., until ball hits the ground.
            %
            for n=1:1:2000
                % Sequential x direction:
                u(n+1) = u(n) - dt * (k * sqrt(u(n)^2+v(n)^2) * u(n));
                % Sequential y direction
                v(n+1) = v(n) - dt * (k * sqrt(u(n)^2+v(n)^2) * v(n) + g);
                % x position with a velocity * time = distance
                x(n+1) = x(n) + u(n) * dt;
                % y position with a velocity * time = distance
                y(n+1) = y(n) + v(n) * dt;
            % Determination of when the object hits ground:
            if y(n+1) < 0 % pos of y below 0 then ball has hit ground.
               % Tangent(s) to curve change in y over change in x:
               slope = (y(n+1) - y(n))/(x(n+1) - x(n)); 
               b = y(n) - slope * x(n); % y = m*x+c => y-m*x = c
               xhit = - b/slope;       % Point at which ball hits ground
               MDis(r, c) = xhit;      % 30x6 Matrix of Angles & Velocities
               r = r+1;                % Adds 1 to move to next row
               % Looking for a row vector with highest distances 
               % R15xC1 = R15 is 3x15=45
               Max = max(MDis,[],1); % Finds max angle on row.
               % Projectile Distance Horizontal Range =V^2*(2*sin(theta))/g
               % Optimal angle calculation using matrix(r,c) as input,
               % calculated for theta:
               Optimal = 1/2*asin(g*Max/c^2); 
               Optimal = real(Optimal)*180/pi; 
               % Shows only real value in degrees
               Optimal = sprintf("The optimal launch angle" + ...
                   " is %d°", Optimal(1));
               % A plot would be confusing with this number of data points.
               % Data will be displayed in a matrix instead.
            end
                % Once object hits terminate the computations with a break:
                if y(n+1) < 0 
                    break; 
                end
            end
        end
        end
    disp("30x6 Matrix of distance values on Earth are:")
    disp(MDis); % Displays 30x6 Matrix
    disp("Optimal distance values of Matrix:")
    disp(Max); 
    disp(Optimal); % Displays the optimal launch angle        
    
    % OPTION 2: Golf on the Moon - much more fun! %
    elseif txt == "2"
    disp(n);
    % Specified constants:
    k0 = 0.00;  % Changed constant to the Moon environment (no air on Moon)
    mg = 1.625; % Moon gravitational constant
    dt = 0.01; % Small change in time
    %
    % Optimal conditions considered for Alan Shephard's moon golf shot:
    %
    theta = 45; % optimal launch angle in degrees.
    rad = pi/180; %  Radians ratio
    Vs = 60; % Maximum launch speed, m/s
    u(1) = Vs * cos(theta*rad);
    v(1) = Vs * sin(theta*rad);
    % Launch pad location:
    x(1) = 0;
    y(1) = 0;
    %
    % Compute approximate solution of the trajectory of flight.
    % Repeat up to 6000 time, i.e., until ball hits the ground.
    %
       for n=1:1:6000 % Changed to 6000 so plot will show for 60m/s
            u(n+1) = u(n)- dt * (k0 * sqrt(u(n)^2+v(n)^2) * u(n));
            v(n+1) = v(n)- dt * (k0 * sqrt(u(n)^2+v(n)^2) * v(n) + mg);
            x(n+1) = x(n) + u(n) * dt;
            y(n+1) = y(n) + v(n) * dt;
        % Determination of when the object hits ground then plots output:
        if y(n+1) < 0
          slope = (y(n+1) - y(n))/(x(n+1) - x(n));
          b = y(n) - slope * x(n);
          xhit = - b/slope;
          % Calculation and plot of max distance and flight time:
          Distance = sprintf("The length of the shot = %.3f metres", xhit);
          time=sprintf("The flight time of the shot = " + ...
              "%.3f seconds",(2*Vs*sin(theta*rad))/mg);
          figure(1);
          plot(x,y, "--", "Color","b");
          hold on;
          % Ground:
          line(xlim,[0 0], 'Color', '#808080','LineStyle', '--'); 
          % Ball:
          plot(xhit,0,"Marker","o","MarkerFaceColor","red", ...
              "MarkerEdgeColor","black");
          % How far Alan Shephard could have hit ball:
          disp(Distance);
          % Flight time of the ball:
          disp(time);
          % Labels for plot:
          xlabel("Horizontal Distance in metres (m)");
          ylabel("Height in metres (m)");
          title("Trajectory of a golf ball on the Moon");
          legend("Optimal conditions: 60m/s and 45°","Lunar Surface");
          set(gca, "FontSize", 10); 
        end
        % Once object hits terminate the computations with a break:
        if y(n+1) < 0
            break;
        end
       end
    elseif txt == "x"
        txt = isempty(txt); % Quits the program
        disp("Thanks for running my program!");
        break;
    else
        % If user does not enter 1 or 2, error message will be displayed, 
        % User must select a valid option:
        txt = isempty(txt); 
        disp("Invalid option!");
    end
end


