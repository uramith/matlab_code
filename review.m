results

base_dir = '/home/amith/project/fish track/newsampe';
 f_list =  dir('*tif');
c=0;
 for t =300:3:400%(length(f_list))-1 %S_frame:length(f_list)
    c=c+1;
    clf;
    img = imread(f_list(t).name);
    imshow(img);
    hold on;
    
    %plot(Y{c}(:),X{c}(:),'r.'); % the actual tracking
   % labels=cellstr( num2str(j));
   %         text(Y{i}(j),X{i}(j),labels,'VerticalAlignment','bottom','HorizontalAlignment','left','FontSize',.1)
       
   % T = size(Q_loc_estimateX,2);
    Ms = [3]; %marker sizes
    c_list = ['r' 'b' 'g' 'c' 'm' 'y'];
    for Dc = 1:nF
        if ~isnan(Q_loc_estimateX(c,Dc))
            Sz = mod(Dc,1)+1; %pick marker size
            Cz = mod(Dc,6)+1; %pick color
            if c < 52
            
             st = c-1;
            else
                st = 50;
            end
            tmX = Q_loc_estimateX(c-st:c,Dc);
            tmY = Q_loc_estimateY(c-st:c,Dc);
            plot(tmY,tmX,'.-','markersize',Ms(Sz),'color',c_list(Cz),'linewidth',1)
            plot(centrd(c,2),centrd(c,1),'b.')
         %   labels=cellstr( num2str(j));
         %   text(Y{i}(j),X{i}(j),labels,'VerticalAlignment','bottom','HorizontalAlignment','left','FontSize',.1)
       
            axis off
            %countrk=length(tmX)
        end
    end
    
    t
    pause(0.1)%
end

