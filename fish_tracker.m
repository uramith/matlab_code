% clear all;
% 
% load('fishtrack_clip11_1-100.mat');
% 
% %videoread=vision.VideoFileReader('clip1.avi');
% videoread=VideoReader('clip11.avi');
% nframe=videoread.NumberOfFrames;

%% define main variables for KALMAN FILTER! :P
dt = 1;  %our sampling rate
S_frame = 150; % find(cellfun(@length, X)>11,1); %starting frame

%now, since we have multiple flies, we need a way to deal with a changing
%number of estimates! this way seems more clear for a tutorial I think, but
%there is probably a much more efficient way to do it.

u = 1; % define acceleration magnitude to start
HexAccel_noise_mag = 10; %process noise: the variability in how fast the Hexbug is speeding up (stdv of acceleration: meters/sec^2)
tkn_x = 1;  %measurement noise in the horizontal direction (x axis).
tkn_y = 1;  %measurement noise in the horizontal direction (y axis).
Ez = [tkn_x 0; 0 tkn_y];
Ex = [dt^4/4 0 dt^3/2 0; ...
    0 dt^4/4 0 dt^3/2; ...
    dt^3/2 0 dt^2 0; ...
    0 dt^3/2 0 dt^2].*HexAccel_noise_mag^2; % Ex convert the process noise (stdv) into covariance matrix
P = Ex; % estimate of initial Hexbug position variance (covariance matrix)

%% Define update equations in 2-D! (Coefficent matrices): A physics based model for where we expect the HEXBUG to be [state transition (state + velocity)] + [input control (acceleration)]
A = [1 0 dt 0; 0 1 0 dt; 0 0 1 0; 0 0 0 1]; %state update matrice
B = [(dt^2/2); (dt^2/2); dt; dt];
C = [1 0 0 0; 0 1 0 0];  %this is our measurement function C, that we apply to the state estimate Q to get our expect next/new measurement




%% initize result variables
Q_loc_meas = []; % the fly detecions  extracted by the detection algo
%% initize estimation variables for two dimensions
Q= [X{S_frame} Y{S_frame} zeros(length(X{S_frame}),1) zeros(length(X{S_frame}),1)]';
Q_estimate = nan(4,1000);
Q_estimate(:,1:size(Q,2)) = Q;  %estimate of initial location estimation of where the flies are(what we are updating)
Q_loc_estimateY = nan(nframe-initial_frame,10000); %  position estimate
Q_loc_estimateX= nan(nframe-initial_frame,10000); %  position estimate
P_estimate = P;  %covariance estimator
strk_trks = zeros(1,100000);  %counter of how many strikes a track has gotten
nD = size(X{S_frame},1); %initize number of detections
nF = find(isnan(Q_estimate(1,:))==1,1)-1 ; %initize number of track estimates

Q_loc_estimateX1=nan(size(Q_loc_estimateX,1),10000);
Q_loc_estimateY1=nan(size(Q_loc_estimateY,1),10000);
    
%for each frame
c=0;
%for t = S_frame:((length(f_list)))-1 

%while ~isDone(videoread);

for c=150:500
%      c=c+1
  % c=c+1;
    
    % load the image
   % img_tmp = double(imread(f_list(t).name));
