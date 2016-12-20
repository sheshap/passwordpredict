function compute_frequencies()
    %{ final set of characters taken into account for computing frequencies
    %{ all lower case characters - 26 in number
    lower_cases = {'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z' };
    
    %{ key presses that represent 'Shift', 'Symbols','Numbers'
    keypresses = {'KP1','KP2'};
    
    %{ Union set of lower case characters and the key presses
    FinalChars=union(lower_cases,keypresses);
    
    %{ count of the final set of characters and key presses
    countfinalchars = length(FinalChars);
    
    %{ a NxN cell matrix to hold the frequency counts for character pairs
    FreqCount = cell(countfinalchars,countfinalchars);
    
    %{ N cell array to hold the frequencies counts for individual character
    SProb = cell(countfinalchars,2);    

    %{ file descriptor to read each transformed password 
    InputfileID = fopen('transformed_passwords.txt','r');
    
    %{ Initialize all individual frequency counts to zero
    for i=1:countfinalchars
        SProb(i,1) = cellstr(num2str(FinalChars{i}));
        SProb(i,2) = {0};
    end
    
    %{ A 28x28 Cell matrix holding pair frequencies 
    FreqCount(1,1)={'28/28'};
    
    %{ initialize 1st row and 1st column with the charater/keypress to help in any debugging
    for i=2:countfinalchars+1
        FreqCount(i,1) = cellstr(num2str(FinalChars{i-1}));
        FreqCount(1,i) = cellstr(num2str(FinalChars{i-1}));
    end

    %{ initialize all pair frequency counts to zero
    for k =2:countfinalchars+1
        for t=2:countfinalchars+1
            FreqCount(k,t) = {0};
        end
    end
    
    %{ read first password from the file using fgetl function into variable gegetline
    getline = fgetl(InputfileID);
   
    %{ read all the transformed passwords to count the individual character/keypress frequency count and also pairwise frequency count
    while ischar(getline)
        temp=strsplit(getline,'-');  %{ split the password and store the array of characters in a temprory cell array
        len=length(temp);       %{ count of the characters/keypresses in the password
        for i=1:len
            [x,y]=ismember(temp{i}, FinalChars); %{ check if the character is in our union of final characters/keypresses
            if y==0
            else
            SProb(y,2) = {cell2mat(SProb(y,2))+1};  %{ increment the count of that individual character/keypress
            end
        end
        
        %{ calculate the pairwise frequency counts
        for i=1:len-1
            temp_a=temp{i};  %{ read consecutive characters in two temporary variables temp_a and temp_b
            temp_b=temp{i+1};
            [~,y]=ismember(temp_a, FinalChars); %{ check if the 1st character in pair is in final characters/keypresses
            [~,z]=ismember(temp_b, FinalChars); %{ check if the 2nd character in pair is in final characters/keypresses
            if(y==0 || z==0)   
            else
                %{ increment the frequency count for the pair of characters
                FreqCount(y+1,z+1) = {cell2mat(FreqCount(y+1,z+1)) + 1};  
            end
        end
        %{ read next transformed password to count single and pairwise frequencies of characters
            getline = fgetl(InputfileID);
    end
    %{ close input file descriptor of transformed passwords
    fclose(InputfileID);
    
    %{ Save the single and pairwise frequencies of characters into .mat file
    save('KeypressFrequencyCount.mat');
end