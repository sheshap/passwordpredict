function temp=firstchar(Cluster,FinalChars,Single_Prob)
      first_clus_length=length(Cluster); %{ length of cluster required to order the characters within the cluster based on their frequency counts
      %{ below are two temporary matrix variables to hold the intermediate frequency counts of a given cluster with character in 1st column and frequency count in 2nd column
      L=zeros(first_clus_length,2);
      M=zeros(first_clus_length,2);   
      %{ 
            this for loop helps to extract the characters locations in FinalChars 
            cell array and frequency counts of the first element of the cluster sequence 
      %}
      for t=1:length(Cluster)
         indexi = find(strcmp(FinalChars,Cluster(t)));
         b = ((Single_Prob{indexi,2}));
         L([t t+first_clus_length]) = [indexi b];
      end
      %{ sort the frequency counts within the first cluster sequence
      M=sortrows(L,-2);   
 temp=M(1:first_clus_length,1:2);
end