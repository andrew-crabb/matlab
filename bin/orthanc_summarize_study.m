% ORTHANC_SUMMARIZE_STUDY Print a one-line summary of a study received from Orthanc
% 
% Usage: orthanc_summarize_study(study)
%   study: JSON object received from Orthanc REST /studies/xxxx
  
function summary = orthanc_summarize_study(study)
	% study.MainDicomTagss
	institution_name = study.MainDicomTags.InstitutionName;
	study_date       = study.MainDicomTags.StudyDate;
	study_time       = study.MainDicomTags.StudyTime;
	study_description = study.MainDicomTags.StudyDescription;
	summary = sprintf("%-12s%-12s%-30s%-30s", study_date, study_time, institution_name, study_description);
	% disp(summary);
end