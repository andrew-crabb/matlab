% ORTHANC_GET_ALL Return all objects for given URL
%
% Usage: orthanc_get_all(url, options, path)
%   url:     Top-level URL in the form 'example.com'
%   options: Matlab weboptions object of username, password
%   path:    Path to add to url

function objects = orthanc_get_all(baseurl, options, path)
	top_url = strcat('https://', baseurl, '/orthanc');
	path_url = strcat(top_url, '/', path);

	objects = webread(path_url, options);
end
