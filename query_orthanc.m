% QUERY_ORTHANC Run queries on an Orthanc REST API
%
% Usage: query_orthanc(url, username, password)
%   URL: Top-level URL in the form 'example.com'

function query_orthanc(url, username, password)

	options = weboptions('Username', username, 'Password', password);
	topurl = strcat('https://', url, '/orthanc');

	patient_url = strcat(topurl, '/patients');
	patients = webread(patient_url, options);

	study_url = strcat(topurl, '/studies');
	studies = webread(study_url, options);

	out = sprintf('%d studies found for %d patients\n', size(studies, 1), size(patients, 1));
	disp(out);
end
