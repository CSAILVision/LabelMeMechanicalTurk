function removeHits(sandbox)

if sandbox==isSandboxMode
  unix('./approveAndDeleteResults.sh')
else
  fname = fullfile(getenv('MTURK_CMD_HOME'),'bin','mturk.properties');
  error('sandbox flag is not set in agreement with the service_url variable in %s',fname);
end

return;

% $$$ if sandbox
% $$$     unix('./approveAndDeleteResults.sh -sandbox')
% $$$ else
% $$$     unix('./approveAndDeleteResults.sh')
% $$$ end
