% FaceDetect.m
% Read source image 
disp('[ Reading source image ]');
imc = double(imread('../data/g20.jpg'))/255;

% Set to a grayscale image
imf = mean(imc, 3); 

% Use RGB channels
%imf = imc(:,:,1); % Red
%imc = imc(:,:,2); % Green
%imc = imc(:,:,3); % Blue

% Extract features from image
disp('[ Extracting features ]');

% Select a region for template matching
selectRegion = 0;
disp('[ Selecting template region ]');
if (selectRegion)
    fh = figure; imshow(imc);
    rect = floor(getrect);
    template = imf(rect(2):(rect(2)+rect(4)-1), rect(1):(rect(1)+rect(3)-1), :);
    template = mean(imt, 3);
    close(fh);
else
    % Use a fixed image of Barack Obama
    imt = double(imread('../data/obama.png'))/255;
    imt = imresize(imt, [33 33]);
    
    % Set the template as the grayscale of the fixed image
    template = mean(imt, 3);
end;

disp('[ Image Pre-Processing ]');

% Get the edges of the image & template. Filter to be horizontal only
imf = edge(imf, 'Sobel', 0.05, 'horizontal');
template = edge(template, 'Sobel', 0.05, 'horizontal');

% Blur the source image twice (do not blur the template)
imf = filter2(fspecial('average', [2 2]), imf);
imf = filter2(fspecial('average', [2 2]), imf);
    
% Get the normalised correlation of the image and the template
disp('[ Normalised Correlation ]');
resp = NormalisedCorrelation(imf, template);

% Display the normalised correlation to the screen
%figure, imshow(resp);

% Find local maxima with non-maximal suppression 
disp('[ Find local maxima ]');
suppDst = 17;
[maxVal, maxPos] = FindLocalMaxima(resp, suppDst);

% Display and evaluate detections
disp('[ Evaluate detections ]');
numDetections = 35;
EvaluateDetections(imc, template, maxPos, numDetections);
