clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
clear;  % Erase all existing variables. Or clearvars if you want.
workspace;  % Make sure the workspace panel is showing.
format long g;
format compact;
fontSize = 15;

%===============================================================================
% Get the name of the image the user wants to use.
baseFileName = 'images.png'; % Assign the one on the button that they clicked on.
% Get the full filename, with path prepended.
folder = []; % Determine where demo folder is (works with all versions).
fullFileName = fullfile(folder, baseFileName);

%===============================================================================
% Read in a demo image.
grayImage = imread(fullFileName);
% Get the dimensions of the image.
% numberOfColorChannels should be = 1 for a gray scale image, and 3 for an RGB color image.
[rows, columns, numberOfColorChannels] = size(grayImage);
if numberOfColorChannels > 1
	% It's not really gray scale like we expected - it's color.
	% Use weighted sum of ALL channels to create a gray scale image.
	grayImage = rgb2gray(grayImage);
	% ALTERNATE METHOD: Convert it to gray scale by taking only the green channel,
	% which in a typical snapshot will be the least noisy channel.
	% grayImage = grayImage(:, :, 2); % Take green channel.
end
% Display the image.
subplot(2, 3, 1);
imshow(grayImage, []);
axis on;
caption = sprintf('Original Gray Scale Image');
title(caption, 'FontSize', fontSize, 'Interpreter', 'None');
drawnow;
hp = impixelinfo();

% Set up figure properties:
% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
% Get rid of tool bar and pulldown menus that are along top of figure.
set(gcf, 'Toolbar', 'none', 'Menu', 'none');
% Give a name to the title bar.
set(gcf, 'Name', 'Demo by ImageAnalyst', 'NumberTitle', 'Off')
drawnow;

% Binarize the image by thresholding.
mask = grayImage > 128;
% Extract the largest blob only.
mask = bwareafilt(mask, 1);
subplot(2, 3, 2);
imshow(mask);
axis on;
axis image; % Make sure image is not artificially stretched because of screen's aspect ratio.
title('Binary Image Mask with boundaries shown in red', 'fontSize', fontSize);
drawnow;

% bwboundaries() returns a cell array, where each cell contains the row/column coordinates for an object in the image.
% Plot the borders of all the coins on the original grayscale image using the coordinates returned by bwboundaries.
hold on;
boundaries = bwboundaries(mask);
boundary = boundaries{1};
boundaryX = boundary(:, 2);
boundaryY = boundary(:, 1);
plot(boundaryX, boundaryY, 'r', 'LineWidth', 2);

% Find the centroid
props = regionprops(mask, 'Centroid');
centroidX = props.Centroid(1)
centroidY = props.Centroid(2)
% Plot a cross there
plot(centroidX, centroidY, 'r+', 'MarkerSize', 30);

% Find which boundary point is farthest from the centroid.
maxDistance = -inf;
distances = sqrt( (boundaryX - centroidX) .^ 2 + (boundaryY - centroidY) .^ 2 );
[thisMaxDistance, indexOfMaxDistance] = max(distances);
% Store the location of the most distant point from the centroid.
farthestX = boundaryX(indexOfMaxDistance)
farthestY = boundaryY(indexOfMaxDistance)
% Plot line to there
subplot(2, 3, 3);
imshow(mask);
axis on;
axis image; % Make sure image is not artificially stretched because of screen's aspect ratio.
title('Binary Image Mask with Most distant point shown', 'fontSize', fontSize);
drawnow;
hold on;
% Plot a cross there
plot(centroidX, centroidY, 'r+', 'MarkerSize', 30, 'LineWidth', 2);
% Plot line from centroid to most distant boundary point.
plot([centroidX, farthestX], [centroidY, farthestY], 'm-', 'LineWidth', 2);

% Find out which point is closest
endPoint1 = [centroidX, centroidY, 0];
endPoint2 = [farthestX, farthestY, 0]; 
for k = 1 : length(boundaryX)
	thisPoint = [boundaryX(k), boundaryY(k), 0]; 
	% Plot line from centroid to this boundary point.
	handleToLine = plot([centroidX, thisPoint(1)], [centroidY, thisPoint(2)], 'm-', 'LineWidth', 2);
	% Compute the distance.
	distance(k) = point_to_line(thisPoint, endPoint1, endPoint2);
	% Compute the angle
	% If the angle is not between 90 and 270 degrees, 
	angle(k) = atan2d(thisPoint(2) - centroidY , thisPoint(1) - centroidX);
	% it's on the same side as the farthest point, so ignore it.
	if angle(k) < 90 || angle(k) > 270
		distance(k) = inf;
	end
	% Remove the line we just plotted.
	delete(handleToLine);
end



% The ability to automatically calculate the shortest distance from a point to a line
% is not available in MATLAB. To work around this, see the following function:
% https://www.mathworks.com/matlabcentral/answers/95608-is-there-a-function-in-matlab-that-calculates-the-shortest-distance-from-a-point-to-a-line
% In this function, pt, v1, and v2 are the three-dimensional coordinates of the point,
% one vertex on the line, and a second vertex on the line, respectively. 
% The following example illustrates how this function would be called:
%     endPoint1 = [0,0,0];
%     endPoint2 = [3,0,0]; 
%     pt = [0,5,0]; 
%     distance = point_to_line(pt,v1,v2)
function distance = point_to_line(pt, endPoint1, endPoint2)
a = endPoint1 - endPoint2;
b = pt - endPoint2;
distance = norm(cross(a,b)) / norm(a);
end


