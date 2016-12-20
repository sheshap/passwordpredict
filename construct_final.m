%{ 
        This function creates a 2 dimensional matrix which holds possible characters of a 
        particular cluster sequence in order of decreasing frequency count
%}

function temp=construct_final(Predict,FinalChars)
%{ a temporary cell matrix 
 tempcell=cell(length(Predict{1}),2*length(Predict));
 %{ odd columns of the matrix contain the characters predicted for each cluster sequence
 for i=1:2*length(Predict)
     if(mod(i,2))
         p= int8((i+1)/2);
         %{ even columns contain the scores for each predicted character in given cluster
         for j=1:length(Predict{p})
             tempcell(j,i)=cellstr(FinalChars{Predict{p}(j)});
             tempcell{j,i+1}=(Predict{p}(j+length(Predict{p})));
         end
     end
 end
temp=tempcell;
end