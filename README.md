# homograph_SBS
temporal contiguity analyses with homograph data for Melissa @ SBS lab 

Analysis script: homograph_temporal_analysis_CH.m
- Three analyses outlined here
- (1) CRP (temporal conditional lag-based analysis)
- (2) SPC (Recall % of each item based on their serial position or study order)
- (3) Lag-based temporal factor score for each participant: Computed by ranking the absolute values of lags (|lag|) of each actual transition with respect to the |lag| of all transitions that were possible at that time, providing a percentile score for each transition. The final score is computed by averaging these percentiles across all of subject's transition: a score of .5 = transitions are random with respect to a temporal lag vs. a value above .5 = evidence for temporal contiguity
