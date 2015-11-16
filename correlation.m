%%correlation 
% tic;
% V{max(data_sheet(:,1))}=[];
% pos{max(data_sheet(:,1))}=[];
% [pos,vel,acln]=makecells(data_sheet,steps);
function [coreln_sum]=correlation(vel,pos)
u{length(vel)}=[];
us{length(vel)}=[];

    for i=1:length(vel)
%     
%     clear index test_frame;
%     index=find(data_sheet(:,1) == i);
%     test_frame=(data_sheet(index,:));
%     tp= (~isnan(test_frame(:,7:8)).*test_frame(:,3:4));
%     tp(tp ==0)=nan;
%     indx=find(~isnan(tp(:,1)));
%     tp1=tp(indx,:);
%     pos{i}=tp1;
%     V{i}=test_frame(:,7:8);
%     %a{i}=acceleration(V{i},V{i-1})
    u{i}=mean_fluctuation(vel{i});
%     a{i}=mean_fluctuation(acln{i});
    us{i}=mean_fluctuation_speed(vel{i});
    %velocities=vel_fluch{i};
    
    end
%toc
% to find Co
[Co_coreln]=Co_correlation(u);
[Co_coreln_spd]=Co_correlation(us);
%tic;
% function [Co_coreln]=Co_correlation(u)
% for k=1:length(u)
%     %for i=1:length(u{1,k})     
%         Co_coreln(k,:) = dot(u{1,k},u{1,k});
%         co_coreln_spd(k,:)=dot(us{1,k},us{1,k});
%     %end
% end
% end
%toc
% find fishes with fixed distance r and calculate correlation
%tic;
    for k=1:length(u)          % kth frame
        posids=range_distance(pos{k},0,100,10);
        for j=1:length(posids) % j represents different r.
            for i=1:length(posids{1,j}) % i represents individuals satisying delta condition
                corrln = (u{1,k}(i,1)*u{1,k}(posids{1,j}{1,i},1))+(u{1,k}(i,2)*u{1,k}(posids{1,j}{1,i},2));
                corrln_s = ((us{1,k}(i,1))*(us{1,k}(posids{1,j}{1,i},1)));%+...
                    %((u{1,k}(i,2))*(u{1,k}(posids{1,j}{1,i},2)));
                coreln(i,j,k)= (1/sum(Co_coreln(k,:)))*(sum(corrln)/length(corrln));
                coreln_spd(i,j,k)= (1/sum(Co_coreln_spd(k,:)))*(sum(corrln_s)/length(corrln_s));
            end
        end
        k
    end
%toc
% 
%tic;
coreln(isnan(coreln))=0;
    for k=1:length(coreln(1,1,:))
        for j=1:length(coreln(1,:,k))

        corelation(k,j)=sum(coreln(:,j,k));
        corelation_speed(k,j)=sum(coreln_spd(:,j,k));
        end
    end
corelation(isnan(corelation))=0;
coreln_sum=sum(corelation(:,:))/length(corelation(:,1));
corelation_speed(isnan(corelation_speed))=0;
corelnspd_sum=sum(corelation_speed(:,:))/length(corelation_speed(:,1));
figure, plot(coreln_sum,'r.');
figure, plot(corelnspd_sum,'b.');
% toc
end