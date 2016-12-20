function temp=generate(final_matrix,num)
    [n,matlen]=size(final_matrix);
    diff_array=zeros(n-1,matlen/2);
    passwd='';
       if num==1
            for k=1:matlen
                if (mod(k,2))
                 passwd = strcat(passwd,final_matrix{1,k});
                end
            end
               if (length(passwd) == matlen/2)
                     disp(passwd);
               end
               temp=passwd;
       else
           passwd=generate(final_matrix,num-1);
           sum=0;
           for j=2:num
            for i=1:matlen
                if (mod(i,2))
                  p=int8(i+1/2);
                    if (isempty(final_matrix{j-1,p}) && isempty(final_matrix(j,p)))
                    else
                        diff_array(j-1,p/2)=final_matrix{j-1,p} - final_matrix{j,p};
                    end
                end
            end
           end
           
           [x,y]=min(diff_array(num-1,1:matlen/2));
           passwd(y)=final_matrix{2,2*y-1};
           diff_array(num-1,y)=Inf;
           disp(passwd);
           temp=passwd;
       end
end