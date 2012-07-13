function reviewResults(sandbox)

if sandbox==isSandboxMode
  system('./reviewResults.sh')
else
  fname = fullfile(getenv('MTURK_CMD_HOME'),'bin','mturk.properties');
  error('sandbox flag is not set in agreement with the service_url variable in %s',fname);
end

return;

% $$$ if sandbox
% $$$     unix('./reviewResults.sh -sandbox')
% $$$ else
% $$$     unix('./reviewResults.sh')
% $$$ end
