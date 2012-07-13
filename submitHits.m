function submitHits(sandbox)

if sandbox==isSandboxMode
  system('./run.sh')
else
  fname = fullfile(getenv('MTURK_CMD_HOME'),'bin','mturk.properties');
  error('\n\nsandbox flag is not set in agreement with the service_url variable in %s\n\n',fname);
end

return;

%%%%%
% The -sandbox flag does not work anymore.

% $$$ if sandbox
% $$$     unix('./run.sh -sandbox ')
% $$$ else
% $$$     unix('./run.sh')
% $$$ end
