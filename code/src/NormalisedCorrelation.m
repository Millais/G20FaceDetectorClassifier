function [ output ] = NormalisedCorrelation(imf, template)


% Normalise the template
normalisedTemplate = normalise(template);

% Dimensions of main image
[x,y]=size(imf);

% Dimensions of template
[t_x,t_y]=size(template);

% Output matrix of summed vector dot products to return
output = zeros(x,y);

% Slide the template over the entire image and normalise the area of the
% image relative to the template (the patch)
for i = 1:(x - t_x)
    for j = 1:(y - t_y)
         % Get the normalised patch of the image
         normalisedPatch = normalise(imf(i : (i+t_x)-1, j : (j+t_y)-1, :));

         % Get the dot product of the template and patch
         dp = dot(normalisedTemplate, normalisedPatch);
         
         % Sum the values in the dot product and add to our output  
         output(i + floor(t_x/2), j + floor(t_y/2)) = sum(dp);
    end
end
   
end

function normalisedImg = normalise(img)
    normalisedImg = (img - mean2(img))./std2(img);
end

