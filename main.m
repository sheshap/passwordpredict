%{ 
     this script uses the Frequency counts of individual characters and also 
    the frequency count of character pairs to evaluate the order of characters 
    for a given cluster sequences
%}
%{ takes input of a sequence of cluster numbers and produces a matrix of characters for each cluster sequence with scores
final_matrix=extract_character_matrix({3,3,5,1});

%{ this fucntion generates 'n' passwords
calcpermuts(final_matrix,10);