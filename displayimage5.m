function displayimage5()

    % four quadrants, displaying two categories, with updated file paths to images.
    % 5 categories included: cat, dog, car, beach, tree
   

    fig = figure('Name', 'Click Box', 'Units', 'Normalized', 'Position', [0.2, 0.2, 0.6, 0.6]);
    ax = axes('Units', 'Normalized', 'Position', [0, 0, 1, 1], 'DataAspectRatio', [1, 1, 1]);
                                                                            
    % making the white screen divided into four quadrants
    rectangle(ax, 'Position', [0.35, 0.35, 0.3, 0.3], 'FaceColor', 'black');

    % horizontal and vertical lines to divide the quadrants
    line(ax, [0, 1], [0.5, 0.5], 'Color', 'black', 'LineWidth', 2);
    line(ax, [0.5, 0.5], [0, 1], 'Color', 'black', 'LineWidth', 2);

    % define the categories / their file paths
    categories = ["cat", "dog", "tree", "beach", "car"];
    filePaths = containers.Map();
    filePaths("Cat") = "/Users/avapevsner/Documents/MATLAB/catimages";
    filePaths("Dog") = "/Users/avapevsner/Documents/MATLAB/dogimages";
    filePaths("Tree") = "/Users/avapevsner/Documents/MATLAB/treeimages";
    filePaths("Beach") = "/Users/avapevsner/Documents/MATLAB/beachimages";
    filePaths("Car") = "/Users/avapevsner/Documents/MATLAB/carimages";

    % randomly assign the categories to the left and right quadrants
    indices = randperm(5);
    leftCategory = categories(indices(1));
    rightCategory = categories(indices(2));

    % labels for the quadrants
    text(ax, 0.25, 0.75, leftCategory, 'HorizontalAlignment', 'center', 'Color', 'black', 'FontSize', 12, 'FontWeight', 'bold');
    text(ax, 0.25, 0.25, leftCategory, 'HorizontalAlignment', 'center', 'Color', 'black', 'FontSize', 12, 'FontWeight', 'bold');
    text(ax, 0.75, 0.75, rightCategory, 'HorizontalAlignment', 'center', 'Color', 'black', 'FontSize', 12, 'FontWeight', 'bold');
    text(ax, 0.75, 0.25, rightCategory, 'HorizontalAlignment', 'center', 'Color', 'black', 'FontSize', 12, 'FontWeight', 'bold');

    % callback function when a quadrant is clicked
    set(fig, 'WindowButtonDownFcn', @boxClicked);

    function boxClicked(~, ~)
        % Determine which quadrant of the screen was clicked
        clickPosition = get(ax, 'CurrentPoint');
        x = clickPosition(1, 1);
        y = clickPosition(1, 2);

        % Get the category based on the clicked quadrant
        if x <= 0.5 && y <= 0.5
            category = leftCategory;
        elseif x <= 0.5 && y > 0.5
            category = leftCategory;
        elseif x > 0.5 && y <= 0.5
            category = rightCategory;
        else
            category = rightCategory;
        end

        % Get the corresponding folder path based on the category
        folderPath = filePaths(category);

        displayRandomImage(folderPath);
    end

function displayRandomImage(folderPath)
    imageFilesPNG = dir(fullfile(folderPath, '*.png'));
    imageFilesJPEG = dir(fullfile(folderPath, '*.jpg'));
    imageFiles = [imageFilesPNG; imageFilesJPEG];
    numImages = numel(imageFiles);

    if numImages > 0
        randomIndex = randi([1, numImages]);

        % Displaying the image
        imagePath = fullfile(folderPath, imageFiles(randomIndex).name);
        image = imread(imagePath);
        imshow(image);

        % Prompt for clicking the image to continue
        title('Click the image to continue');
        set(gca, 'Visible', 'off');

        % Reassign the callback function for the next iteration
        set(gcf, 'WindowButtonDownFcn', @nextIteration);
    else
        disp('No images found in the specified folder.');
    end
end


function nextIteration(~, ~)
    % Generate new random categories
    indices = randperm(5);
    leftCategory = categories(indices(1));
    rightCategory = categories(indices(2));

    % Update text labels for the quadrants
    delete(findobj(ax, 'Type', 'text'));
    text(ax, 0.25, 0.75, leftCategory, 'HorizontalAlignment', 'center', 'Color', 'black', 'FontSize', 12, 'FontWeight', 'bold');
    text(ax, 0.25, 0.25, leftCategory, 'HorizontalAlignment', 'center', 'Color', 'black', 'FontSize', 12, 'FontWeight', 'bold');
    text(ax, 0.75, 0.75, rightCategory, 'HorizontalAlignment', 'center', 'Color', 'black', 'FontSize', 12, 'FontWeight', 'bold');
    text(ax, 0.75, 0.25, rightCategory, 'HorizontalAlignment', 'center', 'Color', 'black', 'FontSize', 12, 'FontWeight', 'bold');

    % Reset the figure for the next iteration
    rectangle(ax, 'Position', [0.35, 0.35, 0.3, 0.3], 'FaceColor', 'black');
    line(ax, [0, 1], [0.5, 0.5], 'Color', 'black', 'LineWidth', 2);
    line(ax, [0.5, 0.5], [0, 1], 'Color', 'black', 'LineWidth', 2);
    
    % Restore the callback function for clicking on a quadrant
    set(fig, 'WindowButtonDownFcn', @boxClicked);

    end

end
