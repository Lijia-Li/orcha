disp('Welcome to Project Orcha!')
disp("We approached music learning in different ways.")
disp("For this project, you have three programs to try out.")
disp("To understand more about our project, please refer to our project report.")
pause(1)
disp('-----------------------------------------------------')
disp("BEFORE WE BEGINS")
disp("Please install the Computer Vision Tool Box from MathWorks")
while 1
    disp('-----------------------------------------------------')
    pause(1)
    disp('1.Orcha Vision')
    disp('2.OrchaHog Search')
    disp('3.Orcha Search')
    disp('4.quit')
    prompt = 'Please input the number of the program (e.g. 1):  ';
    choice = input(prompt);
    if choice == 1
        orchaVision;
    elseif choice == 2
        orchaSearchHog;
    elseif choice == 3
        disp('You have the following snippets to choose from:')
        disp("'orchaSearch/Snippet/elice_snippet2.png'")
        disp("'orchaSearch/Snippet/tercet.png'")
        disp("'orchaSearch/Snippet/scale.png'")
        disp('-----------------------------------------------------')
        prompt = 'please copy and paste the full directory, including the single quotation mark:   ';
        snip = input(prompt);
        orchaSearch;
    elseif choice == 4
        break
    else
        disp('Please only enter 1, 2, 3, or 4 as a number.')
    end
end
    