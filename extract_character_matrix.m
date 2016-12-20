function temp=extract_character_matrix(clus_Sequence)
    load('KeypressFrequencyCount.mat');
    
    %{ all six clusters listed with their prominent characters
     Cluster1 = {'q','w','e','a','s','d'};
     Cluster2 = {'r','t','y','f','g','h'};
     Cluster3 = {'u','i','o','p','j','k','l'};
     Cluster4 = {'KP1','z','x','KP2'};
     Cluster5 = {'c','v','b'};
     Cluster6 = {'n','m'};
     
     %{ variable to hold the predicted characters from each cluster
     Predict=[];      
     
    %{ variable to hold the predicted first characters based on frequency
     Predfirst =zeros(2,2);
    %{ logic to extract only the first character using the firstchar function depending on the 1st cluster sequence number
    s=1;
    switch clus_Sequence{s}
        case {1}
           Predfirst=firstchar(Cluster1,FinalChars,SProb);
        case {2}
           Predfirst=firstchar(Cluster2,FinalChars,SProb);
        case {3}
           Predfirst=firstchar(Cluster3,FinalChars,SProb);
        case {4}
           Predfirst=firstchar(Cluster4,FinalChars,SProb);
        case {5}
           Predfirst=firstchar(Cluster5,FinalChars,SProb);
        case {6}
           Predfirst=firstchar(Cluster6,FinalChars,SProb);
        otherwise
                disp('Wrong cluster sequence');
    end
    M = zeros(length(clus_Sequence),3);
    
    %{ store the 1st element's cluster in descending sorted sequence 
    Predict{1} = Predfirst;
    
     %{ logic to extract only the remaining characters using the findsubsequentchar function depending on the subsequent sequence numbers
    for s=2:length(clus_Sequence)
        switch clus_Sequence{s}
            case {1}
                Predict{s}=findsubsequentchar(Cluster1,FinalChars,FreqCount,Predict);
            case {2}
                Predict{s}=findsubsequentchar(Cluster2,FinalChars,FreqCount,Predict);
            case {3}
                Predict{s}=findsubsequentchar(Cluster3,FinalChars,FreqCount,Predict);
            case {4}
                Predict{s}=findsubsequentchar(Cluster4,FinalChars,FreqCount,Predict);
            case {5}
                Predict{s}=findsubsequentchar(Cluster5,FinalChars,FreqCount,Predict);
            case {6}
                Predict{s}=findsubsequentchar(Cluster6,FinalChars,FreqCount,Predict);
            otherwise
                disp('Wrong cluster sequence');
        end
    end
    %{ 
        once all the cluster sequences with descending order of characters are Predicted based on 
        1st character and subsequent  character pairs 
    %}
    temp=construct_final(Predict,FinalChars);
end
