function temp=findsubsequentchar(Curr_Cluster,FinalChars,FreqCount,Predict)
      
      curr_clus_length=length(Curr_Cluster);%{ length of cluster required to order the characters within the cluster based on their frequency counts
      %{ below are two temporary matrix variables to hold the intermediate frequency counts of a given cluster with character location in 1st column and frequency count in 2nd column
      tempMat1=zeros(curr_clus_length,2);
      tempMat2=zeros(curr_clus_length,2);
      
      %{ Predict cell array already has the 1st character listed(may be due to 1st character or some subsequent characters listed in previous calls)
      Predlength=length(Predict);
      
      %{ length of Predict cell array at this stage represent the previous length as further insertion of next cluster characters is done follwed by this
      previous=Predlength;
      
      %{ based on the scores due to pairing of characters between this cluster sequence and previous cluster sequence characters the order of this cluster characters are evaludated
      for i=1:curr_clus_length
          %{ find locations of each characters in FinalChars 
          index_i = find(strcmp(FinalChars,Curr_Cluster(i)));
          
          %{ calculate the score of occurance of each character in place of current cluster sequence based on previously predicted characters
          temp_sum=0;
          for j=1:length(Predict{previous})
              temp_sum = temp_sum + cell2mat(FreqCount(Predict{previous}(j)+1,index_i+1));
          end
          %{ store the charcter index and the sum of the frequencies
          tempMat1([i i+curr_clus_length]) = [index_i temp_sum];
      end
      %{ sort the matrix in descending order of frequencies
      tempMat2=sortrows(tempMat1,-2);
      
 temp=tempMat2(1:curr_clus_length,1:2);
end