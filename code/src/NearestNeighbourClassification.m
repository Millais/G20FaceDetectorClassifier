function [ testPred ] = NearestNeighbourClassification(validationData, g20, nPeople, nExamples)
        
    % Create an array to hold the predictions for our faces
    nOfTestFaces = size(g20, 2);
    testPred = zeros(nOfTestFaces);
    
    for i = 1:nOfTestFaces
        closestMatch = -1; % We want this closest to 0
        personIndex = -1;
        g20face = g20(:, i, :);

        for j = 1:nPeople
            for k = 1:nExamples
                candidateImg = validationData{j,k};
                % Get euclidean distance between images
                matchStrength = norm(candidateImg(:) - g20face);
                
                % Update our closest match if closer to the G20 face
                % Or get the initial match if it hasn't yet been set
                if matchStrength < closestMatch || closestMatch == -1
                    personIndex = j;
                    closestMatch = matchStrength;
                end
            end
        end
        
        % Assign the closest/nearest neighbour prediction
        testPred(i) = personIndex;
    end
    
end
