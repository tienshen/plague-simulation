% "I discussed this homework problem with Tim Gong. 
% I certify that the assignment I am submitting represents my own work. Tien Li Shen"
% Tien-Li Shen, 4/17/2018, HW5, ID:30930512

%simulation values are created
simulation = [0.05, 10000, 1; 0.10, 10000, 1; 0.05, 20000, 1; 0.1, 20000, 1; 0.1, 10000, 0.5; 0.10, 10000, 0.25];
Success = zeros(1,6);
for n=1:6
    [Surviving_Pop, Success(n), Population, Pop_C] = hw9_TS_func(simulation(n,1), simulation(n,2), simulation(n,3));
    %difficult to store all ouputs since most of them are in vectors
    figure(n) %making 6 figures
    plot(Population,'g-') %population is in green
    title('Population Over Time');
    xlabel('time');
    ylabel('population');
    hold on
    plot(Pop_C,'r-')
end

%the population decreases exponentially to nearly zero in all simulations. All of my
%simulations show that some pupolation gets cured. However, once population
%cured intersect with population, population Cured drops to zero,
%population continues to decrease after. This phenomenom is explained by the
%while loop condition. while loop breaks once the two functions reach the
%same value and population cured are all 0 after the intersection. This was very odd to me
%at first
%my success seems to be off. I couldn't figure out the problem

