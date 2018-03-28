% ANALYZE_ORTHANC_STUDY Analyze DICOM files stored on Orthanc server
% 
% Usage: analyze_orthanc_study(url, username, password)
%   URL: Top-level URL in the form 'example.com'

function analyze_orthanc_study(url, username, password)
	options = weboptions('Username', username, 'Password', password);
	studies = orthanc_get_all(url, options, 'studies');
	patients = orthanc_get_all(url, options, 'patients');

	disp(sprintf('%d studies found', size(studies, 1)));
	disp(sprintf('%d patients found', size(patients, 1)));

	num_studies = numel(studies);
	for n = 1:num_studies
		study = orthanc_get_all(url, options, 'studies', studies{n});
		summary = orthanc_summarize_study(study);
		disp(summary);
	end
end
