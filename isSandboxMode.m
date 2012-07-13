function isSandbox = isSandboxMode
% This function checks mturk.properties to see if we are in sandbox mode
% or live (pay money) mode.

urlSandbox = 'https://mechanicalturk.sandbox.amazonaws.com/?Service=AWSMechanicalTurkRequester';
urlLive = 'https://mechanicalturk.amazonaws.com/?Service=AWSMechanicalTurkRequester';

% Get location of aws-mturk-clt-1.3.0:
mturk_cmd_home = getenv('MTURK_CMD_HOME');

% Check to see if the MTURK_CMD_HOME environment variable has been set:
if isempty(mturk_cmd_home)
  error(sprintf('\n\nThe MTURK_CMD_HOME environment variable has not been set. To set within bash, run the following:\n\nexport MTURK_CMD_HOME=/your/path/to/aws-mturk-clt-1.3.0\n\n'));
  return;
end

% Variables to determine:
isSet = 0; % Whether service_url is set.
isSandbox = 0; % 1 - sandbox mode; 0 - live (pay money) mode

% Read mturk.properties:
fname = fullfile(mturk_cmd_home,'bin','mturk.properties');
fp = fopen(fname);
while 1
  tline = fgetl(fp);
  if ~ischar(tline), break, end
  loc = strfind(tline,'service_url');
  if loc==1
    if isSet
      error('\n\nThere are multiple lines that set service_url inside:\n\n%s\n\nRemove or comment out all but one of the lines.',fname);
      return;
    end
    isSet = 1;
    if strfind(tline,urlSandbox)
      isSandbox = 1;
    elseif strfind(tline,urlLive)
      isSandbox = 0;
    else
      error('\n\nservice_url is not set to a valid URL inside:\n\n%s\n\nSet to one of the following URLs:\n\nservice_url=%s # For live (pay money) mode\n\nservice_url=%s # For sandbox mode\n\n',fname,urlLive,urlSandbox);
      return;
    end
  end
end
fclose(fp);

% Check if service_url has been set:
if isSet == 0
  error('\n\nNeed to set service_url inside:\n\n%s\n\nInclude one of the following lines:\n\nservice_url=%s # For live (pay money) mode\n\nservice_url=%s # For sandbox mode\n\n',fname,urlLive,urlSandbox);
  return;
end
