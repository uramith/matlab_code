function [darkid,litid] = find_region(lpos,x1,x2,y1,y2)
        
%         lpos=petlarvae{i,j};
        darkid=[];
        litid=[];
        p=0;
        q=0;
        
        for k=1:length(lpos(:,1))
            
            x3=lpos(k,1);
            y3=lpos(k,2);
            
            m=[x1-x3 x2-x3;y1-y3 y2-y3];
            chk=det(m);
            
            if chk >= 0
               
                p=p+1;
                darkid(p,1)=k;
            
            else
                
                q=q+1;
                litid(q,1)=k;
            end
            
        end
end