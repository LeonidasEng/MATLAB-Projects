% *************************** Data Analysis *******************************
% *                          By LeonidasEng                               *
% *         Pie Chart(s) for Power Sources and Aggregate Sources          *
% *************************************************************************

clear;
% Cleaned GridWatch data, removed ICTs saved as new file below:
load("GridWatch_Data_19092022_SRCs.mat");


% Measure:  Demand is measured in MW
% Find Total Power Share:
Total(1) = sum(biomass, "all", "omitnan");
Total(2) = sum(hydro, "all", "omitnan");
Total(3) = sum(ccgt, "all", "omitnan");
Total(4) = sum(ocgt, "all", "omitnan");
Total(5) = sum(coal, "all", "omitnan");
Total(6) = sum(pumped,"all", "omitnan");
Total(7) = sum(nuclear, "all", "omitnan");
Total(8) = sum(other, "all", "omitnan");
Total(9) = sum(solar, "all", "omitnan");
Total(10) = sum(oil, "all", "omitnan");
Total(11) = sum(wind, "all", "omitnan");

% Creating 1st Pie Chart %
explode = [1 1 0 1 1 1 1 1 1 1 1];
%ax1 = nexttile;
figure(1);
p1 = pie(Total, explode);

% Title - storing it's handle to move it's position
title("UK Power Source Share", "FontSize",16);
set(gca,'Units','normalized')
titleHandle = get( gca ,'Title' );
pos  = get( titleHandle , 'position' );
pos1 = pos - [0 -0.1 0]; 
set( titleHandle , 'position' , pos1 );

% Adding Labels %
p1Text = findobj(p1, 'Type', 'text');
percent1Value = get(p1Text, 'String');
labels1 = {'Biomass '; 'Hydro '; 'CCGT '; 'OCGT '; 'Coal '; ...
    'Pumped '; 'Nuclear '; 'Other '; 'Solar '; 'Oil '; 'Wind '};
combinedlabel1 = strcat(labels1, percent1Value);
for i = 1:length(Total)
    p1Text(i).String = combinedlabel1(i);
end
set(findobj(p1,'type','text'),'FontSize', 13);
lgd1 = legend(labels1,'Location','westoutside','FontSize',14);
lgd1.Title.String = "Sources (19.09.2022)";
lg2.Title.FontSize = 12;
% Creating Aggregate Data %
% CCGT, OCGT, Coal & Oil: 
Fossil_Fuels = Total(3) + Total(4) + Total(5) + Total(10);
% Biomass, Hydro, Pumped, Solar & Wind:
Renewables = Total(1) + Total(2) + Total(6) + Total(9) + Total(11); 
% Nuclear:
Nuclear = Total(7); 
% Other:
Other = Total(8); 
Agg_Data = [Fossil_Fuels; Nuclear; Renewables; Other];

% Creating 2nd Pie Chart %
%ax2 = nexttile;
figure(2);
p2 = pie(Agg_Data);
title("Share of UK Power by category","FontSize",16);

% Adding Labels to 2nd Pie Chart %
p2Text = findobj(p2, 'Type', 'text');
percent2Value = get(p2Text, 'String');
labels2 = {'Fossil Fuels '; 'Nuclear '; 'Renewables '; 'Other '};
combinedlabel2 = strcat(labels2, percent2Value);
for i = 1:length(Agg_Data)
    p2Text(i).String = combinedlabel2(i);
end
set(findobj(p2,'type','text'),'FontWeight', 'bold','FontSize', 13); 
lgd2 = legend(labels2, "Location",'northwestoutside','FontSize',14);
lgd2.Title.String = "Category (19.09.2022)";
lg2.Title.FontSize = 12;
%********************************* CODE ENDS ******************************