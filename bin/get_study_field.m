% GET_STUDY_FIELD Get structure field by name, using 'unknown' if field is missing
% 
% Usage: get_study_field(study, field)
%   study: JSON object received from Orthanc REST /studies/xxxx
%   field: Field to retrieve
% Returns: Char vector (not string) ie 'foo' not "foo"
  
function field_val = get_study_field(study, field)
	if isfield(study.MainDicomTags, field)
		field_val = getfield(study.MainDicomTags, field);
	else
		field_val = strcat('unknown', '_', field);
		% field_val = sprintf("%s_%s", 'unknown', field);
	end
	% disp(sprintf("get_study_field(%s) returning %s", field, field_val));
end