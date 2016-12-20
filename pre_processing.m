%{ 
    This function is used to pre process the input list of passwords
    Using this function we ignore passwords with length less than 4 characters and also greater than 16 characters
    We also ignore passwords which contain space and characters like {'/','_',',','.','>','<','\','`'} which are out of the scope of the
    standard keyboard for typing passwords

    pre_processing function is called from the main program file
%}

function pre_processing()
    %{ input file descriptor to read the original passwords from the passwords.txt file in read mode.
    InputfileID = fopen('passwords.txt','r');

    %{ output file descriptor using which the processed passwords are written to pre_processed_passwords.txt file in write append mode.
    PreProcessedfileID = fopen('pre_processed_passwords.txt','wt');

    %{ list of characters which are considered as out of scope of the standard password keyboard
    invalidchars = {'/','_',',','.','>','<','\',' ','`'};

    %{ read first password fromt he file using fgetl function into variable getline
    getline = fgetl(InputfileID);
 
    while ischar(getline)
        %{ len variable holds the length of the password read from original file
        len = length(getline);
        %{ check for the length of th epassword to be greater than 4 but less than 16 for further processing
        if len >= 4 && len <= 16
         flag=1; %{ flag=1 indicates the password read is valid and then checked for each charater if password has any invalid characters
             for i=1:len
                if (ismember(getline(i),invalidchars))   
                    flag=0;     %{ if yes then set flag to 0 indicating invalid password
                end
             end
         %{ if invalid password then ignore it and read next password
         if (flag==0)
             getline = fgetl(InputfileID);
             continue;
         end

         %{ or else if password is valid then write it to the pre_processed_passwords.txt file
         fprintf(PreProcessedfileID,'%s\n',getline);
        end
        getline = fgetl(InputfileID);
    end

    %{ close file descriptors opened to read or write/append during pre-processing of passwords
    fclose(InputfileID);
    fclose(PreProcessedfileID);
end
