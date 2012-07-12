function generateLabelMeInputFile(folder,sandbox,N,HOMEIMAGES,introPage,outputFile,Nimages)
% Generate Amazon Mechanical Turk input file with set of images for
% workers to label.
%
% To start, contact us (http://labelme.csail.mit.edu/AboutMe.html) to
% upload your images.  We will put your images into a folder and send you
% the folder name.  We ask that your images do not contain any spaces or
% special characters and that the images have a .jpg extension.  Your
% images will live at:
%
% http://labelme.csail.mit.edu/Images/FOLDER
%
% To generate the Mechanical Turk input file, simply run the following in
% Matlab:
%
% folder = FOLDER;
% generateLabelMeInputFile(folder)
%
% The script will produce a file called "labelme.input".  Simply continue
% following the instructions in 
%
% http://labelme.csail.mit.edu/mechanicalturk.html
%
% to load jobs onto Mechanical Turk.
%
% This function is more flexible.  Here are additional parameters that
% can be used:
%
% generateLabelMeInputFile(folder,sandbox,N,HOMEIMAGES,introPage,outputFile)
%
% Inputs:
% sandbox - Set to 1 to run on Mechanical Turk Sandbox to debug (0 is
%           default).
% N - Number of required annotations the worker must enter in the image
%     to complete the task.  If 'inf' is entered, then the worker may
%     enter as many annotations as they wish.
% HOMEIMAGES - Path to FOLDER.  By default, this is set to the LabelMe
%              server.
% introPage - Set this to point to a URL with instructions for the
%             worker.  By default, this is set to
%             http://labelme.csail.mit.edu/mt_instructions.html
% outputFile - Set the name of the output file.  By default, this is
%              'labelme.input'.  It is recommended that this does not
%              change (otherwise the scripts to send the job to
%              Mechanical Turk will not run).
% Nimages - use only the first Nimages from the folder (by default create
%              HITS for all images)

if nargin < 2
  sandbox = 0;
end
if nargin < 3
  N = 'inf'; % The MT worker can label as many polygons as they wish.
end
if nargin < 4
  HOMEIMAGES = 'http://labelme.csail.mit.edu/Images';
end
if nargin < 5
  introPage = [];
end
if nargin < 6
  outputFile = 'labelme.input';
end

if ~isstr(N)
  N = lower(num2str(N));
end

% Get set of images:
if any(findstr(HOMEIMAGES,'http://'))
  % From LabelMe server:
  page = fullfile(HOMEIMAGES,folder);
  page = strrep(page, '\', '/');
  folders = urlread(page);
  folders = folders(1:length(folders));
  j1 = findstr(lower(folders), '<a href="');
  j2 = findstr(lower(folders), '</a>');
  Nfolders = length(j1);
  
  fn = 0;
  filenames = [];
  for f = 1:Nfolders
    tmp = folders(j1(f)+9:j2(f)-1);
    fin = findstr(tmp, '"');
    if length(findstr(tmp(1:fin(end)-1), '.jpg'))>0
      fn = fn+1;
      filenames(fn).name = tmp(1:fin(end)-1);
    end
  end
else
  % From local directory:
  filenames = dir(fullfile(HOMEIMAGES,folder,'*.jpg'));
end

% Get extra variables:
extraVars = '';
if sandbox
  extraVars = '&amp;mt_sandbox=true';
end
if ~isempty(introPage)
  extraVars = [extraVars sprintf('&amp;mt_intro=%s',introPage)];
end

if nargin < 7
  Nimages = length(filenames);
else
  Nimages = min(Nimages, length(filenames));
end

% Write to output file:
fp = fopen(outputFile,'w');
fprintf(fp,'urls\n');
for i = 1:Nimages
  fprintf(fp,'http://labelme.csail.mit.edu/tool.html?collection=LabelMe&amp;mode=mt&amp;N=%s&amp;folder=%s&amp;image=%s%s\n',N,folder,filenames(i).name,extraVars);
end
fclose(fp);


% create tasks page:
for i = 1:Nimages
  folderlist{i} = folder;
  filelist{i} = filenames(i).name;
end
disp('Open labelme.input.html to see the progress of the annotations')
LMphotoalbum(folderlist, filelist, 'labelme.input.html');
