%% IMAGE UPLOAD
[file, path] = uigetfile({'*.png;*.jpg;*.jpeg;*.bmp'}, 'Select X-ray for Analysis');
if isequal(file,0), return; end 
img = imread(fullfile(path, file));

%% AI PROCESSING
if size(img, 3) == 3, grayImg = rgb2gray(img); else, grayImg = img; end
imgResized = imresize(grayImg, [256 256]);
[C, scores] = semanticseg(imgResized, MasterImplantAI);
if ndims(scores) == 3, prob = scores(:,:,2); else, prob = double(C == 'Implant'); end

%% 3. ULTRA-PRECISION DETECTION
% Very bright areas should stay
binaryMask = prob > (max(prob(:)) * 0.75); 

% combine close pieces
binaryMask = imclose(binaryMask, strel('disk', 5));

% Find the biggest area
stats = regionprops(binaryMask, 'Area', 'PixelIdxList', 'ConvexHull');
if ~isempty(stats)
    [~, largestIdx] = max([stats.Area]);
    % only capture the boundaries of the largest object
    finalPoly = stats(largestIdx).ConvexHull;
else
    finalPoly = [];
end

%% OUTPUT
close all;
figure('Color', 'w', 'Name', 'Final Prosthesis Detection');
imshow(imgResized); hold on;

if ~isempty(finalPoly)
    % Polyglon points
    plot(finalPoly(:,1), finalPoly(:,2), 'b', 'LineWidth', 2.5); 
    plot(finalPoly(:,1), finalPoly(:,2), 'bo', 'MarkerFaceColor', 'b', 'MarkerSize', 5);
    
    text(mean(finalPoly(:,1)), min(finalPoly(:,2))-15, 'IMPLANT IDENTIFIED', ...
        'Color', 'blue', 'FontSize', 11, 'FontWeight', 'bold', 'HorizontalAlignment', 'center');
    title('ANALYSIS COMPLETE: POSITIVE', 'FontSize', 14, 'Color', 'b');
else
    title('ANALYSIS COMPLETE: NEGATIVE', 'FontSize', 14, 'Color', 'r');
end