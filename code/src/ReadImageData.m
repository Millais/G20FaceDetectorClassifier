function [ allData ] = ReadImageData( dataIm, nPeople, nExamples, workingImSz)
    
    % Define image size in large image to read
    imSz = 64;
    allData = cell(nPeople, nExamples);

    for i=1:nPeople
        for j = 1:nExamples
            
            % Get the next image's location in the larger image
            x = imSz * i;
            y = imSz * j;
            img = dataIm(x-(imSz-1):x, y-(imSz-1):y, :);

            % Normalise the image
            img = img - mean(img(:));
            img = img / std(img(:));
            
            % Resize after normalisation 
            img = imresize(img, [workingImSz workingImSz]);

            % Add to our final matrix
            allData{i,j} = img;
        end
    end