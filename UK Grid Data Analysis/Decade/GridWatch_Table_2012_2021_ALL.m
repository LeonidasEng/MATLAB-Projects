% *************************** Data Analysis *******************************
% *                           By LeonidasEng                              *
% *                      Decade of CO2 Emissions                          *
% *************************************************************************

clear;
load("GridWatch_Data_2012_2021_ALL.mat");
% Data - Units: MW
% Energy = MW * Hours.

% Table of Emissions - g/kWh %
sz = [7 2];
varTypes = ["string", "int16"];
varNames = ["Energy Source", "CO2 Emissions g/kWh"];
table_1 = table('Size',sz,'VariableTypes', varTypes, ...
    'VariableNames', varNames);
table_1(1,:) = {'Coal', 820};
table_1(2,:) = {'Gas', 490};
table_1(3,:) = {'Nuclear', 12};
table_1(4,:) = {'Wind', 12};
table_1(5,:) = {'Solar', 48};
table_1(6,:) = {'Biomass', 230};
table_1(7,:) = {'Hydro', 24};
CO2_gram = [820; 490; 12; 12; 48; 230; 24]; 

% (0.82)15630 * x = 1068 therefore x = 0.0833 hours, 5 minutes
% Conversion Factor: CO2_tonne = (CO2_gram/1000) * MW * Time_Interval
Time_Interval = 0.0833333; % 5 minutes = 0.0833333 hours

% Convert timestamp into 6 column vectors %
timeVector = datevec(timestamp);
timeYear = timeVector(:,1);
Ctrl_Group = findgroups(timeYear); % To find groups for individual years.

% Create 7x11 matrix to represent the mean values of Power (MW)
Megawatts(1,:) = splitapply(@mean, coal,Ctrl_Group);
Megawatts(2,:) = splitapply(@mean, ccgt,Ctrl_Group);
Megawatts(3,:) = splitapply(@mean, nuclear, Ctrl_Group);
Megawatts(4,:) = splitapply(@mean, wind, Ctrl_Group);
Megawatts(5,:) = splitapply(@mean, solar, Ctrl_Group);
Megawatts(6,:) = splitapply(@mean, biomass, Ctrl_Group);
Megawatts(7,:) = splitapply(@mean, hydro, Ctrl_Group);

% For loop find the Mass of CO2 emissions in Tonnes using the following
% equation:
for i = 1:1:7
 CO2_Tonnes(i,:) = (CO2_gram(i)/1000)*(Megawatts(i,:)*Time_Interval); 
end

rowNames = {'Coal', 'Gas', 'Nuclear', 'Wind', 'Solar', 'Biomass', 'Hydro'};
colNames = {'2012', '2013','2014','2015','2016','2017','2018','2019',...
    '2020','2021', '2022'};

% Converting matrix to table %
table_2 = array2table(CO2_Tonnes(:,:),"RowNames",rowNames, ...
    "VariableNames",colNames);
disp(table_1);
disp(table_2);

%************************ Plots for CO2 Emissions ************************%
% Line Graph - All sources %
figure(1);
    plot(table_2{"Coal",:}, "Marker", "o");
    hold("on");
    plot(table_2{"Gas",:}, "Marker", "*");
    plot(table_2{"Nuclear",:});
    plot(table_2{"Wind",:});
    plot(table_2{"Solar",:});
    plot(table_2{"Biomass",:}, "LineStyle","--","Color","#7E2F8E", ...
        "Marker", "x");
    plot(table_2{"Hydro",:});
    xlabel("Years","FontWeight","bold","FontSize",15);
    ylabel("CO2 Emissions (Tonnes)","FontWeight","bold","FontSize", 15);
    title("Average UK CO2 Emissions in the last decade", ...
        "FontWeight","bold", "FontSize", 20);
    xticklabels(colNames);
    grid("on");
    labels = {'Coal', 'Gas', 'Nuclear', 'Wind', 'Solar', 'Biomass',...
        'Hydro'};
    lgd1 = legend(labels);
    lgd1.Title.String = 'Sources';
    lgd1.FontSize = 14;
    set(gca, 'FontSize', 14);
    hold("off");
% Line Graph - Omitting Coal & Gas %
figure(2);
    plot(table_2{"Nuclear",:},"LineStyle","-.","Color", "#77AC30", ...
        "LineWidth", 1);
    hold("on");
    plot(table_2{"Wind",:},"LineStyle","--","Marker","*","Color","r");
    plot(table_2{"Solar",:},"LineStyle","--","Color","m", ...
        "Marker","o");
    plot(table_2{"Biomass",:},"Marker","x");
    plot(table_2{"Hydro",:},"Color","b");
    xlabel("Years","FontWeight","bold","FontSize",15);
    ylabel("CO2 Emissions (Tonnes)","FontWeight","bold","FontSize", 15);
    title("Average UK CO2 Emissions omitting Coal & Gas","FontWeight", ...
        "bold", "FontSize",18);
    xticklabels(colNames);
    grid("on");
    olabels = {'Nuclear', 'Wind', 'Solar', 'Biomass', 'Hydro'};
    lgd2 = legend(olabels, "Location","northwest");
    lgd2.Title.String = 'Sources';
    lgd2.FontSize = 14;
    set(gca, 'FontSize', 14);
    hold("off");
% 3D Bar Chart - Cleanest Energy %
figure(3);
    z_bars = [table_2{"Nuclear",:}; table_2{"Wind",:}; ...
        table_2{"Solar",:}; table_2{"Hydro",:}];
    b = bar3(z_bars);
    c = colorbar;
    c.Label.String = 'CO2 Emissions (Tonnes)';
    c.Label.FontSize = 13;
    for k = 1:length(b)
        zdata = b(k).ZData;
        b(k).CData = zdata;
        b(k).FaceColor = 'interp';
    end
    ytick = {'Nuclear', 'Wind', 'Solar', 'Hydro'};
    yticklabels(ytick);
    xticklabels(colNames);
    set(gca, 'FontSize', 13);
    title("Comparison of UK's cleanest energy sources", ...
        "FontWeight","bold","FontSize",14);
%********************************* CODE ENDS ******************************