% ORTHANC_SUMMARIZE_STUDY Print a one-line summary of a study received from Orthanc
% 
% Usage: orthanc_summarize_study(study)
%   study: JSON object received from Orthanc REST /studies/xxxx
  
function summary = orthanc_summarize_study(study)
	study.MainDicomTags;
	% if isfield(study.MainDicomTags, 'InstitutionName')
	% 	institution_name = study.MainDicomTags.InstitutionName;
	% else
	% 	institution_name = 'unknown';
	% end
	institution_name = get_study_field(study, 'InstitutionName');
	study_date       = study.MainDicomTags.StudyDate;
	study_time       = study.MainDicomTags.StudyTime;
	% study_description = study.MainDicomTags.StudyDescription;
	study_description = get_study_field(study, 'StudyDescription');
	summary = sprintf("%-12s%-12s%-30s%-30s", study_date, study_time, institution_name, study_description);
	% disp(summary);
end