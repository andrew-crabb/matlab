% ANALYZE_ORTHANC_STUDY Analyze DICOM files stored on Orthanc server
% 
% Usage: analyze_orthanc_study(url, username, password)
%   URL: Top-level URL in the form 'example.com'
%   
% Orthanc API reference: http://bit.ly/2usHQj6

function analyze_orthanc_study(url, username, password)
	options = weboptions('Username', username, 'Password', password);
	studies = orthanc_get_all(url, options, 'studies');
	patients = orthanc_get_all(url, options, 'patients');

	disp(sprintf('%d studies found', size(studies, 1)));
	disp(sprintf('%d patients found', size(patients, 1)));


	num_studies = numel(studies);
	for n = 1:1
		disp('study ' + n);
		studies_url = strjoin({'studies', studies{n}}, '/');
		study = orthanc_get_all(url, options, studies_url);
		summary = orthanc_summarize_study(study);
		disp(summary);
		study_all_series_url = strjoin({'studies', studies{n}, 'series'}, '/');
		study_all_series = orthanc_get_all(url, options, study_all_series_url);
		disp(study_all_series_url);
		study_all_series(1).MainDicomTags
		first_series_id = study_all_series(1).ID;
		series_zip_file = strcat('/Users/ahc/', first_series_id, '.zip')
		study_first_series_url = strjoin({'series', study_all_series(1).ID, 'archive'}, '/');
		disp(study_first_series_url);
		study_first_series = orthanc_get_all(url, options, study_first_series_url);
		file_id = fopen(series_zip_file, 'w');
		fwrite(file_id, study_first_series);

	end
end
