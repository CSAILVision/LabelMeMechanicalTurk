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
%
% The sandbox is free to use (you have fake credits on this server), so
% you can test here to make sure everything works. When you are ready for
% the real thing, set sandbox=0 and run the remaining commands in this
% file. Make sure to add money to your Amazon account before running on
% the real server.
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
% PRICE: To change the price of a task, edit the file 'labelme.properties'.
% Currently, each HIT is priced at $0.01 per image. Please see the
% documentation for the Amazon Mechanical Turk Command Line Tools for
% more information.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STEP 2: SUBMIT HITS
%
submitHits(sandbox);
% You will see messages indicating that the jobs are being submitted. At
% the end, there will be a URL that points to a preview page for the
% HIT. You can go to that URL and try out the HIT. All of the collected
% annotations are stored on the LabelMe servers, so you can download them
% immediately.
%
% Note that Mechanical Turk workers will see the following set of
% instructions when they preview the HIT:
%
% http://labelme.csail.mit.edu/Release3.0/annotationTools/html/mt_instructions.html
%
% Once they accept the HIT, then they will be directed to the annotation
% tool.  If you wish to change the instructions page that is shown during
% preview mode, please see how to set the 'mt_intro' variable within the
% "Advanced features" section on the LabelMe/Mechanical Turk instructions
% page.
return

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STEP 3: DOWNLOAD SUMMARY RESULTS and review them:
%
getResults(sandbox);
% This will create the file 'labelme.results.xls'. This is a comma
% separated file, which can be viewed with Excel. This file lists the
% status of each HIT, as well as outputs from the annotation task, such
% as number of annotations labeled, last object labeled, etc.
return

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STEP 4: PAY WORKERS. It is important to pay the workers as soon as possible.
%
reviewResults(sandbox);
return

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STEP 5: REMOVE HITS FROM AMAZON SERVER.
%
removeHits(sandbox);
% When all of the HITs are completed, you can remove them from the Amazon
% server.
return


