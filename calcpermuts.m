
%{ this function calculates the permutations of possible passwords and sorts them based on the possible summation of each characters
%{ this funciton also takes n as the input to return 'n' possible predicted passwords.
function calcpermuts(final_matrix,n)
%{ size of final_matrix is useful to access the final matrix
[number,matlen]=size(final_matrix);
        %{ total variable to count the number of passwords generated 
          total=0;
          matrix_length=matlen;
          %{ m has to be greater than 4 because the final matrix will hold the value permutations of matrix as per the decreasing order of the frequency
          while matrix_length >= 4
           intermediate_permuts = [];       %{ temporary variable to hold intermediate passwords
           passwd_intermediate=1;     
           for inner_col=1:number   
            for outer_col=1:number
                if ((isempty(final_matrix{inner_col,matrix_length-3}) || isempty(final_matrix{outer_col,matrix_length-1}) || isempty(final_matrix{outer_col,matrix_length}) || isempty(final_matrix{inner_col,matrix_length-2})))
                else
                 intermediate_permuts{passwd_intermediate,1} = strcat(final_matrix{inner_col,matrix_length-3},strcat('-',final_matrix{outer_col,matrix_length-1}));
                 intermediate_permuts{passwd_intermediate,2} = final_matrix{outer_col,matrix_length} + final_matrix{inner_col,matrix_length-2};
                 passwd_intermediate=passwd_intermediate+1;
                end
            end
           end
           %{ copying the intermediate permutations to be used for the further generation of intermediate permutations of passwords/password substrings
           [x,~] =size(intermediate_permuts);
           for i=1:x
             final_matrix{i,matrix_length-3} = intermediate_permuts{i,1};
             final_matrix{i,matrix_length-2}= intermediate_permuts{i,2};
           end
           [number,~]=size(final_matrix);
           matrix_length=matrix_length-2;
           total=total+passwd_intermediate;
          end
          %{ reverse sort the permuted passwords
          L = sortrows(intermediate_permuts,-2);
          for i=1:n
            disp(L(i));
          end
end