%     img_tmp=read(videoread,i);
%     img_tmpd=double(img_tmp);
%     img = img_tmpd(:,:,1);
    % make the given detections matrix
    Q_loc_meas = [X{c} Y{c}];
    
        
    
    %% do the kalman filter
    % Predict next state of the flies with the last state and predicted
    % motion.
    nD = size(X{c},1); %set new number of detections
    for F = 1:nF
       Q_estimate(:,F) = A * Q_estimate(:,F) + B * u;
    end
    
    %predict next covariance
    P = A * P* A' + Ex;
    % Kalman Gain
    K = P*C'*inv(C*P*C'+Ez);
    
    
    %% now we assign the detections to estimated track positions
    %make the distance (cost) matrice between all pairs rows = tracks, coln
    %= detections
    est_dist = pdist([Q_estimate(1:2,1:nF)'; Q_loc_meas]);
    est_dist = squareform(est_dist); %make square
    est_dist = est_dist(1:nF,nF+1:end) ; %limit to just the tracks to detection distances 
    clear indx; indx=find(~isnan(est_dist(:,1))); % for reassigning 
    est=short(est_dist,nF); % make est_dist short so that assignmentoptimal runs faster
    set(0,'RecursionLimit',1000);
    [asgnt, cost] = assignmentoptimal(est); %do the assignment with hungarian algo
    asgnt = asgnt'; 
    
    asgn = zeros(1,nF);
    asgn(indx)=asgnt;
    
    % ok, now we check for tough situations and if it's tough, just go with
    % estimate and ignore the data
    %make asgn = 0 for that tracking element
    
    %check 1: is the detection far from the observation? if so, reject it.
    rej = [];
    for F = 1:nF
        if asgn(F) > 0
   
         rej(F) = est_dist(F,asgn(F)) < 5;
        else
            rej(F) = 0;
        end
    end
    asgn = asgn.*rej;
           
    %apply the assingment to the update
    k = 1;
    for F = 1:length(asgn)
        if asgn(F) > 0
            Q_estimate(:,k) = Q_estimate(:,k) + K * (Q_loc_meas(asgn(F),:)' - C * Q_estimate(:,k));
        end
        k = k + 1;
    end
    
    % update covariance estimation.
    P =  (eye(4)-K*C)*P;
    
    %% Store data
    Q_loc_estimateX(c,1:nF) = round(Q_estimate(1,1:nF));
    Q_loc_estimateY(c,1:nF) = round(Q_estimate(2,1:nF));
    
    %------------------------------------------------------
%     clear locestimate; locestimate=Q_loc_estimateX1(c-1,:);
%     s=find(~isnan(locestimate))
%     
%         if ismember(mod(nf,1000),s)
%             dm=
%     end
%     dm=0;
%     for nf=1:nF
%         
%        
%         if ~isnan(Q_estimate(1,nf))
%            if c > 5 
%                free= true;
%                 while free
%                     
%                     if ~isnan(Q_loc_estimateX1((c-1),mod(nf,1000)+1)) && Q_loc_estimateX((c-1),
%                             
%                             
%                         
%                     dm=nf;
%                     else
%                     dm=nf+1;
%                     end
%                     
%                     if isnan(Q_loc_estimateX1((c-5):c,mod(nf,1000)+1))
%                     free= false;
%                     end
%                 end
%             Q_loc_estimateX1(c,mod(dm,1000)+1)=round(Q_estimate(1,nf));
%             Q_loc_estimateY1(c,mod(dm,1000)+1)=round(Q_estimate(2,nf));
%            else
%             Q_loc_estimateX1(c,mod(dm,1000)+1)=round(Q_estimate(1,nf));
%             Q_loc_estimateY1(c,mod(dm,1000)+1)=round(Q_estimate(2,nf));  
%            end
%         end
%     end
    
    %ok, now that we have our assignments and updates, lets find the new
    %detections and lost trackings
    
    %find the new detections. basically, anything that doesn't get assigned
    %is a new tracking
    new_trk = [];
    new_trk = Q_loc_meas(~ismember(1:size(Q_loc_meas,1),asgn),:)';
    if ~isempty(new_trk)
        
        Q_estimate(:,nF+1:nF+size(new_trk,2))=  [new_trk; zeros(2,size(new_trk,2))];
        nF = nF + size(new_trk,2);  % number of track estimates with new ones included
    end
    
    
    %give a strike to any tracking that didn't get matched up to a
    %detection
    no_trk_list =  find(asgn==0);
    if ~isempty(no_trk_list)
        strk_trks(no_trk_list) = strk_trks(no_trk_list) + 1;
    end
    
    %if a track has a strike greater than 6, delete the tracking. i.e. make
    %it nan first vid = 3
    bad_trks = find(strk_trks > 0);
    Q_estimate(:,bad_trks) = NaN;
%--------------------------------------------------------------------------    
    % Just for Visualization
%    clf
%     %img = imread(f_list(t).name);
%     imshow(img_tmp);
%     hold on;
%    % plot(Y{c}(:),X{c}(:),'r.'); % the actual tracking
%    % T = size(Q_loc_estimateX,2);
%     Ms = [1]; %marker sizes
%     c_list = ['r' 'b' 'g' 'c' 'm' 'y'];
%     for Dc = 1:nF
%         if ~isnan(Q_loc_estimateX(c,Dc))
%             Sz = mod(Dc,1)+1; %pick marker size
%             Cz = mod(Dc,6)+1; %pick color
% %             if c < 21
% %                 st = c-1;
% %             else
% %                 st = 19;
% %             end
%             tmX = Q_loc_estimateX(1:c,Dc);%(c-st:c,Dc);
%             tmY = Q_loc_estimateY(1:c,Dc);%(c-st:c,Dc);
%             plot(tmY,tmX,'.-','markersize',Ms(Sz),'color',c_list(Cz),'linewidth',1)
% %             %plot(centrd(c,2),centrd(c,1),'b.')
% %             axis off
%         end
%    end
%    pause(0.1)
%     
    %}
    c
end

% datasheet