% FaceClassify.m

% Config variables
NNClassification = 1;
SVMClassification = 0;
trainingSetSize = 25;       
grayscaleFilter = 0;        % Set to 1 to use grayscale
nRGB = 3;                   % The number of channels we are using
workingImSz = 32;           % Resize for efficiency


names={'barroso','calderon','cameron','erdogan','gillard','harper','hollande','jintao','kirchner','merkel'...
    ,'monti','myungbak','noda','obama','putin','rompuy','rousseff','singh','yudhoyono','zuma'};
nPeople=20;   % number of people (rows of dataIm)
nExamples=32; % number of examples per person (columns of dataIm)
imsz=64;      % size of face images in dataIm (square)

% Load Viola-Jones detection rectangles and set ground truth
load('../data/vjrects', 'rects');
test_true = {'kirchner', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'monti', 'harper', 'barroso', 'hollande', 'rousseff', 'x', 'cameron', ...
    'x', 'noda', 'yudhoyono', 'calderon', 'putin', 'x', 'rompuy', 'merkel', 'x', 'x', 'obama', 'singh', 'jintao', 'zuma','myungbak'};

% Load the main G20 image and the 640 faces
im = double(imread('../data/g20.jpg'))/255;
dataIm = double(imread('../data/facedata.png'))/255;

if grayscaleFilter == 1
    disp('[Converting Face Data to Grayscale]');
    im = mean(im,3);
    dataIm = mean(dataIm, 3);
end

% Assign matrix to hold the G20 faces
nRects = size(rects, 1);
g20data = zeros(nRects, (workingImSz * workingImSz * nRGB));

% Use VJ rectangles to get the G20 test faces
for i = 1:nRects
    imi = im(rects(i, 1):rects(i, 3), rects(i, 2):rects(i, 4), :);
    imf = imresize(imi, [workingImSz workingImSz]); % Resize for efficiency
    g20data(i, :) = imf(:);
end;

% Get all image data to use throughout classification
allData = ReadImageData(dataIm,nPeople,nExamples, workingImSz);

if NNClassification == 1
    disp('[Nearest Neighbour Classification]');
    % Use the transpose of G20 faces
    test_pred = NearestNeighbourClassification(allData, g20data', nPeople, nExamples);
end

if SVMClassification == 1
    % Decide sizes of test and training sets
    testSetSize = nExamples - trainingSetSize;

    % Now split this into separate arrays
    trainingSet = allData(1:trainingSetSize);
    testSet = allData(trainingSetSize+1:nExamples);
end

% Evaluate the classification and plot results
EvaluateClassification(test_pred, test_true, names, rects, im);
