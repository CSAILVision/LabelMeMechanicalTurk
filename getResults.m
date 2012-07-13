function getResults(sandbox)

if sandbox==isSandboxMode
  system('./getResults.sh')
else
  fname = fullfile(getenv('MTURK_CMD_HOME'),'bin','mturk.properties');
  error('sandbox flag is not set in agreement with the service_url variable in %s',fname);
end

return;


% $$$ if sandbox
% $$$     unix('./getResults.sh -sandbox')   % this will create the file labelme.results.xls
% $$$ else
% $$$     unix('./getResults.sh')
% $$$ end
