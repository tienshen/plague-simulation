% "I discussed this homework problem with Tim Gong. 
% I certify that the assignment I am submitting represents my own work. Tien Li Shen"
% Tien-Li Shen, 4/17/2018, HW5, ID:30930512

function [Surviving_Pop, Success, Population, Pop_C] = hw9_TS_func(r_I, d_cure, h)
    [timeExtinct, Population] = sub(r_I, h); %calling first sub-function
    [TimeDevCure] = sub2(Population, d_cure, h); %calling second sub-function
    if ~isnan(TimeDevCure) %if a cure is developed, meaning that it did not take forever
        %third sub-function is called when this is true
        [timeDistributeCure, Pop_C] = sub3(Population, TimeDevCure, h); 
    else 
        %else no population is cured and no cure is distributed
        Pop_C = 0;
        timeDistributeCure = nan;
    end
    if max(Pop_C) >= Population(end) & timeExtinct<=timeDistributeCure
        Success = 1;
        Surviving_Pop = max(Pop_C);
    else
        Success = 0;
        Surviving_Pop = 0;
    end
end
%----------------------- function 1 ------------------------------------
function [timeExtinct, Population] = sub(r_I, h)
    %initialize variables
    dpdt = 0;
    infectedPop = 0;
    newPop = 0;
    Population = 7.4e9;
    n = 1;
    newPop = 0;
    %a while loop that does things
    while Population(n) > 1e5
        newPop(n) = Population(n) * 0.012^h; %0.012 is the rate of population growth
        deadPop(n) = infectedPop(n) * 0.8; %0.8 is the rate of death due to bacteria
        infectedPop(n+1) = infectedPop(n) - deadPop(n) + Population(n) * r_I^h;
        dpdt(n) = newPop(n) - deadPop(n); %change of population with respect to time
        Population(n+1) = Population(n) + h*dpdt(n); %euler's method
        n = n+1;
    end
    timeExtinct = size(Population)*h;
end
%--------------------------- function 2 --------------------------------
%second sub-function that calculate time to find a cure
function [TimeDevCure] = sub2(Population, d_cure, h)
    %initialize variables
    Discovery = zeros(size(Population));
    drdt = 0;
    scientists = Population ./ 100000; % there is 1 scientist for every 100,000 people
    i = 1;
    %a while loop that does things
    while scientists(i) > 1
        drdt(i) = scientists(i) * 0.1^h; %0.1 is the rate of discovery
        Discovery(i+1) = Discovery(i) + h*drdt(i); %euler's method
        i=i+1;
    end
    if Discovery(end) > d_cure %if the number of discovery is larger than discovery required
        TimeDevCure = size(drdt)*h; %time to cure is calculated
    else
        TimeDevCure = nan; %else the cure is never found and time is infinity
    end
end

%---------------------------- function 3 ------------------------------ 
%thid sub-function that calcute time to distribute cure and the population
%cured
function [timeDistributeCure, Pop_C] = sub3(Population, TimeDevCure, h)
    doctors = zeros(size(Population));
    doctors = Population./1000.*3.54;
    hospitalBeds = doctors./3.36;
    Pop_C = zeros(size(Population));
    dcdt = 0;
    j = 1;
    while doctors(j) > 1 && Pop_C(j) < Population(j)
        dcdt(j) = hospitalBeds(j)*0.5^h;
        Pop_C(j+1) = Pop_C(j)+ h*dcdt(j);
        j=j+1;
    end
    timeDistributeCure = j*h;
end
        
        
    


    
    

