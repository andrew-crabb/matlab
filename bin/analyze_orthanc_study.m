% ANALYZE_ORTHANC_STUDY Analyze DICOM files stored on Orthanc server
% 
% Usage: analyze_orthanc_study(url, username, password)
%   URL: Top-level URL in the form 'example.com'
%   
% Orthanc API reference: http://bit.ly/2usHQj6

function analyze_orthanc_study(url, username, password)
	options = weboptions('Username', username, 'Password', password, 'Timeout', 30);
	studies  = orthanc_get_all(url, options, 'studies');
	patients = orthanc_get_all(url, options, 'patients');

	disp(sprintf('%d studies found', size(studies, 1)));
	disp(sprintf('%d patients found', size(patients, 1)));


	num_studies = numel(studies);
	for n = 1:3
		study_id = studies{n};
		study_url = strjoin({'studies', study_id}, '/');
		study = orthanc_get_all(url, options, study_url);
		summary = orthanc_summarize_study(study);
		% disp(summary);
		archive_dir = make_archive_dir(study);
		if dir_exists(archive_dir)
			disp(['Skipping ', archive_dir])
		else
			disp(['Creating    ', archive_dir])
			if mkdir(archive_dir) == 1
				study_zip_file = strcat(study_id, '.zip');
			 	full_zip_file = strjoin({archive_dir, study_zip_file}, '/');
				study_archive_url = strjoin({study_url, 'archive'}, '/');
			 	disp(['Downloading ', study_archive_url, ' to ', full_zip_file]);
				study_contents = orthanc_get_all(url, options, study_archive_url);
				file_id = fopen(full_zip_file, 'w');
				fwrite(file_id, study_contents);
			end
		end


		% study_archive_url = strjoin({studies_url, 'archive'}, '/');
		% study_zip_file = strcat(getenv('HOME'), 'data', 'aric', first_series_id, '.zip')

		% study_all_series_url = strjoin({'studies', studies{n}, 'series'}, '/');
		% study_all_series = orthanc_get_all(url, options, study_all_series_url);
		% disp(study_all_series_url);
		% study_all_series(1).MainDicomTags
		% first_series_id = study_all_series(1).ID;
		% series_zip_file = strcat('/Users/ahc/', first_series_id, '.zip')
		% study_first_series_url = strjoin({'series', study_all_series(1).ID, 'archive'}, '/');
		% disp(study_first_series_url);
		% study_first_series = orthanc_get_all(url, options, study_first_series_url);
		% file_id = fopen(series_zip_file, 'w');
		% fwrite(file_id, study_first_series);

	end
end

function exists = dir_exists(indir)
	exists = false;
	if exist(indir, 'dir') == 7
		contents = dir(indir);
		s = size(contents);
		if s(1) > 2
			exists = true;
		end
	end
end

function archive_dir = make_archive_dir(study)
	institution_name = study.MainDicomTags.InstitutionName;
	inst_name = institution_name(~isspace(institution_name));
	study_date       = study.MainDicomTags.StudyDate;
	study_time       = study.MainDicomTags.StudyTime;
	date_time = strjoin({study_date, study_time}, '_');
	study_description = study.MainDicomTags.StudyDescription;
	archive_dir = strjoin({getenv('HOME'), 'data', 'aric', inst_name, date_time}, '/');
end