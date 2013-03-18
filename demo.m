% This script demonstrates how to submit tasks, retrieve results, and pay
% Mechanical Turk workers.

% For this to work, make sure the following environment variables are defined:
% MTURK_CMD_HOME=/your/path/to/aws-mturk-clt-1.3.0
% JAVA_HOME=/your/path/to/java

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STEP 0: Download the LabelMe Matlab Toolbox and add it to the path
% http://labelme.csail.mit.edu/LabelMeToolbox
addpath /your/path/to/LabelMeToolbox;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STEP 1: PREDEFINE THE LIST OF TASKS (each image to label is one task)

% You will need your LabelMe username and collection.  To get this,
% simply sign up for a LabelMe account (http://labelme.csail.mit.edu),
% create a collection, and add images to the collection.  Finally, set
% the following two variables with your LabelMe username and collection name.
username = ENTER_YOUR_USERNAME_HERE;
collection = ENTER_YOUR_COLLECTION_NAME_HERE;

% Set this to 0 to submit tasks to users (pay money mode).
% Set this to 1 to debug in the sandbox (free, no money).
sandbox = 1;

% Make sure to also set also set the "service_url" variable inside
% MTURK_CMD_HOME/bin/mturk.properties
%
% Sandbox mode:
% service_url=https://mechanicalturk.sandbox.amazonaws.com/?Service=AWSMechanicalTurkRequester
%
% Live (pay money) mode:
% service_url=https://mechanicalturk.amazonaws.com/?Service=AWSMechanicalTurkRequester

generateLabelMeInputFile(username,collection,sandbox);
% HITS: you can remove specific tasks by editing the file 'labelme.input' and
% deleting lines from it
% PRICE: To change the price of a task, edit the file 'labelme.properties'

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STEP 2: SUBMIT HITS
%
submitHits(sandbox);
return

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STEP 3: DOWNLOAD SUMMARY RESULTS and review them:
%
getResults(sandbox); % this will create the file labelme.results.xls
return

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STEP 4: PAY WORKERS
%
reviewResults(sandbox);
return

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STEP 5: REMOVE HITS
%
removeHits(sandbox);
return


