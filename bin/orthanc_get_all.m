% ORTHANC_GET_ALL Return all objects for given URL
%
% Usage: orthanc_get_all(url, options, path)
%   url:     Top-level URL in the form 'example.com'
%   options: Matlab weboptions object of username, password
%   path:    Path to add to url

function objects = orthanc_get_all(url, options, urlpath, identifier)
	top_url = strcat('https://', url, '/orthanc');
	path_url = strcat(top_url, '/', urlpath);
	% disp(path_url)
	if nargin > 3
    	path_url = strcat(path_url, '/', identifier);
  	end
  	% disp(path_url)

	objects = webread(path_url, options);
end
