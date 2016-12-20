%{ 
    This function is used to transform the pre processed list of passwords
    Using this function we transform the pre-processed passwords into key
    presses separated by hypens (-)
    Example: let the pre-processed password be pas0#Syr then the transformed
    password will appear as p-a-s-KP2-p-s-KP2-KP1-s-y-r

    transform_to_keypresses function is called from the main program file
%}

function transform_to_keypresses()

    %{ input file descriptor to read the pre-processed passwords from the pre_processed_passwords.txt file in read mode.
    InputfileID = fopen('pre_processed_passwords.txt','r');

    %{ output file descriptor using which the transformed passwords are written to transformed_passwords.txt file in write append mode.
    TransformedPasswordsfileID = fopen('transformed_passwords.txt','wt');

    %{ read first password fromt he file using fgetl function into variable gegetline
    getline = fgetl(InputfileID);

    %{ temporary variable to hold each pre-processed password being read
    
    temp=[]; 
    while ischar(getline)   
         temp{1} = getline;

    %{ Single Final cell variable to hold the final keypress version of each password
    one=1;
    Final = cell(one,34);
    %{  logic to implement conversion of the password characters to keypresses
    %{ initially the number and symbol states are not reached as the keyboard is in it's basic S1 state
        numbers = false;
        symbols = false;

        k = 4;
        %{ store the original password at location (1,1) of the Final variable
        Final(one, one) = cellstr(temp{one});
        
        %{ parse the password to covert each of it's character to key presses
        for j = 1:length(temp{one});
            switch temp{one}(j)
                %{ 
                    This case checks if the lower case letters were preceeded by any other key presses like a number 
                    (i.e the keyboard if in anyother state than the lower case state S1) then include appropriate key presses
                    
                %}
                case {'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','.',','}
                    if(numbers == true)
                        numbers = false;   %{ if in different state than S1 change to S1
                        symbols=false;
                        Final(one, k) = cellstr('KP2'); %{ inclusion of KP2 key press indicates shifting from number state S2 to basic keyboard state S1 to accomodate lowercase character key presses
                        k = k + 1;
                        Final(one, k) = cellstr(temp{one}(j));
                        k = k + 1;
                    else
                        symbols = false;
                        Final(one, k) = cellstr(temp{one}(j));
                        k = k + 1;
                    end
                %{ 
                    This case checks if the upper case letters were preceeded by any other key presses like a number 
                    (i.e the keyboard if in any other state than the lower case state S1) then include appropriate key presses
                    it also includes the shift key press KP1 before actually transforming. 
                %}            
                case {'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'}
                    if(numbers == true)
                        numbers = false; %{ change state S2 to S1 to accomodate character
                        symbols=false;
                        Final(one, k) = cellstr('KP2');
                        k = k + 1;          %{ include KP1 representing Shift key to accomodate upper case character
                        Final(one, k) = cellstr('KP1');
                        k = k + 1;
                        Final(one, k) = cellstr(temp{one}(j));
                        k = k + 1;
                    else
                        numbers = false;
                        symbols=false;
                        Final(one, k) = cellstr('KP1');
                        k = k + 1; 
                        Final(one, k) = cellstr(temp{one}(j));
                        k = k + 1;
                    end   
                %{ 
                    This case checks if the numbers were preceeded by any other key presses like a symbol or alphabet 
                    (i.e the keyboard if in any other state than the numbers state S2) then include appropriate key presses 
                    KP2 before actually transforming.
                %}                     
                case {'0','1','2','3','4','5','6','7','8','9','@','#','$','%','&','-',':',';','!','?','*','"','+','(',')',''''}
                    if(numbers == false)
                        numbers = true;   %{ KP2 transits the current state to the number state S2 hence numbers is marked as true to accomodate the next press to be a number
                        symbols=false;
                        Final(one, k) = cellstr('KP2');
                        k = k + 1;
                        Final(one, k) = cellstr(temp{one}(j));
                        k = k + 1;
                    else
                        symbols=false;
                        numbers=true;
                        Final(one, k) = cellstr(temp{one}(j));
                        k = k + 1;
                    end
                %{ 
                    This case checks if the symbol needs to be pressed then the required transition to numbers and then the symbols state 
                    (i.e from S1 to S4 via S2 is achieved) were preceeded by any other key presses like a number (i.e the keyboard if in any other state than the
                    symbols state S4 then include appropriate key presses S1--> S3 and then to S4.
                %} 
                case {'~','|','^','[',']','=','{','}'}
                    if(numbers == true && symbols == false)
                        symbols = true;
                        Final(one, k) = cellstr('KP1');  %{ represents transit from numbers (S3 to S4) state
                        k = k + 1;
                        Final(one, k) = cellstr(temp{one}(j));
                        k = k + 1;
                    elseif(symbols == false)
                        numbers = true;
                        symbols = true;
                        Final(one, k) = cellstr('KP2'); %{ represent transition from S1(lower case) to S3(numbers) 
                        k = k + 1;
                        Final(one, k) = cellstr('KP1'); %{ and then to S4(symbols) state
                        k = k + 1;
                        Final(one, k) = cellstr(temp{one}(j));
                        k = k + 1;
                    else
                        numbers = true;
                        Final(one, k) = cellstr(temp{one}(j));
                        k = k + 1;
                    end
                otherwise
                    Final(one, k) = cellstr(temp{one}(j)); %{ in all other case process the password as it is
                    k = k + 1;
            end    
        end    
        %{ The length of the transformed password is stored at 3rd place in the Final array for a given password
        Final(one, 3) = cellstr(num2str(k-4));
        %{ The length of the original password is stored at 2nd place in the Final array for all future debugging purposes.
        Final(one, 2) = cellstr(num2str(length(temp{one})));


    X = {'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z' };
    Y = upper(X);
    Z = {'0','1','2','3','4','5','6','7','8','9'};
    symbols = {'~','|','^','[',']','%','=','{','}','@','#','$','&','-',':',';','!','?','_','*','"','+','(',')',''''};
    keypresses = {'KP1','KP2'};
    Alpha = union(X,Y);
    Beta = union(Alpha,Z);
    Theta = union(Beta, keypresses);
    Gamma = union(Theta,symbols);
    FinalChars=union(X,{'KP1','KP2'});
    Trans={'p','q','w','e','r','t','y','u','i','o'};

           len=str2double(Final(one,3));
           for j=1:len
                switch ismember(Final{one,j+3},Gamma)
                    case {ismember(Final{one,j+3},Y)}
                        Final{one,j+3} = lower(Final{one,j+3});
                    case {ismember(Final{one,j+3},keypresses)}
                    case {ismember(Final{one,j+3},Z)}
                        Final{1,j+3} = Trans{strcmp(Final{1,j+3},Z)};
                    case {strcmp(Final{one,j+3},'@')}
                        Final{one,j+3} = 'a';
                    case {strcmp(Final{one,j+3},'#')}
                        Final{one,j+3} = 's';
                    case {strcmp(Final{one,j+3},'$')}
                        Final{one,j+3} = 'd';
                    case {strcmp(Final{one,j+3},'%')}
                        Final{one,j+3} = 'f';
                    case {strcmp(Final{one,j+3},'&')}
                        Final{one,j+3} = 'g';
                    case {strcmp(Final{one,j+3},'-')}
                        Final{one,j+3} = 'h';
                    case {strcmp(Final{one,j+3},'~')}
                        Final{one,j+3} = 'q';  
                    case {strcmp(Final{one,j+3},'`')}
                        Final{one,j+3} = 'w';     
                    case {strcmp(Final{1,j+3},'+')}
                        Final{one,j+3} = 'j';  
                    case {strcmp(Final{one,j+3},'*')}
                        Final{one,j+3} = 'z'; 
                    case {strcmp(Final{1,j+3},'!')}
                        Final{one,j+3} = 'n';  
                    case {strcmp(Final{one,j+3},'(')}
                        Final{one,j+3} = 'k'; 
                    case {strcmp(Final{one,j+3},')')}
                        Final{one,j+3} = 'l';  
                    case {strcmp(Final{one,j+3},'?')}
                        Final{one,j+3} = 'm';                     
                    otherwise
                end
           end 
           str='';
           for k=4:str2double(Final{one,3})+3
               if k<str2double(Final{one,3})+3
                   str = strcat(str,Final{one,k});
                   str = strcat(str,'-');
               else
                   str = strcat(str,Final{one,k});
               end
           end
          fprintf(TransformedPasswordsfileID,'%s\n',str);


        getline = fgetl(InputfileID);
    end
        %{ close file descriptors opened to read or write/append during pre-processing of passwords
        fclose(TransformedPasswordsfileID);
        fclose(InputfileID);
end