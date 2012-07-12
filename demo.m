% This script demonstrates how to submit tasks, retrieve results, and pay
% Mechanical Turk workers.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STEP 0: Download the LabelMe Matlab Toolbox
% (http://labelme.csail.mit.edu/LabelMeToolbox/index.html) and add it to
% the path
addpath /path/to/LabelMeToolbox;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STEP 1: PREDEFINE THE LIST OF TASKS (each image to label is one task)
%
labelme_folder = ENTER_FOLDER_NAME_HERE;
sandbox = 1; % Set this to 0 to submit tasks to users

generateLabelMeInputFile(labelme_folder,sandbox);
% HITS: you can remove specific tasks by editting the file 'labelme.input' and
% deleting lines from it
% PRICE: To change the price of a task, edit the file 'labelme.properties'

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STEP 2: SUBMIT HITS
%
% (for this to work the next environment variables need to be defined)
%MTURK_CMD_HOME=/Applications/aws-mturk-clt-1.3.0  (put your path here)
%JAVA_HOME=/usr(put your path here)
if sandbox
    unix('./run.sh -sandbox ')
else
    unix('./run.sh')
end
return


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STEP 3: DOWNLOAD SUMMARY RESULTS and review them:
%
if sandbox
    unix('./getResults.sh -sandbox')   % this will create the file labelme.results.xls
else
    unix('./getResults.sh')
end
return


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STEP 4: PAY WORKERS
%
if sandbox
    unix('./reviewResults.sh -sandbox')
else
    unix('./reviewResults.sh')
end
return



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STEP 5: REMOVE HITS
%
if sandbox
    unix('./approveAndDeleteResults.sh -sandbox')
else
    unix('./approveAndDeleteResults.sh')
end
return


