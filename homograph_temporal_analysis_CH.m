% 06/03/2021
% CRP script for Melissa & Sarah 

dir = strcat(pwd);
delimiterIn = ',';

% original data file contains three columns: 
% (1) subjects
% (2) word recalled (text)
% (3) recall_studypos (the order in which the recalled item was studied)

exp = importdata('data/recall_studypos.csv',delimiterIn); 
data.subjects = unique(exp.data(:,1)); % subject # (N = 70, ranges from #1 to #72)
data.listlength = 48; 

% we want to have each participant's recall_studypos in each row, not column  
tmp_rec_studypos = exp.data;
rec_count = NaN(length(data.subjects),1);
% find out max recall length 
for i = 1:length(data.subjects)
    indv_recall = tmp_rec_studypos(tmp_rec_studypos(:,1)==data.subjects(i,1),2)'; % recall data of subject [i] in a row form
    rec_count(i,1) = length(indv_recall); % how many items each participants recalled 
end
max_recs = max(rec_count);

rec = nan(length(data.subjects), max_recs);
data.recalls_studypos =  nan(length(data.subjects), max_recs);
for i = 1:length(data.subjects)
    for j = 1:max_recs
        rec = tmp_rec_studypos(tmp_rec_studypos(:,1)==data.subjects(i,1),2)';
        for k = 1:length(rec)
            data.recalls_studypos(i,k) = rec(1,k);
        end
    end
end
%%  #1. Conditional Response Probability 
% crp   Conditional response probability as a function of lag (lag-crp).
%  
%    lag_crps = crp(recalls_matrix, subjects, list_length, ...
%                   from_mask_rec, to_mask_rec, from_mask_pres, to_mask_pres)
%  
%    INPUTS:
%    recalls_matrix:  a matrix whose elements are serial positions of recalled
%                     items.  The rows of this matrix should represent recalls
%                     made by a single subject on a single trial.
%  
%          subjects:  a column vector which indexes the rows of recalls_matrix
%                     with a subject number (or other identifier).  That is, 
%                     the recall trials of subject S should be located in
%                     recalls_matrix(find(subjects==S), :)
%  
%       list_length:  a scalar indicating the number of serial positions in the
%                     presented lists.  serial positions are assumed to run 
%                     from 1:list_length.
%  
lag_crp = crp(data.recalls_studypos, data.subjects, data.listlength);

%% #2. Serial position curve (recall probability by serial position)
% p_recall = spc(recalls_matrix, subjects, list_length, rec_mask, pres_mask)

p_recall = spc(data.recalls_studypos, data.subjects, data.listlength);

%% #3. Temporal Factor analysis 
% Lag-based temporal clustering factor.
data.temp_facts = temp_fact(data.recalls_studypos, data.subjects, data.listlength); 

%% figures 
figure(1); % crp 
f1 = plot_crp(lag_crp);
set(f1,'Color','#6495ED','markersize',5,'MarkerEdgeColor','#6495ED','MarkerFaceColor','#6495ED'); 
ylabel('Conditional Response Probability'); ylim([0 0.6]);
xlabel('Lag'); xticks(-5:1:5);



figure(2); % spc
f2 = plot_spc(p_recall);
set(f2,'Color','#2E8B57','markersize',5,'MarkerEdgeColor','#2E8B57','MarkerFaceColor','#2E8B57');
ylabel('Probability of Recall');
xlabel('Serial position'); xticks([1 3 6 9 12 15 18 21 24 27 30 33 36 39 42 45 48]);

% Style
set(findall(groot,'Type','axes'),'FontName','Calibri');
set(findall(groot,'Type','axes'),'FontSize',18);
