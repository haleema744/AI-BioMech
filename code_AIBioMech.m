classdef Linearity_prediction_code_AIBioMech_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                      matlab.ui.Figure
        GridLayout                    matlab.ui.container.GridLayout
        CleanimageButton              matlab.ui.control.Button
        TensionButton                 matlab.ui.control.Button
        EnterButton_4                 matlab.ui.control.Button
        SelectROIDropDown             matlab.ui.control.DropDown
        SelectROIDropDownLabel        matlab.ui.control.Label
        ExportstressstrainButton_2    matlab.ui.control.Button
        PoissonsratioEditFieldLabel   matlab.ui.control.Label
        Image                         matlab.ui.control.Image
        ExportstressstrainButton      matlab.ui.control.Button
        InputparametersLabel          matlab.ui.control.Label
        BinaryconversionLabel         matlab.ui.control.Label
        InputimageLabel               matlab.ui.control.Label
        AreaEditField                 matlab.ui.control.NumericEditField
        AreaEditFieldLabel            matlab.ui.control.Label
        BackButton                    matlab.ui.control.Button
        PoissonsratioEditField        matlab.ui.control.NumericEditField
        ImagebasedFEAoutputLabel      matlab.ui.control.Label
        AIBioMechpredictionLabel      matlab.ui.control.Label
        SelectoptionDropDown          matlab.ui.control.DropDown
        SelectoptionDropDownLabel     matlab.ui.control.Label
        NormalstressYButton_2         matlab.ui.control.Button
        NormalstressXButton_2         matlab.ui.control.Button
        ShearstressButton_2           matlab.ui.control.Button
        vonMisesstressButton_2        matlab.ui.control.Button
        YDisplacementButton_2         matlab.ui.control.Button
        XDisplacementButton_2         matlab.ui.control.Button
        StressstrainplotButton_2      matlab.ui.control.Button
        FEAtimesecEditField           matlab.ui.control.NumericEditField
        FEAtimesecEditFieldLabel      matlab.ui.control.Label
        PredictiontimesecEditField    matlab.ui.control.NumericEditField
        PredictiontimesecEditFieldLabel  matlab.ui.control.Label
        EditField_2                   matlab.ui.control.EditField
        CompressionButton_2           matlab.ui.control.Button
        NormalstressYButton           matlab.ui.control.Button
        NormalstressXButton           matlab.ui.control.Button
        StressstrainplotButton        matlab.ui.control.Button
        SetunitDropDown               matlab.ui.control.DropDown
        SetunitDropDownLabel          matlab.ui.control.Label
        ShearstressButton             matlab.ui.control.Button
        vonMisesstressButton          matlab.ui.control.Button
        YDisplacementButton           matlab.ui.control.Button
        XDisplacementButton           matlab.ui.control.Button
        YoungsmodulusEditField        matlab.ui.control.NumericEditField
        YoungsmodulusEditFieldLabel   matlab.ui.control.Label
        EditField                     matlab.ui.control.EditField
        YdisplacementEditField        matlab.ui.control.NumericEditField
        YdisplacementLabel            matlab.ui.control.Label
        CompressionButton             matlab.ui.control.Button
        CloseallButton                matlab.ui.control.Button
        MaterialpropertiesLabel       matlab.ui.control.Label
        EditField11                   matlab.ui.control.NumericEditField
        EnterButton                   matlab.ui.control.Button
        PhysicallengthEditField       matlab.ui.control.NumericEditField
        PhysicallengthEditFieldLabel  matlab.ui.control.Label
        PixelslengthEditField         matlab.ui.control.NumericEditField
        PixelslengthEditFieldLabel    matlab.ui.control.Label
        ResetButton                   matlab.ui.control.Button
        SetscaleButton                matlab.ui.control.Button
        BrowseButton                  matlab.ui.control.Button
        UIAxes                        matlab.ui.control.UIAxes
        UIAxes2                       matlab.ui.control.UIAxes
        ContextMenu                   matlab.ui.container.ContextMenu
        Menu                          matlab.ui.container.Menu
        Menu2                         matlab.ui.container.Menu
        ContextMenu2                  matlab.ui.container.ContextMenu
        Menu_2                        matlab.ui.container.Menu
        Menu2_2                       matlab.ui.container.Menu
        ContextMenu3                  matlab.ui.container.ContextMenu
        Menu_3                        matlab.ui.container.Menu
        Menu2_3                       matlab.ui.container.Menu
        ContextMenu4                  matlab.ui.container.ContextMenu
        Menu_4                        matlab.ui.container.Menu
        Menu2_4                       matlab.ui.container.Menu
    end

    
    properties (Access = private)
        img % Description
        scale % Description
        % Description
       
        dist
        % Description
        model1 % Description
        result1 % Description
        E % Description
        yieldStress % Description
        %Et % Description
        %fractureStressLimit % Description
        %fractureStrainPercent  % Description
        %fractureStress % Description
        %fractureStrain % Description
        %targetStrain % Description
        binaryImage % Description
         paddedImage % Description
        result2 % Description
        model2 % Description
         % Description
        %front_page % Description
        triangles % Description
        area % Description
        binaryimage % Description
        Et % Description
        invertROI % Description
        binaryimage1 % Description
        roiSelected % Description
        StatusLabel % Description
        YdisplacementEditField1 % Description
        o % Description
        OriginalBinaryImage % Description
        PreviousO % Description
        AIBioMech % Description
        f % Description
        eraserSizeSlider % Description
        pixelCountText % Description
        eraserSizeText % Description
        erosionText % Description
        erosionSlider % Description
        dilationSlider % Description
        dilationText % Description
    end
    
    methods (Access = private)
        
           roiSelected = false; 
       
        
    
    end
    
  
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app, statup)
           % Get screen size safely
 units = get(groot, 'Units'); % backup Units
            set(groot, 'Units', 'pixels');
            app.UIFigure.Position = get(groot, 'ScreenSize');
            set(groot, 'Units', units); % restore original units
            app.UIFigure.Units = 'normalized';
        end

        % Button pushed function: BrowseButton
        function BrowseButtonPushed(app, event)
            cla(app.UIAxes, 'reset');
            cla(app.UIAxes2, 'reset');
            app.EditField.Value = '';
            app.PredictiontimesecEditField.Value=0;
            app.EditField_2.Value='';
           app.FEAtimesecEditField.Value=0;
           app.img = [];
           app.SelectROIDropDown.Value = 'Select options';
           app.result1 = [];
            app.result2 = [];
            [file, path]=uigetfile('*.*');
            if isequal(file,0)
                figure(app.UIFigure);
            end
            figure(app.UIFigure);
            app.img=imread(fullfile(path,file));
            app.img=imresize(app.img,[512 512]);
            imshow(app.img,'parent',app.UIAxes);
           % title(app.UIAxes,'Bio structure');

% Convert to grayscale if needed
if size(app.img,3) == 3
    imGray = im2gray(app.img);
else
    imGray = app.img;
end

% Check if image is already binary
if islogical(imGray) || all(ismember(imGray(:), [0 1]))
    app.binaryimage1 = imGray;    % Already binary, use as is
else
    app.binaryimage1 = imbinarize(imGray);  % Binarize
end

% Add black padding

         %app.binaryimage1=~(app.binaryimage1);
        imshow(app.binaryimage1,'parent',app.UIAxes2); 
      
           
           
        end

        % Button pushed function: SetscaleButton
        function SetscaleButtonPushed(app, event)
           if isempty(app.img)
    % Show alert and stop execution
    uialert(app.UIFigure, 'Please browse and load an image first.', 'No Image Found');
    return;  % Exit immediately
end
            fig=figure;
             if isfield(app, 'fig') && isvalid(app.fig)
        % If the figure exists, close it
        close(app.fig);
             end
             scaleFactor = 1; % Adjust this according to your preference

% Scale the image
app.binaryimage1= imresize(app.binaryimage1, scaleFactor);
            imshow(app.binaryimage1);
            %title(app.UIAxes,'Original Image'); 
            %z=imfinfo(app.str)
            %Pixel_length=z.Width;
            %cross=Actual_length/Pixel_length;
            h=imdistline;
            wait(h)
            app.dist=h.getDistance()/scaleFactor;
             %dist=dist;
             app.PixelslengthEditField.Value=app.dist;
             delete(h);
             close(fig);
        end

        % Value changed function: PixelslengthEditField
        function PixelslengthEditFieldValueChanged(app, event)
            value = app.PixelslengthEditField.Value;
            
        end

        % Button pushed function: EnterButton
        function EnterButtonPushed(app, event)
            if isempty(app.img)
    % Show alert and stop execution
    uialert(app.UIFigure, 'Please browse and load an image first.', 'No Image Found');
    return;  % Exit immediately
end 
            app.scale=app.PhysicallengthEditField.Value/app.PixelslengthEditField.Value;
            % imageHeightPixels = size(app.binaryImage,1)
            tt=app.SelectROIDropDown.Value;
% Process based on ROI selection
switch tt
    case 'White'
        % White region = 1
         numWhitePixels = sum(app.binaryimage1(:) == 1);

    case 'Black'
        % Black region = 0
       numWhitePixels = sum(app.binaryimage1(:) == 0);

    otherwise
         uialert(app.UIFigure, ...
        'Please select region of interest.', ...
        'Invalid ROI', ...
        'Icon','warning');
        return;
end
           



% Update UI
app.EditField11.Value = app.scale;

% Compute area
app.area = numWhitePixels*(app.scale*app.scale);

% Display area
app.AreaEditField.Value = app.area;

        end

        % Value changed function: PhysicallengthEditField
        function PhysicallengthEditFieldValueChanged(app, event)
           % value = app.PhysicallengthEditField.Value;
            
        end

        % Value changed function: EditField11
        function EditField11ValueChanged(app, event)
           % value = app.EditField11.Value;
            
        end

        % Button pushed function: ResetButton
        function ResetButtonPushed(app, event)
            app.AreaEditField.Value=0;
            app.EditField.Value = ''; 
            app.PixelslengthEditField.Value = 0;
            app.PhysicallengthEditField.Value = 0;
            app.EditField11.Value = 0;
            app.YdisplacementEditField.Value = 0;
            app.YoungsmodulusEditField.Value = 0;
%            app.ultimatestrengthEditField.Value = 0;
           % app.FracturestressEditField.Value = 0;
            %app.YeildingstrainEditField.Value = 0;
            %app.TangentmodulusEditField.Value= 0;
            app.PoissonsratioEditField.Value=0;
            cla(app.UIAxes, 'reset');
            cla(app.UIAxes2, 'reset');
            app.EditField.Value = [];
            app.PredictiontimesecEditField.Value=0;
            app.EditField_2.Value='';
           app.FEAtimesecEditField.Value=0;
              % 1️⃣ Close editor window if it exists
     % 1️⃣ Close editor window if it exists
    if isfield(app,'f') && isvalid(app.f)
        close(app.f);
    end

    % 2️⃣ Clear the loaded image
    app.binaryimage1 = [];
    app.img=[];
    % 3️⃣ Clear axes
    if isfield(app,'UIAxes') && isvalid(app.UIAxes)
        cla(app.UIAxes);
    end
    if isfield(app,'UIAxes2') && isvalid(app.UIAxes2)
        cla(app.UIAxes2);
    end

    % 4️⃣ Reset sliders to default
    if isfield(app,'eraserSizeSlider') && isvalid(app.eraserSizeSlider)
        set(app.eraserSizeSlider, 'Value', 15);
    end
    if isfield(app,'erosionSlider') && isvalid(app.erosionSlider)
        set(app.erosionSlider, 'Value', 0);
    end
    if isfield(app,'dilationSlider') && isvalid(app.dilationSlider)
        set(app.dilationSlider, 'Value', 0);
    end

    % 5️⃣ Reset slider labels
    if isfield(app,'eraserSizeText') && isvalid(app.eraserSizeText)
        set(app.eraserSizeText, 'String', 'Size: 15 px');
    end
    if isfield(app,'erosionText') && isvalid(app.erosionText)
        set(app.erosionText, 'String', 'Erosion: 0 px');
    end
    if isfield(app,'dilationText') && isvalid(app.dilationText)
        set(app.dilationText, 'String', 'Dilation: 0 px');
    end

    % 6️⃣ Reset pixel count display
    if isfield(app,'pixelCountText') && isvalid(app.pixelCountText)
        set(app.pixelCountText, 'String', 'White: 0 (0%)   Black: 0 (0%)   Total: 0');
    end
     app.SelectROIDropDown.Items = {'Select options','Black','White'};
          app.SelectROIDropDown.Value = 'Select options';
                for k = 1:14
    if isvalid(figure(k))  % Ensure figure exists
         close(k);            % Clear contents of figure k
    end

    % Optional: Show a message
    uialert(app.UIFigure, 'All settings reset. Please browse a new image.', 'Reset Complete');

return

           
end
        end

        % Value changed function: EditField
        function EditFieldValueChanged(app, event)
            value = app.EditField.Value;
            
        end

        % Button pushed function: CompressionButton
        function CompressionButtonPushed2(app, event)
if isempty(app.img)
    % Show alert and stop execution
    uialert(app.UIFigure, 'Please browse and load an image first.', 'No Image Found');
    return;  % Exit immediately
end
    
    % Simulate some processing
if app.YoungsmodulusEditField.Value == 0
    uialert(app.UIFigure, ...
        'Please enter a valid Young''s Modulus value greater than 0.', ...
        'Invalid Input', ...
        'Icon','warning');
    return;  % Stop further execution
end  

nu = app.PoissonsratioEditField.Value;

% Validate input
if isnan(nu) || nu <= 0 || nu >= 0.5
    uialert(app.UIFigure, ...
        'Please enter a valid Poisson''s ratio between 0 and 0.5.', ...
        'Invalid Input', ...
        'Icon','warning');
    return;  % Stop execution
end
 if app.YdisplacementEditField.Value == 0

% Validate input
    uialert(app.UIFigure, ...
        'Please enter a valid numeric value for Y displacement.', ...
        'Invalid Input', ...
        'Icon','warning');
    return;  % Stop execution
 end
  d = uiprogressdlg(app.UIFigure, ...
    'Title','AI-BioMech Prediction', ...
    'Message','Processing...', ...
    'Indeterminate','on', ...
    'Cancelable','off');
  
            % Material properties
             tic;
app.E =  app.YoungsmodulusEditField.Value;           % Young's modulus (Pa)
%app.yieldStress =  app.YieldstrengthEditField.Value; % Yield stress (Pa)
%app.Et =app.TangentmodulusEditField.Value;        % Tangent modulus (plastic hardening)
%app.fractureStressLimit =  app.FracturestressEditField.Value;       
%app.fractureStrainPercent = app.YeildingstrainEditField.Value; 
% Fracture properties
%app.fractureStress = app.fractureStressLimit;     
%app.fractureStrain = app.fractureStrainPercent/100;  % convert to decimal
   % Fracture stress limit (Pa)
%app.targetStrain = app.fractureStrain;

%app.binaryimage=~(app.paddedImage);
%[row, col] = find(app.binaryimage == 1);
 img = app.paddedImage;

% Process based on ROI selection
switch app.SelectROIDropDown.Value
    case 'White'
        % White region = 1
        app.binaryimage = (img == 1);

    case 'Black'
        % Black region = 0
        app.binaryimage = (img == 0);

    otherwise
         uialert(app.UIFigure, ...
        'Please select region of interest.', ...
        'Invalid ROI', ...
        'Icon','warning');
        return;
end

% Get row and column indices of selected region
[row, col] = find(app.binaryimage);   
 % Find white pixels

%% Step 3: Create a Grid of Points Inside the White Region
gridSpacing = 2; % Grid spacing (in pixels)
minX = min(col); maxX = max(col);
minY = min(row); maxY = max(row);
[xGrid, yGrid] = meshgrid(minX:gridSpacing:maxX, minY:gridSpacing:maxY);

xGrid = xGrid(:); yGrid = yGrid(:);

%% Step 4: Masking - Keep Only Points Inside the White Region
validIndices = app.binaryimage(sub2ind(size(app.binaryimage), round(yGrid), round(xGrid))) == 1;
validX = xGrid(validIndices); validY = yGrid(validIndices);




%% Step 5: Delaunay Triangulation
app.triangles = delaunay(validX, validY);

%% Step 6: Remove Triangles That Cross Black Regions
validTriangles = [];
for i = 1:size(app.triangles, 1)
    triangleVertices = [validX(app.triangles(i, :)), validY(app.triangles(i, :))];
    if ~anyEdgeCrossesBlackRegion(triangleVertices, app.binaryimage)
        validTriangles = [validTriangles; app.triangles(i, :)];
    end
end

%% Step 7: Flip Y-coordinates to Match Cartesian System
validY = max(validY) - validY;

mesh.Vertices = [validX, max(validY) - validY];
%mesh.Vertices = [validX, max(validY) - validY] * 1e-3; % Convert pixels to meters (example)
mesh.Elements = validTriangles;

Vertices = mesh.Vertices;
elements = mesh.Elements;

nodes = Vertices';  % 2xN
elements = elements'; % 3xM

% Fix element orientation (counter-clockwise)
for i = 1:size(elements, 2)
    v1 = nodes(:, elements(1,i));
    v2 = nodes(:, elements(2,i));
    v3 = nodes(:, elements(3,i));
    signedArea = (v2(1)-v1(1))*(v3(2)-v1(2)) - (v2(2)-v1(2))*(v3(1)-v1(1));
    if signedArea < 0
        elements([2 3],i) = elements([3 2],i);
    end
end
switch app.SelectoptionDropDown.Value
    case 'Plane-stress'
       app.model1 = createpde('structural','static-planestress');

    otherwise
       app.model1 = createpde('structural','static-planestrain');  
end
% Create PDE model
%app.model1 = createpde('structural','static-planestrain');
geometryFromMesh(app.model1, nodes, elements);
%generateMesh(app.model1, 'Hmax', 0.5);
%generateMesh(app.model1, 'Hmax', 0.1);
% Define material properties
P= app.PoissonsratioEditField.Value;
structuralProperties(app.model1, 'YoungsModulus', app.E, 'PoissonsRatio', P);

% Find top and bottom edges for BC (nearestEdge function or manual)
vertices = app.model1.Geometry.Vertices;
maxY = max(vertices(:,2));
minY = min(vertices(:,2));

topEdgePoint = [mean(vertices(vertices(:,2) == maxY,1)), maxY];
bottomEdgePoint = [mean(vertices(vertices(:,2) == minY,1)), minY];

topEdgeID = nearestEdge(app.model1.Geometry, topEdgePoint);
bottomEdgeID = nearestEdge(app.model1.Geometry, bottomEdgePoint);

% Apply displacement BC at top (yield strain displacement)
yield_disp_m =  -(app.YdisplacementEditField.Value/100) * (maxY - minY);% approximate displacement at yield in meters
yield_disp_m = -(app.YdisplacementEditField.Value/100) * (maxY - minY);

% Total specimen length
specimenLength = maxY - minY;

% Check condition
if abs(yield_disp_m) >= specimenLength
    uialert(app.UIFigure, ...
        'Displacement is too large: equal to or greater than specimen total length.', ...
        'Invalid Displacement');
else
    % Fine – do nothing or continue processing

structuralBC(app.model1, 'Edge', topEdgeID, 'Displacement', [0, yield_disp_m]); % downward displacement
structuralBC(app.model1, 'Edge', bottomEdgeID, 'YDisplacement', 0);

% Solve model
try
    app.result1 = solve(app.model1);   % run solver

catch
    uialert(app.UIFigure, ...
        'Please provide a high-resolution image\n.The selected region is invalid or contains disconnected patches', ...
        'Prediction Failed', ...
        'Icon','error');

    if exist('h1','var') && isvalid(h1)
        pause(2);     % show for 2 seconds
close(d);
    end

    return;   % stop execution
end
pause(2);     % show for 2 seconds
close(d);
if app.PixelslengthEditField.Value == 0 && app.PhysicallengthEditField.Value == 0
    uialert(app.UIFigure, ...
        ['Scale has not been set.' ...
         'All results are calculated using the default pixel scale.'], ...
        'Default Scale', ...
        'Icon','info');
end
toc;
   
%% ================== STRAIN DATA ==================
exx = app.result1.Strain.exx;
eyy = app.result1.Strain.eyy;
exy = app.result1.Strain.exy;

% Equivalent (von Mises) strain
eqStrain = sqrt(exx.^2 + eyy.^2 - exx.*eyy + 3*exy.^2);

% Average equivalent strain (global)
avgStrain = mean(eqStrain, 'all');
% Maximum equivalent strain
maxStrainValue = max(eqStrain(:));

%% ================== STRESS DATA ==================
vmStress = app.result1.VonMisesStress;   % Pa

% Average equivalent stress
avgStress = mean(vmStress, 'all');
% Maximum von Mises stress
maxStressValue = max(vmStress(:));

%% ================== GEOMETRY-BASED ELASTIC MODULUS ==================
% Use AVERAGE values to calculate effective modulus
E_eff = avgStress / avgStrain;           % Pa

%% ================== BUILD ELASTIC CURVE ==================
nPts = 300;
% Use MAX strain for plotting to show full range
strainLine = linspace(0, maxStrainValue, nPts);   % dimensionless
stressLine = E_eff * strainLine;             % Pa

%% ================== UNIT CONVERSION ==================
strainPercent = strainLine * 100;
stressMPa = stressLine / 1e6;

%% ================== TIMING ==================
elapsedTime = toc;
app.PredictiontimesecEditField.Value = elapsedTime;

%% ================== MAX VALUES ==================
% Use ACTUAL maximum values from simulation
% NOT the endpoint of the calculated curve
maxStrainPercent = maxStrainValue * 100;  % Actual max from simulation
maxStressMPa = maxStressValue / 1e6;      % Actual max from simulation
maxStrainValue = strainLine(end);  % Use end of strainLine, not max from simulation
maxStressValue = stressLine(end);
app.EditField_2.Value = sprintf( ...
    'Max strain = %.3f %%\nMax stress = %.2f MPa', ...
    maxStrainValue*100, maxStressValue/1e6 );


end

%% ================== PLOT ==================

        end

        % Value changed function: YdisplacementEditField
        function YdisplacementEditFieldValueChanged(app, event)
            %value = app.YdisplacementEditField.Value;
            
        end

        % Button down function: UIAxes
        function UIAxesButtonDown(app, event)
            
        end

        % Value changed function: YoungsmodulusEditField
        function YoungsmodulusEditFieldValueChanged(app, event)
            %value = app.YoungsmodulusEditField.Value;
            
        end

        % Callback function
        function ultimatestrengthEditFieldValueChanged(app, event)
            %value = app.ultimatestrengthEditField.Value;
            
        end

        % Button down function: UIAxes2
        function UIAxes2ButtonDown(app, event)
            
        end

        % Button pushed function: vonMisesstressButton
        function vonMisesstressButtonPushed(app, event)
           if isempty(app.img)
    % Show alert and stop execution
    uialert(app.UIFigure, 'Please browse and load an image first.', 'No Image Found');
    return;  % Exit immediately
end
            % Get actual min and max von Mises stress from data (for color axis)
% Check if EditField_2 is emptyvalStr = strtrim(app.EditField_2.Value);
valStr = strtrim(app.EditField_2.Value);
% Check if empty
if isempty(valStr)
    uialert(app.UIFigure, ...
        'Please press Enter for prediction first.', ...
        'Input Required', ...
        'Icon','warning');
    return;  % Stop further execution
end

vonmisesstress=app.result1.VonMisesStress;
vonmises_MPa = vonmisesstress/1e6;  % Convert to MPa

%percentileStress = prctile(vonmises_MPa(:), 99);
% Maximum and minimum
maxStress = max(vonmises_MPa(:));
minStress = min(vonmises_MPa(:));

% Display in command window
fprintf('Maximum Von Mises Stress: %.2f MPa\n', maxStress);
fprintf('Minimum Von Mises Stress: %.2f MPa\n', minStress);
figure (2);
clf;
pdeplot(app.model1, 'XYData', vonmises_MPa, 'Colormap', 'jet');
set(gca, 'YDir', 'reverse');
title('AI-BioMech predicted Von Mises stress (MPa)')
axis equal;
xlabel(''); ylabel('');
set(gca, 'XTick', []); set(gca, 'YTick', []);
axis off;
set(gca,'YDir','reverse')

% Tight color limits
%clim([0, percentileStress]);
colormap(jet)  
axis off;


        end

        % Button pushed function: StressstrainplotButton
        function StressstrainplotButtonPushed(app, event)
   if isempty(app.img)
    % Show alert and stop execution
    uialert(app.UIFigure, 'Please browse and load an image first.', 'No Image Found');
    return;  % Exit immediately
end
            valStr = strtrim(app.EditField_2.Value);
% Check if empty
if isempty(valStr)
    uialert(app.UIFigure, ...
        'Please press Enter for prediction first.', ...
        'Input Required', ...
        'Icon','warning');
    return;  % Stop further execution
end
            %% ================== STRAIN DATA ==================
exx = app.result1.Strain.exx;
eyy = app.result1.Strain.eyy;
exy = app.result1.Strain.exy;

% Equivalent (von Mises) strain
eqStrain = sqrt(exx.^2 + eyy.^2 - exx.*eyy + 3*exy.^2);

% Average equivalent strain (global)
avgStrain = mean(eqStrain, 'all');
% Maximum equivalent strain
maxStrainValue = max(eqStrain(:));

%% ================== STRESS DATA ==================
vmStress = app.result1.VonMisesStress;   % Pa

% Average equivalent stress
avgStress = mean(vmStress, 'all');
% Maximum von Mises stress
maxStressValue = max(vmStress(:));

%% ================== GEOMETRY-BASED ELASTIC MODULUS ==================
% Use AVERAGE values to calculate effective modulus
if avgStrain > 0
    E_eff = avgStress / avgStrain;           % Pa
else
    E_eff = app.E;  % Use material modulus if no strain
end

%% ================== BUILD LINEAR ELASTIC CURVE ==================
nPts = 300;
% Use MAX strain for plotting
strainLine = linspace(0, maxStrainValue, nPts);   % dimensionless
% Linear elastic relationship: σ = E * ε
stressLine = E_eff * strainLine;             % Pa

%% ================== PLOT LINEAR STRESS-STRAIN CURVE ==================
figure('Name', 'Stress-Strain Curve (Linear Elastic)', 'NumberTitle', 'off', ...
       'Position', [100 100 800 600]);
hold on;
grid on;
box on;

% Use the same theoretical stress for both line and marker
maxStrainValue = strainLine(end);  % Use end of strainLine, not max from simulation
maxStressValue = stressLine(end);  % Use end of stressLine, not max from simulation

% Now plot them - marker will be on line
plot(strainLine*100, stressLine/1e6, ...
     'b-', 'LineWidth', 3, 'DisplayName', 'Linear Elastic Response');

plot(maxStrainValue*100, maxStressValue/1e6, 'ro', ...
     'MarkerSize', 10, 'MarkerFaceColor', 'r', ...
     'DisplayName', 'Maximum stress-strain');
% Add labels with proper formatting
xlabel('Strain (%)', 'FontSize', 14);
ylabel('Stress (MPa)', 'FontSize', 14);
title('AI-BioMech predicted linear elastic stress-strain curve', 'FontSize', 14);

% Add legend
legend('Location', 'southeast');

% Set axis limits
xlim([0, maxStrainValue*100*1.1]);  % Add 10% margin
ylim([0, max(maxStressValue/1e6, stressLine(end)/1e6)*1.1]);

% Calculate slope (E_eff) for annotation
slope_MPa_per_percent = (stressLine(end)/1e6) / (strainLine(end)*100);

% Add text box with material properties


% Optional: Add grid with minor ticks
grid on

hold off;

ax = gca;
%disableDefaultInteractivity(ax);
fig = gcf;                         % Get current figure
dcm = datacursormode(fig);         % Correct
set(dcm,'Enable','on');
dcm.UpdateFcn = @(~,event) myCursor1(event);
        end

        % Button pushed function: XDisplacementButton
        function XDisplacementButtonPushed(app, event)
if isempty(app.img)
    % Show alert and stop execution
    uialert(app.UIFigure, 'Please browse and load an image first.', 'No Image Found');
    return;  % Exit immediately
end
valStr = strtrim(app.EditField_2.Value);

% Check if empty
if isempty(valStr)
    uialert(app.UIFigure, ...
        'Please press Enter for prediction first.', ...
        'Input Required', ...
        'Icon','warning');
    return;  % Stop further execution
end
            ux = app.result1.Displacement.ux;

% Check if app.scale exists and is nonzero
if isprop(app, 'scale') && ~isempty(app.scale) && app.scale ~= 0
    scaledDisplacement = app.scale * ux;

else
    scaledDisplacement = ux;
   
end

% Plot
figure(3);
pdeplot(app.model1, 'XYData', scaledDisplacement, 'Colormap', 'jet');
title('AI-BioMech predicted X-displacement magnitude');
axis equal;
axis tight;
axis xy;
% Remove axes
xlabel(''); ylabel('');
set(gca, 'XTick', []); set(gca, 'YTick', []);
axis off;
set(gca,'YDir','reverse')
%cb = colorbar;
%cb.Label.String = 'XDisplacement';  %
        end

        % Button pushed function: YDisplacementButton
        function YDisplacementButtonPushed(app, event)
if isempty(app.img)
    % Show alert and stop execution
    uialert(app.UIFigure, 'Please browse and load an image first.', 'No Image Found');
    return;  % Exit immediately
end
            valStr = strtrim(app.EditField_2.Value);
% Check if empty
if isempty(valStr)
    uialert(app.UIFigure, ...
        'Please press Enter for prediction first.', ...
        'Input Required', ...
        'Icon','warning');
    return;  % Stop further execution
end
            uy = app.result1.Displacement.uy;

% Check if app.scale exists and is nonzero
if isprop(app, 'scale') && ~isempty(app.scale) && app.scale ~= 0
    scaledDisplacement = app.scale * uy;
else
    scaledDisplacement = uy;
end

% Plot
figure(4);
pdeplot(app.model1, 'XYData', scaledDisplacement, 'Colormap', 'jet');
title('AI-BioMech predicted Y-displacement magnitude');
axis equal;

xlabel(''); ylabel('');
set(gca, 'XTick', []); set(gca, 'YTick', []);
axis off;
set(gca,'YDir','reverse')
axis off;
        end

        % Button pushed function: ShearstressButton
        function ShearstressButtonPushed(app, event)
if isempty(app.img)
    % Show alert and stop execution
    uialert(app.UIFigure, 'Please browse and load an image first.', 'No Image Found');
    return;  % Exit immediately
end
            valStr = strtrim(app.EditField_2.Value);
% Check if empty
if isempty(valStr)
    uialert(app.UIFigure, ...
        'Please press Enter for prediction first.', ...
        'Input Required', ...
        'Icon','warning');
    return;  % Stop further execution
end
            stress = app.result1.Stress;
shearStress = stress.sxy;             % Pa
shearStress_MPa = shearStress / 1e6;  % Convert to MPa

figure(5); 
pdeplot(app.model1, 'XYData', shearStress_MPa, 'ColorMap', 'jet');

% Axis properties
axis equal;
set(gca, 'YDir', 'reverse');
xlabel(''); ylabel('');
set(gca, 'XTick', [], 'YTick', []);
axis off;

% Add colorbar
cb = colorbar;


% ✅ Set color limits (clim) manually
clim([min(shearStress_MPa(:)), max(shearStress_MPa(:))]);  % tight to data

title('AI-BioMech Predicted Shear Stress (\tau_{xy})');

% Add colorbar with units
%cb = colorbar;
%cb.Label.String = 'Shear stress (MPa)';  % show units


        end

        % Button pushed function: NormalstressYButton
        function NormalstressYButtonPushed(app, event)
   if isempty(app.img)
    % Show alert and stop execution
    uialert(app.UIFigure, 'Please browse and load an image first.', 'No Image Found');
    return;  % Exit immediately
end
            valStr = strtrim(app.EditField_2.Value);
% Check if empty
if isempty(valStr)
    uialert(app.UIFigure, ...
        'Please press Enter for prediction first.', ...
        'Input Required', ...
        'Icon','warning');
    return;  % Stop further execution
end
          stress = app.result1.Stress;

% Extract normal stress
normalStress = stress.syy;  % Change to syy or szz as needed

% Compute normal yield and fracture limits
%normalYield = app.yieldStress;
%normalFracture = app.fractureStress;

% Create mask for different regions
%elasticRegion = abs(normalStress) <= normalYield;
%plasticRegion = abs(normalStress) > normalYield & abs(normalStress) <= normalFracture;
%fractureRegion = abs(normalStress) > normalFracture;

% Saturate stress for visualization
%normalStressCapped = min(normalStress, normalFracture);  % Clip upper bound

% Start figure
figure(7); 
pdeplot(app.model1, 'XYData',normalStress/1e6, 'ColorMap', 'jet');
set(gca, 'YDir', 'reverse');
title('AI-BioMech predicted normal stress(\sigma_{yy})(MPa)');  % Update the title
colorbar;
%clim([min(normalStress(:)), normalFracture]);  % Fix color scale
axis equal;
xlabel(''); ylabel('');
set(gca, 'XTick', []); set(gca, 'YTick', []);
axis off;
set(gca,'YDir','reverse')
% Update colorbar label
%cb = colorbar;
%cb.Label.String = 'Normal Stress (\sigma_{yy})';  
            
          
        end

        % Button pushed function: NormalstressXButton
        function NormalstressXButtonPushed(app, event)
    if isempty(app.img)
    % Show alert and stop execution
    uialert(app.UIFigure, 'Please browse and load an image first.', 'No Image Found');
    return;  % Exit immediately
end
            valStr = strtrim(app.EditField_2.Value);
% Check if empty
if isempty(valStr)
    uialert(app.UIFigure, ...
        'Please press Enter for prediction first.', ...
        'Input Required', ...
        'Icon','warning');
    return;  % Stop further execution
end
            % Visualize shear stress (\tau_{xy})
  stress = app.result1.Stress;

% Extract normal stress
normalStress = stress.sxx;  % Change to syy or szz as needed

% Compute normal yield and fracture limits
%normalYield = app.yieldStress;
%normalFracture = app.fractureStress;

% Create mask for different regions
%elasticRegion = abs(normalStress) <= normalYield;
%plasticRegion = abs(normalStress) > normalYield & abs(normalStress) <= normalFracture;
%fractureRegion = abs(normalStress) > normalFracture;

% Saturate stress for visualization
%normalStressCapped = min(normalStress, normalFracture);  % Clip upper bound

% Start figure
figure(6); 
pdeplot(app.model1, 'XYData', normalStress/1e6, 'ColorMap', 'jet');
set(gca, 'YDir', 'reverse');
title('AI-BioMech predicted normal stress(\sigma_{xx}) (MPa)');  % Update the title
colorbar;
%clim([min(normalStress(:)), normalFracture]);  % Fix color scale
axis equal;
xlabel(''); ylabel('');
set(gca, 'XTick', []); set(gca, 'YTick', []);
axis off;
set(gca,'YDir','reverse')
% Update colorbar label
%cb = colorbar;
%cb.Label.String = 'Normal Stress (\sigma_{xx})';
        end

        % Button pushed function: CompressionButton_2
        function CompressionButton_2Pushed(app, event)
            if isempty(app.img)
    % Show alert and stop execution
    uialert(app.UIFigure, 'Please browse and load an image first.', 'No Image Found');
    return;  % Exit immediately
end
        app.result2=[];
        app.model2=[];
        %close all
        app.EditField.Value='';
      
           
    
    % Simulate some processing
if app.YoungsmodulusEditField.Value == 0
    uialert(app.UIFigure, ...
        'Please enter a valid Young''s Modulus value greater than 0.', ...
        'Invalid Input', ...
        'Icon','warning');
    return;  % Stop further execution
end  

nu = app.PoissonsratioEditField.Value;

% Validate input
if isnan(nu) || nu <= 0 || nu >= 0.5
    uialert(app.UIFigure, ...
        'Please enter a valid Poisson''s ratio between 0 and 0.5.', ...
        'Invalid Input', ...
        'Icon','warning');
    return;  % Stop execution
end
 if app.YdisplacementEditField.Value == 0

% Validate input
    uialert(app.UIFigure, ...
        'Please enter a valid numeric value for Y displacement.', ...
        'Invalid Input', ...
        'Icon','warning');
    return;  % Stop execution
 end
  d = uiprogressdlg(app.UIFigure, ...
    'Title','Image-based FEA simulation', ...
    'Message','Processing...', ...
    'Indeterminate','on', ...
    'Cancelable','off');


            % Material properties
             tic;
            % Material properties
             
    
    % Simulate some processing
   
app.E =  app.YoungsmodulusEditField.Value;           % Young's modulus (Pa)
%app.yieldStress =  app.YieldstrengthEditField.Value; % Yield stress (Pa)
%app.Et =app.TangentmodulusEditField.Value;        % Tangent modulus (plastic hardening)
%app.fractureStressLimit =  app.FracturestressEditField.Value;       
%app.fractureStrainPercent = app.YeildingstrainEditField.Value; 
% Fracture properties
%app.fractureStress = app.fractureStressLimit;     
%app.fractureStrain = app.fractureStrainPercent/100;  % convert to decimal
   % Fracture stress limit (Pa)
%app.targetStrain = app.fractureStrain;


 img = app.paddedImage;

% Process based on ROI selection
switch app.SelectROIDropDown.Value
    case 'White'
        % White region = 1
        app.binaryimage = (img == 1);

    case 'Black'
        % Black region = 0
        app.binaryimage = (img == 0);

    otherwise
         uialert(app.UIFigure, ...
        'Please select region of interest.', ...
        'Invalid ROI', ...
        'Icon','warning');
        return;
end

% Get row and column indices of selected region
[row, col] = find(app.binaryimage);

%% Step 3: Create a Grid of Points Inside the White Region
gridSpacing = 1.9; % Grid spacing (in pixels)
minX = min(col); maxX = max(col);
minY = min(row); maxY = max(row);
[xGrid, yGrid] = meshgrid(minX:gridSpacing:maxX, minY:gridSpacing:maxY);

xGrid = xGrid(:); yGrid = yGrid(:);

%% Step 4: Masking - Keep Only Points Inside the White Region
validIndices = app.binaryimage(sub2ind(size(app.binaryimage), round(yGrid), round(xGrid))) == 1;
validX = xGrid(validIndices); validY = yGrid(validIndices);




%% Step 5: Delaunay Triangulation
app.triangles = delaunay(validX, validY);

%% Step 6: Remove Triangles That Cross Black Regions
validTriangles = [];
for i = 1:size(app.triangles, 1)
    triangleVertices = [validX(app.triangles(i, :)), validY(app.triangles(i, :))];
    if ~anyEdgeCrossesBlackRegion(triangleVertices, app.binaryimage)
        validTriangles = [validTriangles; app.triangles(i, :)];
    end
end

%% Step 7: Flip Y-coordinates to Match Cartesian System
validY = max(validY) - validY;

mesh.Vertices = [validX, max(validY) - validY];
%mesh.Vertices = [validX, max(validY) - validY] * 1e-3; % Convert pixels to meters (example)
mesh.Elements = validTriangles;

Vertices = mesh.Vertices;
elements = mesh.Elements;

nodes = Vertices';  % 2xN
elements = elements'; % 3xM

% Fix element orientation (counter-clockwise)
for i = 1:size(elements, 2)
    v1 = nodes(:, elements(1,i));
    v2 = nodes(:, elements(2,i));
    v3 = nodes(:, elements(3,i));
    signedArea = (v2(1)-v1(1))*(v3(2)-v1(2)) - (v2(2)-v1(2))*(v3(1)-v1(1));
    if signedArea < 0
        elements([2 3],i) = elements([3 2],i);
    end
end

switch app.SelectoptionDropDown.Value
    case 'Plane-stress'
       app.model2 = createpde('structural','static-planestress');

    otherwise
       app.model2 = createpde('structural','static-planestrain');  
end



% Create PDE model
%app.model1 = createpde('structural','static-planestrain');
geometryFromMesh(app.model2, nodes, elements);
%generateMesh(app.model1, 'Hmax', 0.5);
%generateMesh(app.model1, 'Hmax', 0.1);
% Define material properties
P= app.PoissonsratioEditField.Value;
structuralProperties(app.model2, 'YoungsModulus', app.E, 'PoissonsRatio', P);

% Find top and bottom edges for BC (nearestEdge function or manual)
vertices = app.model2.Geometry.Vertices;
maxY = max(vertices(:,2));
minY = min(vertices(:,2));

topEdgePoint = [mean(vertices(vertices(:,2) == maxY,1)), maxY];
bottomEdgePoint = [mean(vertices(vertices(:,2) == minY,1)), minY];

topEdgeID = nearestEdge(app.model2.Geometry, topEdgePoint);
bottomEdgeID = nearestEdge(app.model2.Geometry, bottomEdgePoint);

%app.YdisplacementEditField1.Value = -(app.YdisplacementEditField.Value);
    

% Apply displacement BC at top (yield strain displacement)
yield_disp_m =  -(app.YdisplacementEditField.Value/100) * (maxY - minY);
structuralBC(app.model2, 'Edge', topEdgeID, 'Displacement', [0, yield_disp_m]); % downward displacement
structuralBC(app.model2, 'Edge', bottomEdgeID, 'YDisplacement', 0);

% Solve model
try
    app.result2 = solve(app.model2);   % run solver

catch
    uialert(app.UIFigure, ...
        'Please provide a high-resolution image\n.The selected region is invalid or contains disconnected patches', ...
        'Meshing Failed', ...
        'Icon','error');

    if exist('h1','var') && isvalid(h1)
            % show for 2 seconds
close(d);
    end

    return;   % stop execution
end
     % show for 2 seconds


pause(60);

toc;
close(d);
if app.PixelslengthEditField.Value == 0 && app.PhysicallengthEditField.Value == 0
    uialert(app.UIFigure, ...
        ['Scale has not been set.' ...
         'All results are calculated using the default pixel scale.'], ...
        'Default Scale', ...
        'Icon','info');
end
%% ================== STRAIN DATA ==================

exx = app.result2.Strain.exx;
eyy = app.result2.Strain.eyy;
exy = app.result2.Strain.exy;

% Equivalent (von Mises) strain
eqStrain = sqrt(exx.^2 + eyy.^2 - exx.*eyy + 3*exy.^2);

% Average equivalent strain (global)
avgStrain = mean(eqStrain, 'all');
% Maximum equivalent strain
maxStrainValue = max(eqStrain(:));

%% ================== STRESS DATA ==================
vmStress = app.result2.VonMisesStress;   % Pa

% Average equivalent stress
avgStress = mean(vmStress, 'all');
% Maximum von Mises stress
maxStressValue = max(vmStress(:));

%% ================== GEOMETRY-BASED ELASTIC MODULUS ==================
% Use AVERAGE values to calculate effective modulus
E_eff = avgStress / avgStrain;           % Pa

%% ================== BUILD ELASTIC CURVE ==================
nPts = 300;
% Use MAX strain for plotting to show full range
strainLine = linspace(0, maxStrainValue, nPts);   % dimensionless
stressLine = E_eff * strainLine;             % Pa

%% ================== UNIT CONVERSION ==================
strainPercent = strainLine * 100;
stressMPa = stressLine / 1e6;

%% ================== TIMING ==================
elapsedTime = toc;
app.FEAtimesecEditField.Value= elapsedTime;

%% ================== MAX VALUES ==================
% Use ACTUAL maximum values from simulation
% NOT the endpoint of the calculated curve
maxStrainPercent = maxStrainValue * 100;  % Actual max from simulation
maxStressMPa = maxStressValue / 1e6;      % Actual max from simulation

%% ================== MAX VALUES ==================
maxStrainValue = strainLine(end);  % Use end of strainLine, not max from simulation
maxStressValue = stressLine(end);
app.EditField.Value = sprintf( ...
    'Max strain = %.3f %%\nMax stress = %.2f MPa', ...
    maxStrainValue*100, maxStressValue/1e6 );

        end

        % Value changed function: EditField_2
        function EditField_2ValueChanged(app, event)
            %value = app.EditField_2.Value;
            
        end

        % Value changed function: PredictiontimesecEditField
        function PredictiontimesecEditFieldValueChanged(app, event)
            %value = app.PredictiontimesecEditField.Value;
            
        end

        % Value changed function: FEAtimesecEditField
        function FEAtimesecEditFieldValueChanged(app, event)
            %value = app.FEAtimesecEditField.Value;
            
        end

        % Button pushed function: StressstrainplotButton_2
        function StressstrainplotButton_2Pushed(app, event)
if isempty(app.img)
    % Show alert and stop execution
    uialert(app.UIFigure, 'Please browse and load an image first.', 'No Image Found');
    return;  % Exit immediately
end
            valStr = strtrim(app.EditField.Value);
% Check if empty
if isempty(valStr)
    uialert(app.UIFigure, ...
         'Please press Enter for FEA simulation first.', ...
        'Input Required', ...
        'Icon','warning');
    return;  % Stop further execution
end
            %% ================== STRAIN DATA ==================
exx = app.result2.Strain.exx;
eyy = app.result2.Strain.eyy;
exy = app.result2.Strain.exy;

% Equivalent (von Mises) strain
eqStrain = sqrt(exx.^2 + eyy.^2 - exx.*eyy + 3*exy.^2);

% Average equivalent strain (global)
avgStrain = mean(eqStrain, 'all');
% Maximum equivalent strain
maxStrainValue = max(eqStrain(:));

%% ================== STRESS DATA ==================
vmStress = app.result2.VonMisesStress;   % Pa

% Average equivalent stress
avgStress = mean(vmStress, 'all');
% Maximum von Mises stress
maxStressValue = max(vmStress(:));

%% ================== GEOMETRY-BASED ELASTIC MODULUS ==================
% Use AVERAGE values to calculate effective modulus
if avgStrain > 0
    E_eff = avgStress / avgStrain;           % Pa
else
    E_eff = app.E;  % Use material modulus if no strain
end

%% ================== BUILD LINEAR ELASTIC CURVE ==================
nPts = 300;
% Use MAX strain for plotting
strainLine = linspace(0, maxStrainValue, nPts);   % dimensionless
% Linear elastic relationship: σ = E * ε
stressLine = E_eff * strainLine;             % Pa

%% ================== PLOT LINEAR STRESS-STRAIN CURVE ==================
figure('Name', 'Stress-Strain Curve (Linear Elastic)', 'NumberTitle', 'off', ...
       'Position', [100 100 800 600]);
hold on;
grid on;
box on;

% Use the same theoretical stress for both line and marker
maxStrainValue = strainLine(end);  % Use end of strainLine, not max from simulation
maxStressValue = stressLine(end);  % Use end of stressLine, not max from simulation

% Now plot them - marker will be on line
plot(strainLine*100, stressLine/1e6, ...
     'b-', 'LineWidth', 3, 'DisplayName', 'Linear Elastic Response');

plot(maxStrainValue*100, maxStressValue/1e6, 'ro', ...
     'MarkerSize', 10, 'MarkerFaceColor', 'r', ...
     'DisplayName', 'Maximum stress-strain');
% Add labels with proper formatting
xlabel('Strain (%)', 'FontSize', 14);
ylabel('Stress (MPa)', 'FontSize', 14);
title('Image-based FEA linear elastic stress-strain curve', 'FontSize', 14);

% Add legend
legend('Location', 'southeast');

% Set axis limits
xlim([0, maxStrainValue*100*1.1]);  % Add 10% margin
ylim([0, max(maxStressValue/1e6, stressLine(end)/1e6)*1.1]);

% Calculate slope (E_eff) for annotation
slope_MPa_per_percent = (stressLine(end)/1e6) / (strainLine(end)*100);

% Add text box with material properties


% Optional: Add grid with minor ticks
grid on
fig = gcf;                         % Get current figure
dcm = datacursormode(fig);         % Correct
set(dcm,'Enable','on');
dcm.UpdateFcn = @(~,event) myCursor1(event);
hold off;





        end

        % Button pushed function: XDisplacementButton_2
        function XDisplacementButton_2Pushed(app, event)
if isempty(app.img)
    % Show alert and stop execution
    uialert(app.UIFigure, 'Please browse and load an image first.', 'No Image Found');
    return;  % Exit immediately
end
            valStr = strtrim(app.EditField.Value);
% Check if empty
if isempty(valStr)
    uialert(app.UIFigure, ...
         'Please press Enter for FEA simulation first.', ...
        'Input Required', ...
        'Icon','warning');
    return;  % Stop further execution
end
            ux = app.result2.Displacement.ux;

% Check if app.scale exists and is nonzero
if isprop(app, 'scale') && ~isempty(app.scale) && app.scale ~= 0
    scaledDisplacement = app.scale * ux;
   
else
    scaledDisplacement = ux;
   
end

% Plot
figure(9);
clf
pdeplot(app.model2, 'XYData', scaledDisplacement, 'Colormap', 'jet');
title('Image-based FEA X-displacement magnitude');
axis equal;
xlabel(''); ylabel('');
set(gca, 'XTick', []); set(gca, 'YTick', []);
axis off;
set(gca,'YDir','reverse')


        end

        % Button pushed function: vonMisesstressButton_2
        function vonMisesstressButton_2Pushed(app, event)
if isempty(app.img)
    % Show alert and stop execution
    uialert(app.UIFigure, 'Please browse and load an image first.', 'No Image Found');
    return;  % Exit immediately
end
            valStr = strtrim(app.EditField.Value);
% Check if empty
if isempty(valStr)
    uialert(app.UIFigure, ...
         'Please press Enter for FEA simulation first.', ...
        'Input Required', ...
        'Icon','warning');
    return;  % Stop further execution
end
            
          
vonmisesstress2=app.result2.VonMisesStress;
vonmises_MPa = vonmisesstress2 / 1e6;  % Convert to MPa
figure (9);
pdeplot(app.model2, 'XYData', vonmisesstress2/1e6, 'Colormap', 'jet');
set(gca, 'YDir', 'reverse');
title('Image-bases FEA Von Mises stress (MPa)')
axis equal;
xlabel(''); ylabel('');
set(gca, 'XTick', []); set(gca, 'YTick', []);
axis off;
set(gca,'YDir','reverse')
cb = colorbar;
% Tight color limits
clim([min(vonmises_MPa(:)), max(vonmises_MPa(:))]);
colormap(jet) 
axis off;

        end

        % Button pushed function: YDisplacementButton_2
        function YDisplacementButton_2Pushed(app, event)
if isempty(app.img)
    % Show alert and stop execution
    uialert(app.UIFigure, 'Please browse and load an image first.', 'No Image Found');
    return;  % Exit immediately
end
            valStr = strtrim(app.EditField.Value);
% Check if empty
if isempty(valStr)
    uialert(app.UIFigure, ...
         'Please press Enter for FEA simulation first.', ...
        'Input Required', ...
        'Icon','warning');
    return;  % Stop further execution
end
            uy = app.result2.Displacement.uy;

% Check if app.scale exists and is nonzero
if isprop(app, 'scale') && ~isempty(app.scale) && app.scale ~= 0
    scaledDisplacement = app.scale * uy;
   
else
    scaledDisplacement = uy;
   
end

% Plot
figure(10);
clf
pdeplot(app.model2, 'XYData', scaledDisplacement, 'Colormap', 'jet');
title('Image-based FEA Y-displacement magnitude');
axis equal;
xlabel(''); ylabel('');
set(gca, 'XTick', []); set(gca, 'YTick', []);
axis off;
set(gca,'YDir','reverse')
        end

        % Button pushed function: ShearstressButton_2
        function ShearstressButton_2Pushed(app, event)
     if isempty(app.img)
    % Show alert and stop execution
    uialert(app.UIFigure, 'Please browse and load an image first.', 'No Image Found');
    return;  % Exit immediately
end
            valStr = strtrim(app.EditField.Value);
% Check if empty
if isempty(valStr)
    uialert(app.UIFigure, ...
         'Please press Enter for FEA simulation first.', ...
        'Input Required', ...
        'Icon','warning');
    return;  % Stop further execution
end
            stress = app.result2.Stress;

shearStress = stress.sxy;             % Pa
shearStress_MPa = shearStress / 1e6;  % Convert to MPa

figure(5); 
pdeplot(app.model2, 'XYData', shearStress_MPa, 'ColorMap', 'jet');
set(gca, 'YDir', 'reverse');
title('Image-based FEA shear stress (\tau_{xy}) (MPa)');
axis equal;

xlabel(''); ylabel('');
set(gca, 'XTick', []); set(gca, 'YTick', []);
axis off;
set(gca,'YDir','reverse')


% Add colorbar with units
cb = colorbar;


% Optional: tighten color limits to min/max values
clim([min(shearStress_MPa(:)), max(shearStress_MPa(:))]);
axis off;
        end

        % Button pushed function: NormalstressXButton_2
        function NormalstressXButton_2Pushed(app, event)
if isempty(app.img)
    % Show alert and stop execution
    uialert(app.UIFigure, 'Please browse and load an image first.', 'No Image Found');
    return;  % Exit immediately
end
            valStr = strtrim(app.EditField.Value);
% Check if empty
if isempty(valStr)
    uialert(app.UIFigure, ...
         'Please press Enter for FEA simulation first.', ...
        'Input Required', ...
        'Icon','warning');
    return;  % Stop further execution
end
            % Visualize shear stress (\tau_{xy})
  stress = app.result2.Stress;

% Extract normal stress
normalStress = stress.sxx;  % Change to syy or szz as needed

% Compute normal yield and fracture limits
%normalYield = app.yieldStress;
%normalFracture = app.fractureStress;

% Create mask for different regions
%elasticRegion = abs(normalStress) <= normalYield;
%plasticRegion = abs(normalStress) > normalYield & abs(normalStress) <= normalFracture;
%fractureRegion = abs(normalStress) > normalFracture;

% Saturate stress for visualization
%normalStressCapped = min(normalStress, normalFracture);  % Clip upper bound

% Start figure
figure(13); 
pdeplot(app.model2, 'XYData', normalStress/1e6, 'ColorMap', 'jet');
set(gca, 'YDir', 'reverse');
title('Image-based FEA normal stress(\sigma_{xx})(MPa)');  % Update the title
colorbar;
%clim([min(normalStress(:)), normalFracture]);  % Fix color scale
axis equal;
xlabel(''); ylabel('');
set(gca, 'XTick', []); set(gca, 'YTick', []);
axis off;
set(gca,'YDir','reverse')


% Update colorbar label
%cb = colorbar;
%cb.Label.String = 'Normal Stress (\sigma_{xx})';
        end

        % Button pushed function: NormalstressYButton_2
        function NormalstressYButton_2Pushed(app, event)
if isempty(app.img)
    % Show alert and stop execution
    uialert(app.UIFigure, 'Please browse and load an image first.', 'No Image Found');
    return;  % Exit immediately
end
            valStr = strtrim(app.EditField.Value);
% Check if empty
if isempty(valStr)
    uialert(app.UIFigure, ...
         'Please press Enter for FEA simulation first.', ...
        'Input Required', ...
        'Icon','warning');
    return;  % Stop further execution
end
            stress = app.result2.Stress;

% Extract normal stress
normalStress = stress.syy;  % Change to syy or szz as needed

% Compute normal yield and fracture limits
%normalYield = app.yieldStress;
%normalFracture = app.fractureStress;

% Create mask for different regions
%elasticRegion = abs(normalStress) <= normalYield;
%plasticRegion = abs(normalStress) > normalYield & abs(normalStress) <= normalFracture;
%fractureRegion = abs(normalStress) > normalFracture;

% Saturate stress for visualization
%normalStressCapped = min(normalStress, normalFracture);  % Clip upper bound

% Start figure
figure(14); 
pdeplot(app.model2, 'XYData',normalStress/1e6, 'ColorMap', 'jet');
set(gca, 'YDir', 'reverse');
title('Image-based normal stress(\sigma_{yy})(MPa)');  % Update the title
colorbar;
%clim([min(normalStress(:)), normalFracture]);  % Fix color scale
xlabel(''); ylabel('');
set(gca, 'XTick', []); set(gca, 'YTick', []);
axis off;
set(gca,'YDir','reverse')

% Update colorbar label
%cb = colorbar;
%cb.Label.String = 'Normal Stress (\sigma_{yy})';  
            
            
        end

        % Value changed function: SetunitDropDown
        function SetunitDropDownValueChanged(app, event)
            %value = app.SetunitDropDown.Value;
            
        end

        % Value changed function: SelectoptionDropDown
        function SelectoptionDropDownValueChanged(app, event)
            %value = app.SelectoptionDropDown.Value;
            
        end

        % Button pushed function: CloseallButton
        function CloseallButtonPushed(app, event)
            for k = 1:14
               if isvalid(figure(k))  % Ensure figure exists
               close(k);            % Clear contents of figure k
               end
             end
        end

        % Button pushed function: BackButton
        function BackButtonPushed(app, event)
     newApp = AIBioMech();  % open front page
    drawnow; 
    pause(2);% make sure it renders
    delete(app); 
   
        end

        % Value changed function: PoissonsratioEditField
        function PoissonsratioEditFieldValueChanged(app, event)
            %value = app.PoissonsratioEditField.Value;
            
        end

        % Callback function
        function ButtonPushed(app, event)
%% --- Step 0: Prepare binary image ---
app.binaryImage = ~(app.paddedImage);  % Invert so white = region of interest

%% --- Step 1: Find white pixels ---
[row, col] = find(app.binaryImage == 1);

%% --- Step 2: Create grid of points inside white region ---
gridSpacing = 2;  % Adjust as needed
minX = min(col); maxX = max(col);
minY = min(row); maxY = max(row);

[xGrid, yGrid] = meshgrid(minX:gridSpacing:maxX, minY:gridSpacing:maxY);
xGrid = xGrid(:);
yGrid = yGrid(:);

%% --- Step 3: Keep only points inside white region ---
validIndices = app.binaryImage(sub2ind(size(app.binaryImage), round(yGrid), round(xGrid))) == 1;
validX = xGrid(validIndices);
validY = yGrid(validIndices);

%% --- Step 4: Delaunay triangulation ---
tri = delaunay(validX, validY);

%% --- Step 5: Remove triangles crossing black regions ---
mask = false(size(tri,1),1);
for i = 1:size(tri,1)
    verts = [validX(tri(i,:)), validY(tri(i,:))];
    if ~anyEdgeCrossesBlackRegion(verts, app.binaryImage)
        mask(i) = true;
    end
end
validTriangles = tri(mask,:);

%% --- Step 6: Flip Y to Cartesian coordinates ---
validY = max(validY) - validY;

%% --- Step 7: Prepare nodes and elements for PDE ---
nodes = [validX'; validY'];       % 2 x N
elements = validTriangles';       % 3 x M

% Ensure elements have counter-clockwise orientation
for i = 1:size(elements,2)
    v1 = nodes(:,elements(1,i));
    v2 = nodes(:,elements(2,i));
    v3 = nodes(:,elements(3,i));
    signedArea = (v2(1)-v1(1))*(v3(2)-v1(2)) - (v2(2)-v1(2))*(v3(1)-v1(1));
    if signedArea < 0
        elements([2 3],i) = elements([3 2],i);
    end
end

%% --- Step 8: Optional scaling to meters ---
nodes = nodes * app.scale;

%% --- Step 9: Validate mesh ---
if isempty(elements)
    error('No valid triangles found. Try reducing gridSpacing or check the binary image.');
end

%% --- Step 10: Create PDE model ---
switch app.SelectoptionDropDown.Value
    case 'Plane-stress'
        app.model1 = createpde('structural','static-planestress');
    otherwise
        app.model1 = createpde('structural','static-planestrain');
end

%% --- Step 11: Import mesh into PDE model ---
geometryFromMesh(app.model1, nodes, elements);

%% --- Step 8b: Scale nodes to meters ---
nodes = nodes * app.scale; 

%% Step 6: Create PDE structural model
switch app.SelectoptionDropDown.Value
    case 'Plane-stress'
       app.model1 = createpde('structural','static-planestress');

    otherwise
       app.model1 = createpde('structural','static-planestrain');  
end
geometryFromMesh(app.model1, nodes', elements);

%% Step 7: Define material properties
p= app.PoissonsratioEditField.Value;
structuralProperties(app.model1, 'YoungsModulus', app.E, 'PoissonsRatio', p);


%% Step 8: Identify top and bottom edges


%% Step 9: Apply displacement BCs in real-world units
% Find top and bottom edges for BC (nearestEdge function or manual)
vertices = app.model1.Geometry.Vertices;
maxY = max(vertices(:,2));
minY = min(vertices(:,2));

topEdgePoint = [mean(vertices(vertices(:,2) == maxY,1)), maxY];
bottomEdgePoint = [mean(vertices(vertices(:,2) == minY,1)), minY];

topEdgeID = nearestEdge(app.model1.Geometry, topEdgePoint);
bottomEdgeID = nearestEdge(app.model1.Geometry, bottomEdgePoint);

% Apply displacement BC at top (yield strain displacement)
yield_disp_m =  [app.YdisplacementEditField.Value]*10e-6; % approximate displacement at yield in meters
structuralBC(app.model1, 'Edge', topEdgeID, 'Displacement', [0, yield_disp_m]); % downward displacement
structuralBC(app.model1, 'Edge', bottomEdgeID, 'YDisplacement', 0);

% Solve model
app.result1 = solve(app.model1);
F = evaluateReaction(app.result1,'Edge',topEdgeID);
Fx_total = sum(F.Fx); % N
Fy_total = sum(F.Fy); % N
Fmag = sqrt(Fx_total^2 + Fy_total^2)*10e-6;
app.EditField_3.Value=Fmag;
        end

        % Value changed function: AreaEditField
        function AreaEditFieldValueChanged(app, event)
            %value = app.AreaEditField.Value;
            
        end

        % Callback function
        function stressPAEditFieldValueChanged(app, event)
           % value = app.stressPAEditField.Value;
            
        end

        % Callback function
        function AreamEditFieldValueChanged(app, event)
            %value = app.AreamEditField.Value;
            
        end

        % Callback function
        function ButtonPushed2(app, event)
          
%vertices = app.model1.Geometry.Vertices;
%maxY = max(vertices(:,2));
%topEdgeNodes = find(abs(app.model1.Mesh.Nodes(2,:) - maxY) < 1e-12); 
stress = app.result1.Stress;

% σ_yy at top edge nodes
%sigma_yy_top = stress.syy(topEdgeNodes);
%maxStressTop = max(sigma_yy_top);
% edge nodes
topEdgeNodes = find(abs(app.model1.Mesh.Nodes(2,:) - max(app.model1.Mesh.Nodes(2,:))) < 1e-12);
%topEdgeX = app.model1.Mesh.Nodes(1, topEdgeNodes);

% approximate edge length
%edgeLength = max(topEdgeX) - min(topEdgeX); % meters

% thickness of your plate
thickness_m = 0.05; % e.g., 10 µm
edgeLength=app.PhysicallengthEditField.Value;
% cross-sectional area
A = edgeLength * thickness_m; % m²
% using average stress
sigma_avg = mean(stress.syy(topEdgeNodes)); % Pa
F_avg = sigma_avg * A; % N
fprintf('Force from average stress: %.3e N\n', F_avg);

% using maximum stress (conservative)
sigma_max = max(stress.syy(topEdgeNodes));
F_max = sigma_max * A;

app.EditField_3.Value=F_max;
        end

        % Button pushed function: ExportstressstrainButton
        function ExportstressstrainButtonPushed3(app, event)
           if isempty(app.img)
    % Show alert and stop execution
    uialert(app.UIFigure, 'Please browse and load an image first.', 'No Image Found');
    return;  % Exit immediately
end
            % Get actual min and max von Mises stress from data (for color axis)
% Check if EditField_2 is emptyvalStr = strtrim(app.EditField_2.Value);
valStr = strtrim(app.EditField_2.Value);
% Check if empty
if isempty(valStr)
    uialert(app.UIFigure, ...
        'Please press Enter for prediction first.', ...
        'Input Required', ...
        'Icon','warning');
    return;  % Stop further execution
end
            


%% ================== STRESS DATA ==================
exx = app.result1.Strain.exx(:);
eyy = app.result1.Strain.eyy(:);
exy = app.result1.Strain.exy(:);
vmStress = app.result1.VonMisesStress(:);

% Equivalent strain
eqStrain = sqrt(exx.^2 + eyy.^2 - exx.*eyy + 3*exy.^2);

% Use max values
maxStrain = max(eqStrain);
maxStress = max(vmStress);

% Build line
strainLine = linspace(0, maxStrain, 1000);
stressLine = (maxStress / maxStrain) * strainLine;

% Export
strainPercent = strainLine*100;
stressMPa = stressLine/1e6;

%% ================== UNIT CONVERSION ==================
% Convert units


% Combine data into one matrix
data = [strainPercent(:), stressMPa(:)];  % 2 columns: Strain | Stress(MPa)

% Ask user for file path and name
[filename, pathname] = uiputfile('*.csv', 'Save Stress-Strain Data As');

% Check if user canceled
if isequal(filename,0) || isequal(pathname,0)
    disp('User canceled file save');
else
    fullFileName = fullfile(pathname, filename);
    
    % Optional: write header
    header = {'Strain (%)', 'Stress(MPa)'};
    
    % Write header
    fid = fopen(fullFileName,'w');
    fprintf(fid, '%s,%s\n', header{:});
    fclose(fid);
    
    % Write data
    writematrix(data, fullFileName, 'WriteMode','append');
    
    % Show popup in App Designer
    msgbox(['Stress-strain data saved successfully to: ' fullFileName], ...
           'Download Complete');
end
        end

        % Button pushed function: ExportstressstrainButton_2
        function ExportstressstrainButton_2Pushed(app, event)
 if isempty(app.img)
    % Show alert and stop execution
    uialert(app.UIFigure, 'Please browse and load an image first.', 'No Image Found');
    return;  % Exit immediately
end
            valStr = strtrim(app.EditField.Value);
% Check if empty
if isempty(valStr)
    uialert(app.UIFigure, ...
         'Please press Enter for FEA simulation first.', ...
        'Input Required', ...
        'Icon','warning');
    return;  % Stop further execution
end
            
          exx = app.result2.Strain.exx(:);
eyy = app.result2.Strain.eyy(:);
exy = app.result2.Strain.exy(:);
vmStress = app.result2.VonMisesStress(:);

% Equivalent strain
eqStrain = sqrt(exx.^2 + eyy.^2 - exx.*eyy + 3*exy.^2);

% Use max values
maxStrain = max(eqStrain);
maxStress = max(vmStress);

% Build line
strainLine = linspace(0, maxStrain, 1000);
stressLine = (maxStress / maxStrain) * strainLine;

% Export
strainPercent = strainLine*100;
stressMPa = stressLine/1e6;

% Combine data into one matrix
data = [strainPercent(:), stressMPa(:)];  % 2 columns: Strain | Stress(MPa)

% Ask user for file path and name
[filename, pathname] = uiputfile('*.csv', 'Save Stress-Strain Data As');

% Check if user canceled
if isequal(filename,0) || isequal(pathname,0)
    disp('User canceled file save');
else
    fullFileName = fullfile(pathname, filename);
    
    % Optional: write header
    header = {'Strain (%)', 'Stress(MPa)'};
    
    % Write header
    fid = fopen(fullFileName,'w');
    fprintf(fid, '%s,%s\n', header{:});
    fclose(fid);
    
    % Write data
    writematrix(data, fullFileName, 'WriteMode','append');
    
    % Show popup in App Designer
    msgbox(['Stress-strain data saved successfully to: ' fullFileName], ...
           'Download Complete');
end
        end

        % Callback function
        function ButtonPushed3(app, event)
            app.invertROI = true;  % Set the flag
    % Optionally, immediately update the binary image display
    app.binaryimage = ~app.binaryimage;
    imshow(app.binaryimage, 'Parent', app.UIAxes2);
        end

        % Value changed function: SelectROIDropDown
        function SelectROIDropDownValueChanged(app, event)
            value = app.SelectROIDropDown.Value;
           
        end

        % Button pushed function: EnterButton_4
        function EnterButton_4Pushed4(app, event)
 if isempty(app.img)
    % Show alert and stop execution
    uialert(app.UIFigure, 'Please browse and load an image first.', 'No Image Found');
    return;  % Exit immediately
end
            app.EditField_2.Value='';
           app.EditField.Value='';
           app.PredictiontimesecEditField.Value=0;
           app.FEAtimesecEditField.Value=0;
            
            d = uiprogressdlg(app.UIFigure, ...
    'Title','Select ROI', ...
    'Message','ROI has been selected successfully.', ...
    'Indeterminate','on', ...
    'Cancelable','off');


           % Get original binary image
originalImage = app.binaryimage1;
[height, width] = size(originalImage);

% Initialize padded image as original
app.paddedImage = originalImage;

% Select ROI type
switch app.SelectROIDropDown.Value
    case 'Black'
        % Black region = 0
        regionMask  = (originalImage == 0);
        paddingColor = 0;

    case 'White'
        % White region = 1
        regionMask  = (originalImage == 1);
        paddingColor = 1;

    otherwise
        disp('No valid ROI selected.');
        imshow(originalImage);
        return;
end

% Find rows containing region pixels (ROBUST for diagonal shapes)
regionPixelRows = find(any(regionMask, 2));

% If no region found
if isempty(regionPixelRows)
    disp(['No ' app.SelectROIDropDown.Value ' pixels found in the image.']);
    imshow(originalImage);
    return;
end

% Find original top and bottom rows
topRowRaw    = min(regionPixelRows);
bottomRowRaw = max(regionPixelRows);

% Tolerance (ignore extreme rows)
tolerance = 3;

% Adjusted top & bottom rows (safe-guarded)
topRow    = min(regionPixelRows(regionPixelRows >= topRowRaw + tolerance));
bottomRow = max(regionPixelRows(regionPixelRows <= bottomRowRaw - tolerance));

% Fallback if tolerance removes everything
if isempty(topRow) || isempty(bottomRow)
    topRow    = topRowRaw;
    bottomRow = bottomRowRaw;
end

% Padding size
paddingSize = 10;

% Add padding ABOVE (with tolerance)
startRow = max(1, topRow - paddingSize);
app.paddedImage(startRow:topRow-1, :) = paddingColor;

% Add padding BELOW (with tolerance)
endRow = min(height, bottomRow + paddingSize);
app.paddedImage(bottomRow+1:endRow, :) = paddingColor;

% Display result
imshow(app.paddedImage);
        end

        % Button pushed function: TensionButton
        function TensionButtonPushed(app, event)
            if isempty(app.img)
    % Show alert and stop execution
    uialert(app.UIFigure, 'Please browse and load an image first.', 'No Image Found');
    return;  % Exit immediately
end   
            app.result2=[];
        app.model2=[];
            %clear app.model2
           % close all
      
           
    
    % Simulate some processing
if app.YoungsmodulusEditField.Value == 0
    uialert(app.UIFigure, ...
        'Please enter a valid Young''s Modulus value greater than 0.', ...
        'Invalid Input', ...
        'Icon','warning');
    return;  % Stop further execution
end  

nu = app.PoissonsratioEditField.Value;

% Validate input
if isnan(nu) || nu <= 0 || nu >= 0.5
    uialert(app.UIFigure, ...
        'Please enter a valid Poisson''s ratio between 0 and 0.5.', ...
        'Invalid Input', ...
        'Icon','warning');
    return;  % Stop execution
end
 if app.YdisplacementEditField.Value == 0

% Validate input
    uialert(app.UIFigure, ...
        'Please enter a valid numeric value for Y displacement.', ...
        'Invalid Input', ...
        'Icon','warning');
    return;  % Stop execution
 end
  d = uiprogressdlg(app.UIFigure, ...
    'Title','Image-based FEA simulation', ...
    'Message','Processing...', ...
    'Indeterminate','on', ...
    'Cancelable','off');


            % Material properties
             tic;
            % Material properties
             
    
    % Simulate some processing
   
app.E =  app.YoungsmodulusEditField.Value;           % Young's modulus (Pa)

 img = app.paddedImage;

% Process based on ROI selection
switch app.SelectROIDropDown.Value
    case 'White'
        % White region = 1
        app.binaryimage = (img == 1);

    case 'Black'
        % Black region = 0
        app.binaryimage = (img == 0);

    otherwise
         uialert(app.UIFigure, ...
        'Please select region of interest.', ...
        'Invalid ROI', ...
        'Icon','warning');
        return;
end

% Get row and column indices of selected region
[row, col] = find(app.binaryimage);

%% Step 3: Create a Grid of Points Inside the White Region
gridSpacing = 1.8; % Grid spacing (in pixels)
minX = min(col); maxX = max(col);
minY = min(row); maxY = max(row);
[xGrid, yGrid] = meshgrid(minX:gridSpacing:maxX, minY:gridSpacing:maxY);

xGrid = xGrid(:); yGrid = yGrid(:);

%% Step 4: Masking - Keep Only Points Inside the White Region
validIndices = app.binaryimage(sub2ind(size(app.binaryimage), round(yGrid), round(xGrid))) == 1;
validX = xGrid(validIndices); validY = yGrid(validIndices);




%% Step 5: Delaunay Triangulation
app.triangles = delaunay(validX, validY);

%% Step 6: Remove Triangles That Cross Black Regions
validTriangles = [];
for i = 1:size(app.triangles, 1)
    triangleVertices = [validX(app.triangles(i, :)), validY(app.triangles(i, :))];
    if ~anyEdgeCrossesBlackRegion(triangleVertices, app.binaryimage)
        validTriangles = [validTriangles; app.triangles(i, :)];
    end
end

%% Step 7: Flip Y-coordinates to Match Cartesian System
validY = max(validY) - validY;

mesh.Vertices = [validX, max(validY) - validY];
%mesh.Vertices = [validX, max(validY) - validY] * 1e-3; % Convert pixels to meters (example)
mesh.Elements = validTriangles;

Vertices = mesh.Vertices;
elements = mesh.Elements;

nodes = Vertices';  % 2xN
elements = elements'; % 3xM

% Fix element orientation (counter-clockwise)
for i = 1:size(elements, 2)
    v1 = nodes(:, elements(1,i));
    v2 = nodes(:, elements(2,i));
    v3 = nodes(:, elements(3,i));
    signedArea = (v2(1)-v1(1))*(v3(2)-v1(2)) - (v2(2)-v1(2))*(v3(1)-v1(1));
    if signedArea < 0
        elements([2 3],i) = elements([3 2],i);
    end
end

switch app.SelectoptionDropDown.Value
    case 'Plane-stress'
       app.model2 = createpde('structural','static-planestress');

    otherwise
       app.model2 = createpde('structural','static-planestrain');  
end



% Create PDE model
%app.model1 = createpde('structural','static-planestrain');
geometryFromMesh(app.model2, nodes, elements);
%generateMesh(app.model1, 'Hmax', 0.5);
%generateMesh(app.model1, 'Hmax', 0.1);
% Define material properties
P= app.PoissonsratioEditField.Value;
structuralProperties(app.model2, 'YoungsModulus', app.E, 'PoissonsRatio', P);

% Find top and bottom edges for BC (nearestEdge function or manual)
vertices = app.model2.Geometry.Vertices;
maxY = max(vertices(:,2));
minY = min(vertices(:,2));

topEdgePoint = [mean(vertices(vertices(:,2) == maxY,1)), maxY];
bottomEdgePoint = [mean(vertices(vertices(:,2) == minY,1)), minY];

topEdgeID = nearestEdge(app.model2.Geometry, topEdgePoint);
bottomEdgeID = nearestEdge(app.model2.Geometry, bottomEdgePoint);

%app.YdisplacementEditField.Value = -app.YdisplacementEditField.Value;
    

% Apply displacement BC at top (yield strain displacement)
yield_disp_m =  (app.YdisplacementEditField.Value/100) * (maxY - minY); % approximate displacement at yield in meters
structuralBC(app.model2, 'Edge', topEdgeID, 'Displacement', [0, yield_disp_m]); % downward displacement
structuralBC(app.model2, 'Edge', bottomEdgeID, 'YDisplacement', 0);

% Solve model
try
    app.result2 = solve(app.model2);   % run solver

catch
    uialert(app.UIFigure, ...
        'Please provide a high-resolution image\n.The selected region is invalid or contains disconnected patches', ...
        'Meshing Failed', ...
        'Icon','error');

    if exist('h1','var') && isvalid(h1)
            % show for 2 seconds
close(d);
    end

    return;   % stop execution
end
     % show for 2 seconds


pause(65);

toc;

close(d);
if app.PixelslengthEditField.Value == 0 && app.PhysicallengthEditField.Value == 0
    uialert(app.UIFigure, ...
        ['Scale has not been set.' ...
         'All results are calculated using the default pixel scale.'], ...
        'Default Scale', ...
        'Icon','info');
end
%% ================== STRAIN DATA ==================

exx = app.result2.Strain.exx;
eyy = app.result2.Strain.eyy;
exy = app.result2.Strain.exy;

% Equivalent (von Mises) strain
eqStrain = sqrt(exx.^2 + eyy.^2 - exx.*eyy + 3*exy.^2);

% Average equivalent strain (global)
avgStrain = mean(eqStrain, 'all');
% Maximum equivalent strain
maxStrainValue = max(eqStrain(:));

%% ================== STRESS DATA ==================
vmStress = app.result2.VonMisesStress;   % Pa

% Average equivalent stress
avgStress = mean(vmStress, 'all');
% Maximum von Mises stress
maxStressValue = max(vmStress(:));

%% ================== GEOMETRY-BASED ELASTIC MODULUS ==================
% Use AVERAGE values to calculate effective modulus
E_eff = avgStress / avgStrain;           % Pa

%% ================== BUILD ELASTIC CURVE ==================
nPts = 300;
% Use MAX strain for plotting to show full range
strainLine = linspace(0, maxStrainValue, nPts);   % dimensionless
stressLine = E_eff * strainLine;             % Pa

%% ================== UNIT CONVERSION ==================
strainPercent = strainLine * 100;
stressMPa = stressLine / 1e6;

%% ================== TIMING ==================
elapsedTime = toc;
app.FEAtimesecEditField.Value = elapsedTime;

%% ================== MAX VALUES ==================
% Use ACTUAL maximum values from simulation
% NOT the endpoint of the calculated curve
maxStrainPercent = maxStrainValue * 100;  % Actual max from simulation
maxStressMPa = maxStressValue / 1e6;      % Actual max from simulation

%% ================== MAX VALUES ==================
maxStrainValue = strainLine(end);  % Use end of strainLine, not max from simulation
maxStressValue = stressLine(end);
app.EditField.Value = sprintf( ...
    'Max strain = %.3f %%\nMax stress = %.2f MPa', ...
    maxStrainValue*100, maxStressValue/1e6 );



        end

        % Callback function
        function ButtonPushed4(app, event)
            %% ================== INITIAL CHECKS ==================
%close all;

% ROI selection check
if strcmp(app.SelectROIDropDown.Value,'Select options')
    uialert(app.UIFigure,'Please select the ROI.','No valid ROI');
    return;
end

if isempty(app.binaryimage) || ~any(app.binaryimage(:) == 0)
    uialert(app.UIFigure,'Please select the ROI.','No valid ROI');
    return;
end

% Material properties check
if app.YoungsmodulusEditField.Value <= 0
    uialert(app.UIFigure,'Please enter a valid Young''s Modulus value > 0.','Invalid Input','Icon','warning');
    return;
end
if app.YieldstrengthEditField.Value <= 0
    uialert(app.UIFigure,'Please enter a valid Yield strength value > 0.','Invalid Input','Icon','warning');
    return;
end

% Poisson ratio check
nu = app.PoissonsratioEditField.Value;
if isnan(nu) || nu <= 0 || nu >= 0.5
    uialert(app.UIFigure,'Please enter a valid Poisson''s ratio between 0 and 0.5.','Invalid Input','Icon','warning');
    return;
end

% Displacement check
if app.YdisplacementEditField.Value == 0
    uialert(app.UIFigure,'Please enter a valid numeric value for Y displacement.','Invalid Input','Icon','warning');
    return;
end

%% ================== PROGRESS DIALOG ==================
d = uiprogressdlg(app.UIFigure, 'Title','AI-BioMech Prediction', ...
    'Message','Processing...', 'Indeterminate','on','Cancelable','off');
tic;

%% ================== MATERIAL PROPERTIES ==================
E = app.YoungsmodulusEditField.Value;             % Young's modulus (Pa)
sigma_y_material = app.YieldstrengthEditField.Value; % Yield stress (Pa)
Ep = 0.02 * E;                                    % Plastic modulus → 2% hardening
P = app.PoissonsratioEditField.Value;             % Poisson ratio

%% ================== IMAGE AND MESH PROCESSING ==================
app.binaryimage = ~(app.paddedImage);
[row, col] = find(app.binaryimage == 1);

% Grid points inside white region
gridSpacing = 2; % pixels
[xGrid, yGrid] = meshgrid(min(col):gridSpacing:max(col), min(row):gridSpacing:max(row));
xGrid = xGrid(:); yGrid = yGrid(:);

% Keep only points inside white region
validIndices = app.binaryimage(sub2ind(size(app.binaryimage), round(yGrid), round(xGrid))) == 1;
validX = xGrid(validIndices); validY = yGrid(validIndices);

% Delaunay triangulation
triangles = delaunay(validX, validY);

% Remove triangles crossing black regions
validTriangles = [];
for i = 1:size(triangles,1)
    verts = [validX(triangles(i,:)), validY(triangles(i,:))];
    if ~anyEdgeCrossesBlackRegion(verts, app.binaryimage)
        validTriangles = [validTriangles; triangles(i,:)];
    end
end

% Flip Y-coordinates to match Cartesian
validY = max(validY) - validY;
mesh.Vertices = [validX, validY];
mesh.Elements = validTriangles;

Vertices = mesh.Vertices;
Elements = mesh.Elements;

nodes = Vertices';
elements = Elements';

% Fix element orientation (counter-clockwise)
for i = 1:size(elements,2)
    v1 = nodes(:,elements(1,i));
    v2 = nodes(:,elements(2,i));
    v3 = nodes(:,elements(3,i));
    signedArea = (v2(1)-v1(1))*(v3(2)-v1(2)) - (v2(2)-v1(2))*(v3(1)-v1(1));
    if signedArea < 0
        elements([2 3],i) = elements([3 2],i);
    end
end

%% ================== PDE MODEL ==================
switch app.SelectoptionDropDown.Value
    case 'Plane-stress'
        app.model1 = createpde('structural','static-planestress');
    otherwise
        app.model1 = createpde('structural','static-planestrain');  
end

geometryFromMesh(app.model1, nodes, elements);
structuralProperties(app.model1, 'YoungsModulus', E, 'PoissonsRatio', P);

% Identify top/bottom edges
vertices = app.model1.Geometry.Vertices;
maxY = max(vertices(:,2));
minY = min(vertices(:,2));
topEdgePoint = [mean(vertices(vertices(:,2) == maxY,1)), maxY];
bottomEdgePoint = [mean(vertices(vertices(:,2) == minY,1)), minY];
topEdgeID = nearestEdge(app.model1.Geometry, topEdgePoint);
bottomEdgeID = nearestEdge(app.model1.Geometry, bottomEdgePoint);

% Apply displacement BC (pixels input)
yield_disp_m = -(app.YdisplacementEditField.Value / 100) * (maxY - minY); % % of height
structuralBC(app.model1, 'Edge', topEdgeID, 'Displacement', [0, yield_disp_m]);
structuralBC(app.model1, 'Edge', bottomEdgeID, 'YDisplacement', 0);

%% ================== SOLVE PDE ==================
try
    app.result1 = solve(app.model1);
catch
    uialert(app.UIFigure,'Invalid ROI or disconnected patches.','Prediction Failed','Icon','error');
    close(d);
    return;
end
pause(2); close(d);

%% ================== STRAIN AND STRESS ==================
exx = app.result1.Strain.exx;
eyy = app.result1.Strain.eyy;
exy = app.result1.Strain.exy;

% Equivalent von Mises strain field
eqStrain = sqrt(exx.^2 + eyy.^2 - exx.*eyy + 3*exy.^2);
avgStrain = mean(eqStrain, 'all');
maxStrainFEM = max(eqStrain, [], 'all');

vmStress = app.result1.VonMisesStress;
maxVmStress = max(vmStress, [], 'all');

%% ================== GEOMETRY-BASED YIELD ==================
geometryFactor = maxVmStress / sigma_y_material;
sigma_y_effective = sigma_y_material / geometryFactor;
eps_y_effective = sigma_y_effective / E;

fprintf('Geometry factor = %.2f\n', geometryFactor);
fprintf('Effective yield stress = %.2f MPa\n', sigma_y_effective/1e6);

%% ================== BUILD BILINEAR CURVE ==================
nPts = 300;
strainLine = linspace(0, maxStrainFEM, nPts);
stressLine = zeros(size(strainLine));

for i = 1:nPts
    if strainLine(i) <= eps_y_effective
        stressLine(i) = E * strainLine(i); % elastic
    else
        stressLine(i) = sigma_y_effective + Ep*(strainLine(i)-eps_y_effective); % plastic
    end
end

strainPercent = strainLine * 100;
stressMPa = stressLine / 1e6;

%% ================== UPDATE GUI ==================
app.EditField_2.Value = sprintf('Max strain = %.3f %%\nYield stress = %.2f MPa', ...
    strainPercent(end), max(stressMPa));

%% ================== PLOT ==================
figure(1); clf
ax = gca;
ax.Color = [0.5 1 0];
xlim([0 max(strainPercent)*1.1])
ylim([0 max(stressMPa)*1.1])
plot(strainPercent, stressMPa, 'b', 'LineWidth', 2); hold on;
plot(eps_y_effective*100, sigma_y_effective/1e6, 'ro', 'MarkerFaceColor','r', 'MarkerSize',8);
xlabel('Strain (%)'); ylabel('Stress (MPa)');
title('AI-BioMech Predicted Stress–Strain Response');
legend({'Bilinear response','Yield point'}, 'Location','southeast');
grid on; hold off;

%% ================== TIMING ==================
elapsedTime = toc;
app.PredictiontimesecEditField.Value = elapsedTime;

        end

        % Callback function
        function SliderValueChanged(app, event)
          value = app.Slider.Value;
    app.o = max(0, round(value));  % Ensure integer ≥ 0
    
    % Store original image when first loaded
    if isempty(app.OriginalBinaryImage)
        app.OriginalBinaryImage = app.binaryimage1;
    end
    
    % Store previous threshold value
    if isempty(app.PreviousO)
        app.PreviousO = 0;
    end
    
    % Decide how to process based on slider direction
    if app.o > app.PreviousO
        % Moving up: remove more small objects
        if app.o > 0
            app.binaryimage1 = bwareaopen(app.binaryimage1, app.o);
        end
    else
        % Moving down: need to go back to original and reapply smaller threshold
        app.binaryimage1 = bwareaopen(app.OriginalBinaryImage, app.o);
    end
    
    % Update previous value
    app.PreviousO = app.o;
    
    imshow(app.binaryimage1, 'Parent', app.UIAxes2);
        end

        % Button pushed function: CleanimageButton
        function CleanimageButtonPushed5(app, event)
  % ================= INITIAL SETUP =================
if isempty(app.img)
    % Show alert and stop execution
    uialert(app.UIFigure, 'Please browse and load an image first.', 'No Image Found');
    return;  % Exit immediately
end
app.binaryimage1=imresize(app.binaryimage1,[1024 1024]);
originalImg = app.binaryimage1 > 0;   % FORCE LOGICAL
baseImage   = originalImg;            
workingImg  = originalImg;            

% Create fullscreen figure
screenSize = get(0,'ScreenSize');
app.f = figure('Name','Image Editor','Position',screenSize,...
    'NumberTitle','off','MenuBar','none','ToolBar','none',...
    'Color',[0.78 0.82 0.75]);

ax = axes('Parent',app.f,'Position',[0.05 0.1 0.6 0.8]);
imshow(workingImg,'Parent',ax);

% ================= CONTROL PANEL =================
controlPanel = uipanel(app.f,'Position',[0.68 0.1 0.3 0.8],...
    'Title','Cleaning options','FontWeight','bold','FontSize',14,...
    'FontName','Verdana','BackgroundColor',[0.78 0.82 0.75],...
    'ForegroundColor',[0.05 0.17 0.31]);

% Define common button styling
buttonBgColor = [0.05 0.17 0.31];
buttonTextColor = [1 1 1];
fontName = 'Verdana';
fontSize = 12;

% Calculate positions
startY = 600;

% PIXEL COUNT DISPLAY with percentages (MOVED TO TOP)
app.pixelCountText = uicontrol(controlPanel, 'Style', 'text', ...
    'Position', [30 startY-60 300 60], 'String', 'White pixels: 0 (0%)   Black pixels: 0 (0%)   Total: 0', ...
    'HorizontalAlignment', 'center', 'FontSize', 11, ...
    'FontName', fontName, 'ForegroundColor', [0.05 0.17 0.31], ...
    'BackgroundColor', [0.78 0.82 0.75], 'FontWeight', 'bold');

% 1. ERASER CONTROLS
uicontrol(controlPanel, 'Style', 'text', 'Position', [30 startY-140 220 35], ...
    'String', 'ERASER SIZE', 'FontWeight', 'bold', 'FontSize', 14, ...
    'HorizontalAlignment', 'left', 'FontName', fontName, ...
    'ForegroundColor', [0.05 0.17 0.31], 'BackgroundColor', [0.78 0.82 0.75]);

app.eraserSizeSlider = uicontrol(controlPanel, 'Style', 'slider', ...
    'Position', [30 startY-160 220 30], 'Min', 1, 'Max', 50, 'Value', 15, ...
    'BackgroundColor', [0.88 0.92 0.88]);

app.eraserSizeText = uicontrol(controlPanel, 'Style', 'text', ...
    'Position', [30 startY-180 220 30], 'String', 'Size: 15 px', ...
    'HorizontalAlignment', 'center', 'FontSize', fontSize, ...
    'FontName', fontName, 'ForegroundColor', [0.05 0.17 0.31], ...
    'BackgroundColor', [0.78 0.82 0.75]);

% 2. EROSION CONTROLS
uicontrol(controlPanel, 'Style', 'text', 'Position', [30 startY-240 220 35], ...
    'String', 'EROSION', 'FontWeight', 'bold', 'FontSize', 14, ...
    'HorizontalAlignment', 'left', 'FontName', fontName, ...
    'ForegroundColor', [0.05 0.17 0.31], 'BackgroundColor', [0.78 0.82 0.75]);

app.erosionSlider = uicontrol(controlPanel, 'Style', 'slider', ...
    'Position', [30 startY-260 220 30], 'Min', 0, 'Max', 10, 'Value', 0, ...
    'BackgroundColor', [0.88 0.92 0.88]);

app.erosionText = uicontrol(controlPanel, 'Style', 'text', ...
    'Position', [30 startY-280 220 30], 'String', 'Erosion: 0 px', ...
    'HorizontalAlignment', 'center', 'FontSize', fontSize, ...
    'FontName', fontName, 'ForegroundColor', [0.05 0.17 0.31], ...
    'BackgroundColor', [0.78 0.82 0.75]);

% 3. DILATION CONTROLS
uicontrol(controlPanel, 'Style', 'text', 'Position', [30 startY-340 220 35], ...
    'String', 'DILATION', 'FontWeight', 'bold', 'FontSize', 14, ...
    'HorizontalAlignment', 'left', 'FontName', fontName, ...
    'ForegroundColor', [0.05 0.17 0.31], 'BackgroundColor', [0.78 0.82 0.75]);

app.dilationSlider = uicontrol(controlPanel, 'Style', 'slider', ...
    'Position', [30 startY-360 220 30], 'Min', 0, 'Max', 10, 'Value', 0, ...
    'BackgroundColor', [0.88 0.92 0.88]);

app.dilationText = uicontrol(controlPanel, 'Style', 'text', ...
    'Position', [30 startY-380 220 30], 'String', 'Dilation: 0 px', ...
    'HorizontalAlignment', 'center', 'FontSize', fontSize, ...
    'FontName', fontName, 'ForegroundColor', [0.05 0.17 0.31], ...
    'BackgroundColor', [0.78 0.82 0.75]);

% UNDO/REDO BUTTONS
undoBtn = uicontrol(controlPanel, 'Style', 'pushbutton', ...
    'Position', [30 startY-460 100 45], 'String', 'UNDO', ...
    'BackgroundColor', buttonBgColor, 'ForegroundColor', buttonTextColor, ...
    'FontSize', fontSize, 'FontName', fontName, 'FontWeight', 'bold');

redoBtn = uicontrol(controlPanel, 'Style', 'pushbutton', ...
    'Position', [150 startY-460 100 45], 'String', 'REDO', ...
    'BackgroundColor', buttonBgColor, 'ForegroundColor', buttonTextColor, ...
    'FontSize', fontSize, 'FontName', fontName, 'FontWeight', 'bold');

% SAVE BUTTON
saveBtn = uicontrol(controlPanel, 'Style', 'pushbutton', ...
    'Position', [30 startY-540 220 70], 'String', 'SAVE & EXIT', ...
    'FontWeight', 'bold', 'FontSize', 16, 'FontName', fontName, ...
    'BackgroundColor', buttonBgColor, 'ForegroundColor', buttonTextColor);

% ================= INITIALIZE VARIABLES =================
clickCount = 0;
done = false;
currentEraserSize = 15;

% Create UNDO/REDO stacks
undoStack = {};
undoStack{1} = baseImage;
currentIndex = 1;
maxUndos = 20;

% ================= HELPER FUNCTIONS =================
function updateEraserSize()
    currentEraserSize = round(get(app.eraserSizeSlider, 'Value'));
    set(app.eraserSizeText, 'String', sprintf('Size: %d px', currentEraserSize));
end

function saveState()
    % Save current state to undo stack
    if length(undoStack) >= maxUndos
        undoStack = undoStack(2:end);
        currentIndex = currentIndex - 1;
    end
    
    undoStack{end+1} = baseImage;
    currentIndex = length(undoStack);
end

function performUndo()
    if currentIndex > 1
        currentIndex = currentIndex - 1;
        baseImage = undoStack{currentIndex};
        updateDisplay();
        disp('Undo: Reverted last eraser action');
    else
        disp('Cannot undo further');
    end
end

function performRedo()
    if currentIndex < length(undoStack)
        currentIndex = currentIndex + 1;
        baseImage = undoStack{currentIndex};
        updateDisplay();
        disp('Redo: Restored next eraser action');
    else
        disp('Cannot redo further');
    end
end

function updateDisplay()
    % Get current slider values
    erosionVal = round(get(app.erosionSlider, 'Value'));
    dilationVal = round(get(app.dilationSlider, 'Value'));
    
    % Update display texts
    set(app.erosionText, 'String', sprintf('Erosion: %d px', erosionVal));
    set(app.dilationText, 'String', sprintf('Dilation: %d px', dilationVal));
    
    % Start from base image
    tempImg = baseImage;
    
    % Apply morphology
    if erosionVal > 0
        tempImg = imerode(tempImg, strel('disk', erosionVal));
    end
    
    if dilationVal > 0
        tempImg = imdilate(tempImg, strel('disk', dilationVal));
    end
    
    % Update working image and display
    workingImg = tempImg;
    imshow(workingImg, 'Parent', ax);
    
    % Calculate pixel counts and percentages
    totalPixels = numel(workingImg);
    whitePixels = sum(workingImg(:));
    blackPixels = totalPixels - whitePixels;
    
    whitePercent = (whitePixels / totalPixels) * 100;
    blackPercent = (blackPixels / totalPixels) * 100;
    
    % Update pixel count display (now at top)
    set(app.pixelCountText, 'String', ...
        sprintf('White pixels: %d (%.1f%%)   Black pixels: %d (%.1f%%)   Total: %d', ...
        whitePixels, whitePercent, blackPixels, blackPercent, totalPixels));
end

function saveAndExit()
    app.binaryimage1 = workingImg;
    done = true;
end

% ================= SETUP CALLBACKS =================
set(app.eraserSizeSlider, 'Callback', @(~,~) updateEraserSize());
set(app.erosionSlider, 'Callback', @(~,~) updateDisplay());
set(app.dilationSlider, 'Callback', @(~,~) updateDisplay());
set(undoBtn, 'Callback', @(~,~) performUndo());
set(redoBtn, 'Callback', @(~,~) performRedo());
set(saveBtn, 'Callback', @(~,~) saveAndExit());

% Initial display update
updateDisplay();

% ================= MAIN LOOP =================
while ~done && ishandle(app.f)
    try
        [x, y, button] = ginput(1);
        
        if isempty(button)
            continue;
        end
        
        if button == 1  % LEFT CLICK - ERASER
            x = round(x);
            y = round(y);
            
            [h, w] = size(baseImage);
            
            if x >= 1 && x <= w && y >= 1 && y <= h
                % Save state before editing
                saveState();
                
                clickCount = clickCount + 1;
                
                % Get eraser size
                eraserSize = round(get(app.eraserSizeSlider, 'Value'));
                halfSize = floor(eraserSize/2);
                
                % Calculate eraser bounds
                x1 = max(1, x - halfSize);
                x2 = min(w, x + halfSize);
                y1 = max(1, y - halfSize);
                y2 = min(h, y + halfSize);
                
                % SIMPLE AND EFFECTIVE ERASER LOGIC - BIT INVERSION
                baseImage(y1:y2, x1:x2) = ~baseImage(y1:y2, x1:x2);
                
                % Update display
                updateDisplay();
                
                % Visual feedback
                rectangle('Position', [x1, y1, x2-x1, y2-y1], ...
                    'EdgeColor', 'r', 'LineWidth', 1.5, 'LineStyle', '--');
                pause(0.1);
                imshow(workingImg, 'Parent', ax);
            end
            
        elseif button == 26  % Ctrl+Z (UNDO)
            performUndo();
            
        elseif button == 25  % Ctrl+Y (REDO)
            performRedo();
            
        elseif button == 13  % ENTER - Save and exit
            saveAndExit();
            
        elseif button == 27  % ESC - Cancel
            choice = questdlg('Exit editor?', 'Confirm Exit', ...
                'Save and Exit', 'Cancel and Discard', 'Continue Editing', 'Continue Editing');
            
            if strcmp(choice, 'Save and Exit')
                saveAndExit();
            elseif strcmp(choice, 'Cancel and Discard')
                app.binaryimage1 = originalImg;
                disp('Editing cancelled - original image restored');
                if ishandle(app.f)
                    close(app.f);
                end
                return;
            end
            
        elseif button == 43  % '+' key - Increase eraser
            currentVal = get(app.eraserSizeSlider, 'Value');
            newVal = min(currentVal + 2, 50);
            set(app.eraserSizeSlider, 'Value', newVal);
            updateEraserSize();
            
        elseif button == 45  % '-' key - Decrease eraser
            currentVal = get(app.eraserSizeSlider, 'Value');
            newVal = max(currentVal - 2, 1);
            set(app.eraserSizeSlider, 'Value', newVal);
            updateEraserSize();
        end
        
    catch ME
        disp(['Error: ', ME.message]);
        done = true;
    end
end

% ================= CLEANUP =================
if ishandle(app.f)
    close(app.f);
end
app.binaryimage1=imresize(app.binaryimage1,[512 512]);
% Display final image
imshow(app.binaryimage1, 'Parent', app.UIAxes2);
drawnow;

% Success message
msg = msgbox('Clean image saved!', 'Success', 'help');
pause(1);
if ishandle(msg)
    close(msg);
end

        end

        % Callback function
        function Slider2ValueChanged(app, event)
            value = app.Slider2.Value;
             radius = max(1, round(value));  % Ensure radius ≥ 1
    
    % Store original image
    if isempty(app.OriginalBinaryImage)
        app.OriginalBinaryImage = app.binaryimage1;
    end
    
    % Apply morphological closing
    if radius > 0
        % Create disk-shaped structuring element
        se = strel('disk', radius);
        
        % Apply morphological closing
        app.binaryimage1 = imclose(app.OriginalBinaryImage, se);
    else
        % Reset to original
        app.binaryimage1 = app.OriginalBinaryImage;
    end
    
    % Display result
    imshow(app.binaryimage1, 'Parent', app.UIAxes2);
    
    % Update label if you have one
    if isprop(app, 'ClosingRadiusLabel')
        app.ClosingRadiusLabel.Text = ['Radius: ' num2str(radius)];
    end
        end

        % Callback function
        function Slider3ValueChanged(app, event)
            value = app.Slider3.Value;
             value = app.Slider2.Value;
             radius = max(1, round(value));  % Ensure radius ≥ 1
    
    % Store original image
    if isempty(app.OriginalBinaryImage)
        app.OriginalBinaryImage = app.binaryimage1;
    end
    
    % Apply morphological closing
    if radius > 0
        % Create disk-shaped structuring element
        se = strel('disk', radius);
        
        % Apply morphological closing
        app.binaryimage1 = imopen(app.OriginalBinaryImage, se);
    else
        % Reset to original
        app.binaryimage1 = app.OriginalBinaryImage;
    end
    
    % Display result
    imshow(app.binaryimage1, 'Parent', app.UIAxes2);
    
    % Update label if you have one
    if isprop(app, 'ClosingRadiusLabel')
        app.ClosingRadiusLabel.Text = ['Radius: ' num2str(radius)];
    end
        end

        % Callback function
        function ButtonPushed5(app, event)
           originalImg = app.binaryimage1;
baseImage = app.binaryimage1;  % Base image (eraser edits only)
workingImg = app.binaryimage1;  % Working copy with morphology

% Create figure with all controls - FULL SCREEN
screenSize = get(0, 'ScreenSize');  % Get screen size
f = figure('Name', 'Image Editor', 'Position', screenSize, ...
    'NumberTitle', 'off', 'MenuBar', 'none', 'ToolBar', 'none', ...
    'Color', [0.78 0.82 0.75]);  % Background color

% Display image - Adjusted for full screen
ax = axes('Parent', f, 'Position', [0.05 0.1 0.6 0.8]);
imshow(workingImg, 'Parent', ax);

% ==== ADD CONTROL PANEL - Adjusted for full screen ====
controlPanel = uipanel(f, 'Position', [0.68 0.1 0.3 0.8], ...
    'Title', 'Cleaning options', 'FontWeight', 'bold', 'FontSize', 14, ...
    'FontName', 'Verdana', 'BackgroundColor', [0.78 0.82 0.75], ...
    'ForegroundColor', [0.05 0.17 0.31]);

% Define common button styling
buttonBgColor = [0.05 0.17 0.31];  % Button background color
buttonTextColor = [1 1 1];         % White text
fontName = 'Verdana';
fontSize = 12;

% ==== FIXED: Use PURE normalized positions ====
% All positions are [left, bottom, width, height] in normalized units (0-1)
% within the control panel

% Calculate positions - all within [0,1] range
startY = 0.85;        % Start 85% from bottom of panel
spacing = 0.12;       % Spacing between groups
elementHeight = 0.08; % Height for text elements
sliderHeight = 0.05;  % Height for sliders
buttonHeight = 0.08;  % Height for buttons

% 1. ERASER CONTROLS
uicontrol(controlPanel, 'Style', 'text', ...
    'Units', 'normalized', 'Position', [0.1 startY 0.8 elementHeight], ...
    'String', 'ERASER SIZE', 'FontWeight', 'bold', 'FontSize', 14, ...
    'HorizontalAlignment', 'left', 'FontName', fontName, ...
    'ForegroundColor', [0.05 0.17 0.31], 'BackgroundColor', [0.78 0.82 0.75]);

% Eraser Size Slider
app.eraserSizeSlider = uicontrol(controlPanel, 'Style', 'slider', ...
    'Units', 'normalized', 'Position', [0.1 startY-0.07 0.8 sliderHeight], ...
    'Min', 1, 'Max', 50, 'Value', 15, ...
    'BackgroundColor', [0.88 0.92 0.88]);

app.eraserSizeText = uicontrol(controlPanel, 'Style', 'text', ...
    'Units', 'normalized', 'Position', [0.1 startY-0.12 0.8 elementHeight], ...
    'String', 'Size: 15 px', 'HorizontalAlignment', 'center', 'FontSize', fontSize, ...
    'FontName', fontName, 'ForegroundColor', [0.05 0.17 0.31], ...
    'BackgroundColor', [0.78 0.82 0.75]);

% 2. EROSION CONTROLS
erosionY = startY - spacing;

uicontrol(controlPanel, 'Style', 'text', ...
    'Units', 'normalized', 'Position', [0.1 erosionY 0.8 elementHeight], ...
    'String', 'EROSION', 'FontWeight', 'bold', 'FontSize', 14, ...
    'HorizontalAlignment', 'left', 'FontName', fontName, ...
    'ForegroundColor', [0.05 0.17 0.31], 'BackgroundColor', [0.78 0.82 0.75]);

app.erosionSlider = uicontrol(controlPanel, 'Style', 'slider', ...
    'Units', 'normalized', 'Position', [0.1 erosionY-0.07 0.8 sliderHeight], ...
    'Min', 0, 'Max', 10, 'Value', 0, ...
    'BackgroundColor', [0.88 0.92 0.88]);

app.erosionText = uicontrol(controlPanel, 'Style', 'text', ...
    'Units', 'normalized', 'Position', [0.1 erosionY-0.12 0.8 elementHeight], ...
    'String', 'Erosion: 0 px', 'HorizontalAlignment', 'center', 'FontSize', fontSize, ...
    'FontName', fontName, 'ForegroundColor', [0.05 0.17 0.31], ...
    'BackgroundColor', [0.78 0.82 0.75]);

% 3. DILATION CONTROLS
dilationY = erosionY - spacing;

uicontrol(controlPanel, 'Style', 'text', ...
    'Units', 'normalized', 'Position', [0.1 dilationY 0.8 elementHeight], ...
    'String', 'DILATION', 'FontWeight', 'bold', 'FontSize', 14, ...
    'HorizontalAlignment', 'left', 'FontName', fontName, ...
    'ForegroundColor', [0.05 0.17 0.31], 'BackgroundColor', [0.78 0.82 0.75]);

app.dilationSlider = uicontrol(controlPanel, 'Style', 'slider', ...
    'Units', 'normalized', 'Position', [0.1 dilationY-0.07 0.8 sliderHeight], ...
    'Min', 0, 'Max', 10, 'Value', 0, ...
    'BackgroundColor', [0.88 0.92 0.88]);

app.dilationText = uicontrol(controlPanel, 'Style', 'text', ...
    'Units', 'normalized', 'Position', [0.1 dilationY-0.12 0.8 elementHeight], ...
    'String', 'Dilation: 0 px', 'HorizontalAlignment', 'center', 'FontSize', fontSize, ...
    'FontName', fontName, 'ForegroundColor', [0.05 0.17 0.31], ...
    'BackgroundColor', [0.78 0.82 0.75]);

% 4. UNDO/REDO BUTTONS - Fixed position
undoRedoY = dilationY - spacing;

undoBtn = uicontrol(controlPanel, 'Style', 'pushbutton', ...
    'Units', 'normalized', 'Position', [0.1 0.2 0.25 buttonHeight], ...
    'String', 'UNDO', 'BackgroundColor', buttonBgColor, 'ForegroundColor', buttonTextColor, ...
    'FontSize', fontSize, 'FontName', fontName, 'FontWeight', 'bold');

redoBtn = uicontrol(controlPanel, 'Style', 'pushbutton', ...
    'Units', 'normalized', 'Position', [0.4 0.2 0.25 buttonHeight], ...
    'String', 'REDO', 'BackgroundColor', buttonBgColor, 'ForegroundColor', buttonTextColor, ...
    'FontSize', fontSize, 'FontName', fontName, 'FontWeight', 'bold');

% 5. SAVE BUTTON - Positioned at the bottom
saveBtn = uicontrol(controlPanel, 'Style', 'pushbutton', ...
    'Units', 'normalized', 'Position', [0.1 0.1 0.55 buttonHeight*1], ...
    'String', sprintf('SAVE & EXIT'), 'FontWeight', 'bold', 'FontSize', 16, ...
    'FontName', fontName, 'BackgroundColor', buttonBgColor, 'ForegroundColor', buttonTextColor);

% ==== REST OF YOUR CODE CONTINUES HERE ====
% [Copy all the rest of your code from the original, starting with:]
% ==== INITIALIZE VARIABLES ====
clickCount = 0;
done = false;
currentEraserSize = 15;

% Create UNDO/REDO stacks
undoStack = {};
undoStack{1} = baseImage;
currentIndex = 1;
maxUndos = 20;  % Limit undo history

% ==== HELPER FUNCTIONS ====
function updateEraserSize()
    currentEraserSize = round(get(app.eraserSizeSlider, 'Value'));
    set(app.eraserSizeText, 'String', sprintf('Size: %d px', currentEraserSize));
end

function saveState()
    % Save current state to undo stack
    if length(undoStack) >= maxUndos
        undoStack = undoStack(2:end);  % Remove oldest
        currentIndex = currentIndex - 1;
    end
    
    % Add new state
    undoStack{end+1} = baseImage;
    currentIndex = length(undoStack);
end

function performUndo()
    if currentIndex > 1
        currentIndex = currentIndex - 1;
        baseImage = undoStack{currentIndex};
        
        % Re-apply current morphology
        applyMorphology();
        
        disp('Undo: Reverted last eraser action');
    else
        disp('Cannot undo further');
    end
end

function performRedo()
    if currentIndex < length(undoStack)
        currentIndex = currentIndex + 1;
        baseImage = undoStack{currentIndex};
        
        % Re-apply current morphology
        applyMorphology();
        
        disp('Redo: Restored next eraser action');
    else
        disp('Cannot redo further');
    end
end

function applyMorphology()
    % Get current slider values
    erosionVal = round(get(app.erosionSlider, 'Value'));
    dilationVal = round(get(app.dilationSlider, 'Value'));
    
    % Update display texts
    set(app.erosionText, 'String', sprintf('Erosion: %d px', erosionVal));
    set(app.dilationText, 'String', sprintf('Dilation: %d px', dilationVal));
    
    % Start from base image
    tempImg = baseImage;
    
    % Apply erosion if needed
    if erosionVal > 0
        se = strel('disk', erosionVal);
        tempImg = imerode(tempImg, se);
    end
    
    % Apply dilation if needed
    if dilationVal > 0
        se = strel('disk', dilationVal);
        tempImg = imdilate(tempImg, se);
    end
    
    % Update working image and display
    workingImg = tempImg;
    imshow(workingImg, 'Parent', ax);
end

function saveAndExit()
    % Save final image to app variable
    app.binaryimage1 = workingImg;
    done = true;
end

% ==== SETUP CALLBACKS ====
% Eraser size slider
set(app.eraserSizeSlider, 'Callback', @(~,~) updateEraserSize());

% Morphology sliders
set(app.erosionSlider, 'Callback', @(~,~) applyMorphology());
set(app.dilationSlider, 'Callback', @(~,~) applyMorphology());

% Undo/Redo buttons
set(undoBtn, 'Callback', @(~,~) performUndo());
set(redoBtn, 'Callback', @(~,~) performRedo());

% Save button
set(saveBtn, 'Callback', @(~,~) saveAndExit());

% ==== MAIN EDITING LOOP ====
while ~done && ishandle(f)
    try
        [x, y, button] = ginput(1);
        
        if button == 1  % Left mouse click - ERASE
            x = round(x);
            y = round(y);
            
            % Get image size
            [h, w] = size(baseImage);
            
            % Check if click is within image bounds
            if x >= 1 && x <= w && y >= 1 && y <= h
                % Save current state before editing
                saveState();
                
                clickCount = clickCount + 1;
                
                % Get current eraser size
                currentEraserSize = round(get(app.eraserSizeSlider, 'Value'));
                halfSize = floor(currentEraserSize/2);
                
                % Check color at clicked point
                clickedColor = baseImage(y, x);
                
                % Calculate eraser bounds
                x1 = max(1, x - halfSize);
                x2 = min(w, x + halfSize);
                y1 = max(1, y - halfSize);
                y2 = min(h, y + halfSize);
                
                % Apply eraser to BASE image
                if clickedColor == 1  % WHITE
                    baseImage(y1:y2, x1:x2) = false;
                else  % BLACK
                    baseImage(y1:y2, x1:x2) = true;
                end
                
                % Re-apply current morphology
                applyMorphology();
                
                % Visual feedback
                rectangle('Position', [x1, y1, x2-x1, y2-y1], ...
                    'EdgeColor', clickedColor*[1 1 1], ...
                    'LineWidth', 1.5, 'LineStyle', '--');
                pause(0.08);
                imshow(workingImg, 'Parent', ax);
            end
            
        elseif button == 26  % Ctrl+Z (UNDO)
            performUndo();
            
        elseif button == 25  % Ctrl+Y (REDO) - ASCII 25
            performRedo();
            
        elseif button == 13  % ENTER key - Save and exit
            saveAndExit();
            
        elseif button == 27  % ESC key - Cancel
            choice = questdlg('Exit editor?', 'Confirm Exit', ...
                'Save and Exit', 'Cancel and Discard', 'Continue Editing', 'Continue Editing');
            if strcmp(choice, 'Save and Exit')
                saveAndExit();
            elseif strcmp(choice, 'Cancel and Discard')
                app.binaryimage1 = originalImg;
                disp('Editing cancelled - original image restored');
                if ishandle(app.f)
                    close(app.f);
                end
                return;
            end
            
        elseif button == 43  % '+' key - Increase eraser
            currentVal = get(app.eraserSizeSlider, 'Value');
            newVal = min(currentVal + 2, 50);
            set(app.eraserSizeSlider, 'Value', newVal);
            updateEraserSize();
            
        elseif button == 45  % '-' key - Decrease eraser
            currentVal = get(app.eraserSizeSlider, 'Value');
            newVal = max(currentVal - 2, 1);
            set(app.eraserSizeSlider, 'Value', newVal);
            updateEraserSize();
            
        end
        
    catch
        done = true;
    end
end

% ==== FINAL CLEANUP ====
if ishandle(app.f)
    close(app.f);
end

% Display cleaned image in app

% Show styled message
msg = msgbox('clean image saved', 'Success', 'help');
set(findobj(msg, 'Type', 'Text'), 'FontName', 'Verdana', 'FontSize', 10);
pause(1);
if ishandle(msg)
    close(msg);
end
imshow(app.binaryimage1, 'Parent', app.UIAxes2);
drawnow;  % Force immediate update
        end

        % Callback function
        function ButtonPushed6(app, event)
           % Get original binary image
originalImage = app.binaryimage1;
[height, width] = size(originalImage);

% Initialize padded image as original
app.paddedImage = originalImage;

% Select ROI type
switch app.SelectROIDropDown.Value
    case 'Black'
        % Black region = 0
        regionMask  = (originalImage == 0);
        paddingColor = 0;

    case 'White'
        % White region = 1
        regionMask  = (originalImage == 1);
        paddingColor = 1;

    otherwise
        disp('No valid ROI selected.');
        imshow(originalImage);
        return;
end

% Find rows containing region pixels (ROBUST for diagonal shapes)
regionPixelRows = find(any(regionMask, 2));

% If no region found
if isempty(regionPixelRows)
    disp(['No ' app.SelectROIDropDown.Value ' pixels found in the image.']);
    imshow(originalImage);
    return;
end

% Find top and bottom rows of region
topRow    = min(regionPixelRows);
bottomRow = max(regionPixelRows);

% Padding size
paddingSize = 5;

% Add padding ABOVE the region
startRow = max(1, topRow - paddingSize);
app.paddedImage(startRow:topRow-1, :) = paddingColor;

% Add padding BELOW the region
endRow = min(height, bottomRow + paddingSize);
app.paddedImage(bottomRow+1:endRow, :) = paddingColor;

% Display result
imshow(app.paddedImage);
        end

        % Callback function
        function ButtonPushed7(app, event)
% ================= INITIAL SETUP =================
app.binaryimage1=imresize(app.binaryimage1,[1024 1024]);
originalImg = app.binaryimage1 > 0;   % FORCE LOGICAL
baseImage   = originalImg;            
workingImg  = originalImg;            

% Create fullscreen figure
screenSize = get(0,'ScreenSize');
f = figure('Name','Image Editor','Position',screenSize,...
    'NumberTitle','off','MenuBar','none','ToolBar','none',...
    'Color',[0.78 0.82 0.75]);

ax = axes('Parent',f,'Position',[0.05 0.1 0.6 0.8]);
imshow(workingImg,'Parent',ax);

% ================= CONTROL PANEL =================
controlPanel = uipanel(f,'Position',[0.68 0.1 0.3 0.8],...
    'Title','Cleaning options','FontWeight','bold','FontSize',14,...
    'FontName','Verdana','BackgroundColor',[0.78 0.82 0.75],...
    'ForegroundColor',[0.05 0.17 0.31]);

% Define common button styling
buttonBgColor = [0.05 0.17 0.31];
buttonTextColor = [1 1 1];
fontName = 'Verdana';
fontSize = 12;

% Calculate positions
startY = 600;

% PIXEL COUNT DISPLAY with percentages (MOVED TO TOP)
app.pixelCountText = uicontrol(controlPanel, 'Style', 'text', ...
    'Position', [30 startY-60 220 60], 'String', 'White: 0 (0%)   Black: 0 (0%)   Total: 0', ...
    'HorizontalAlignment', 'center', 'FontSize', 11, ...
    'FontName', fontName, 'ForegroundColor', [0.05 0.17 0.31], ...
    'BackgroundColor', [0.78 0.82 0.75], 'FontWeight', 'bold');

% 1. ERASER CONTROLS
uicontrol(controlPanel, 'Style', 'text', 'Position', [30 startY-140 220 35], ...
    'String', 'ERASER SIZE', 'FontWeight', 'bold', 'FontSize', 14, ...
    'HorizontalAlignment', 'left', 'FontName', fontName, ...
    'ForegroundColor', [0.05 0.17 0.31], 'BackgroundColor', [0.78 0.82 0.75]);

app.eraserSizeSlider = uicontrol(controlPanel, 'Style', 'slider', ...
    'Position', [30 startY-160 220 30], 'Min', 1, 'Max', 50, 'Value', 15, ...
    'BackgroundColor', [0.88 0.92 0.88]);

app.eraserSizeText = uicontrol(controlPanel, 'Style', 'text', ...
    'Position', [30 startY-180 220 30], 'String', 'Size: 15 px', ...
    'HorizontalAlignment', 'center', 'FontSize', fontSize, ...
    'FontName', fontName, 'ForegroundColor', [0.05 0.17 0.31], ...
    'BackgroundColor', [0.78 0.82 0.75]);

% 2. EROSION CONTROLS
uicontrol(controlPanel, 'Style', 'text', 'Position', [30 startY-240 220 35], ...
    'String', 'EROSION', 'FontWeight', 'bold', 'FontSize', 14, ...
    'HorizontalAlignment', 'left', 'FontName', fontName, ...
    'ForegroundColor', [0.05 0.17 0.31], 'BackgroundColor', [0.78 0.82 0.75]);

app.erosionSlider = uicontrol(controlPanel, 'Style', 'slider', ...
    'Position', [30 startY-260 220 30], 'Min', 0, 'Max', 10, 'Value', 0, ...
    'BackgroundColor', [0.88 0.92 0.88]);

app.erosionText = uicontrol(controlPanel, 'Style', 'text', ...
    'Position', [30 startY-280 220 30], 'String', 'Erosion: 0 px', ...
    'HorizontalAlignment', 'center', 'FontSize', fontSize, ...
    'FontName', fontName, 'ForegroundColor', [0.05 0.17 0.31], ...
    'BackgroundColor', [0.78 0.82 0.75]);

% 3. DILATION CONTROLS
uicontrol(controlPanel, 'Style', 'text', 'Position', [30 startY-340 220 35], ...
    'String', 'DILATION', 'FontWeight', 'bold', 'FontSize', 14, ...
    'HorizontalAlignment', 'left', 'FontName', fontName, ...
    'ForegroundColor', [0.05 0.17 0.31], 'BackgroundColor', [0.78 0.82 0.75]);

app.dilationSlider = uicontrol(controlPanel, 'Style', 'slider', ...
    'Position', [30 startY-360 220 30], 'Min', 0, 'Max', 10, 'Value', 0, ...
    'BackgroundColor', [0.88 0.92 0.88]);

app.dilationText = uicontrol(controlPanel, 'Style', 'text', ...
    'Position', [30 startY-380 220 30], 'String', 'Dilation: 0 px', ...
    'HorizontalAlignment', 'center', 'FontSize', fontSize, ...
    'FontName', fontName, 'ForegroundColor', [0.05 0.17 0.31], ...
    'BackgroundColor', [0.78 0.82 0.75]);

% UNDO/REDO BUTTONS
undoBtn = uicontrol(controlPanel, 'Style', 'pushbutton', ...
    'Position', [30 startY-460 100 45], 'String', 'UNDO', ...
    'BackgroundColor', buttonBgColor, 'ForegroundColor', buttonTextColor, ...
    'FontSize', fontSize, 'FontName', fontName, 'FontWeight', 'bold');

redoBtn = uicontrol(controlPanel, 'Style', 'pushbutton', ...
    'Position', [150 startY-460 100 45], 'String', 'REDO', ...
    'BackgroundColor', buttonBgColor, 'ForegroundColor', buttonTextColor, ...
    'FontSize', fontSize, 'FontName', fontName, 'FontWeight', 'bold');

% SAVE BUTTON
saveBtn = uicontrol(controlPanel, 'Style', 'pushbutton', ...
    'Position', [30 startY-540 220 70], 'String', 'SAVE & EXIT', ...
    'FontWeight', 'bold', 'FontSize', 16, 'FontName', fontName, ...
    'BackgroundColor', buttonBgColor, 'ForegroundColor', buttonTextColor);

% ================= INITIALIZE VARIABLES =================
clickCount = 0;
done = false;
currentEraserSize = 15;

% Create UNDO/REDO stacks
undoStack = {};
undoStack{1} = baseImage;
currentIndex = 1;
maxUndos = 20;

% ================= HELPER FUNCTIONS =================
function updateEraserSize()
    currentEraserSize = round(get(app.eraserSizeSlider, 'Value'));
    set(app.eraserSizeText, 'String', sprintf('Size: %d px', currentEraserSize));
end

function saveState()
    % Save current state to undo stack
    if length(undoStack) >= maxUndos
        undoStack = undoStack(2:end);
        currentIndex = currentIndex - 1;
    end
    
    undoStack{end+1} = baseImage;
    currentIndex = length(undoStack);
end

function performUndo()
    if currentIndex > 1
        currentIndex = currentIndex - 1;
        baseImage = undoStack{currentIndex};
        updateDisplay();
        disp('Undo: Reverted last eraser action');
    else
        disp('Cannot undo further');
    end
end

function performRedo()
    if currentIndex < length(undoStack)
        currentIndex = currentIndex + 1;
        baseImage = undoStack{currentIndex};
        updateDisplay();
        disp('Redo: Restored next eraser action');
    else
        disp('Cannot redo further');
    end
end

function updateDisplay()
    % Get current slider values
    erosionVal = round(get(app.erosionSlider, 'Value'));
    dilationVal = round(get(app.dilationSlider, 'Value'));
    
    % Update display texts
    set(app.erosionText, 'String', sprintf('Erosion: %d px', erosionVal));
    set(app.dilationText, 'String', sprintf('Dilation: %d px', dilationVal));
    
    % Start from base image
    tempImg = baseImage;
    
    % Apply morphology
    if erosionVal > 0
        tempImg = imerode(tempImg, strel('disk', erosionVal));
    end
    
    if dilationVal > 0
        tempImg = imdilate(tempImg, strel('disk', dilationVal));
    end
    
    % Update working image and display
    workingImg = tempImg;
    imshow(workingImg, 'Parent', ax);
    
    % Calculate pixel counts and percentages
    totalPixels = numel(workingImg);
    whitePixels = sum(workingImg(:));
    blackPixels = totalPixels - whitePixels;
    
    whitePercent = (whitePixels / totalPixels) * 100;
    blackPercent = (blackPixels / totalPixels) * 100;
    
    % Update pixel count display (now at top)
    set(app.pixelCountText, 'String', ...
        sprintf('White: %d (%.1f%%)   Black: %d (%.1f%%)   Total: %d', ...
        whitePixels, whitePercent, blackPixels, blackPercent, totalPixels));
end

function saveAndExit()
    app.binaryimage1 = workingImg;
    done = true;
end

% ================= SETUP CALLBACKS =================
set(app.eraserSizeSlider, 'Callback', @(~,~) updateEraserSize());
set(app.erosionSlider, 'Callback', @(~,~) updateDisplay());
set(app.dilationSlider, 'Callback', @(~,~) updateDisplay());
set(undoBtn, 'Callback', @(~,~) performUndo());
set(redoBtn, 'Callback', @(~,~) performRedo());
set(saveBtn, 'Callback', @(~,~) saveAndExit());

% Initial display update
updateDisplay();

% ================= MAIN LOOP =================
while ~done && ishandle(f)
    try
        [x, y, button] = ginput(1);
        
        if isempty(button)
            continue;
        end
        
        if button == 1  % LEFT CLICK - ERASER
            x = round(x);
            y = round(y);
            
            [h, w] = size(baseImage);
            
            if x >= 1 && x <= w && y >= 1 && y <= h
                % Save state before editing
                saveState();
                
                clickCount = clickCount + 1;
                
                % Get eraser size
                eraserSize = round(get(app.eraserSizeSlider, 'Value'));
                halfSize = floor(eraserSize/2);
                
                % Calculate eraser bounds
                x1 = max(1, x - halfSize);
                x2 = min(w, x + halfSize);
                y1 = max(1, y - halfSize);
                y2 = min(h, y + halfSize);
                
                % SIMPLE AND EFFECTIVE ERASER LOGIC - BIT INVERSION
                baseImage(y1:y2, x1:x2) = ~baseImage(y1:y2, x1:x2);
                
                % Update display
                updateDisplay();
                
                % Visual feedback
                rectangle('Position', [x1, y1, x2-x1, y2-y1], ...
                    'EdgeColor', 'r', 'LineWidth', 1.5, 'LineStyle', '--');
                pause(0.1);
                imshow(workingImg, 'Parent', ax);
            end
            
        elseif button == 26  % Ctrl+Z (UNDO)
            performUndo();
            
        elseif button == 25  % Ctrl+Y (REDO)
            performRedo();
            
        elseif button == 13  % ENTER - Save and exit
            saveAndExit();
            
        elseif button == 27  % ESC - Cancel
            choice = questdlg('Exit editor?', 'Confirm Exit', ...
                'Save and Exit', 'Cancel and Discard', 'Continue Editing', 'Continue Editing');
            
            if strcmp(choice, 'Save and Exit')
                saveAndExit();
            elseif strcmp(choice, 'Cancel and Discard')
                app.binaryimage1 = originalImg;
                disp('Editing cancelled - original image restored');
                if ishandle(app.f)
                    close(app.f);
                end
                return;
            end
            
        elseif button == 43  % '+' key - Increase eraser
            currentVal = get(app.eraserSizeSlider, 'Value');
            newVal = min(currentVal + 2, 50);
            set(app.eraserSizeSlider, 'Value', newVal);
            updateEraserSize();
            
        elseif button == 45  % '-' key - Decrease eraser
            currentVal = get(app.eraserSizeSlider, 'Value');
            newVal = max(currentVal - 2, 1);
            set(app.eraserSizeSlider, 'Value', newVal);
            updateEraserSize();
        end
        
    catch ME
        disp(['Error: ', ME.message]);
        done = true;
    end
end

% ================= CLEANUP =================
if ishandle(app.f)
    close(app.f);
end
app.binaryimage1=imresize(app.binaryimage1,[512 512]);
% Display final image
imshow(app.binaryimage1, 'Parent', app.UIAxes2);
drawnow;

% Success message
msg = msgbox('Clean image saved!', 'Success', 'help');
pause(1);
if ishandle(msg)
    close(msg);
end

        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Get the file path for locating images
            pathToMLAPP = fileparts(mfilename('fullpath'));

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 1388 822];
            app.UIFigure.Name = 'MATLAB App';

            % Create GridLayout
            app.GridLayout = uigridlayout(app.UIFigure);
            app.GridLayout.ColumnWidth = {114, 100, 80, 100, 100, 114, 100, 100, 100, 114, 100, '1x'};
            app.GridLayout.RowHeight = {25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 30, 30, 30, 30, 31, 30, 30, 30, 30, 30};
            app.GridLayout.BackgroundColor = [0.7804 0.8196 0.749];

            % Create UIAxes2
            app.UIAxes2 = uiaxes(app.GridLayout);
            zlabel(app.UIAxes2, 'Z')
            app.UIAxes2.FontName = 'Verdana';
            app.UIAxes2.XTick = [];
            app.UIAxes2.YTick = [];
            app.UIAxes2.Layout.Row = [3 9];
            app.UIAxes2.Layout.Column = [8 11];
            app.UIAxes2.ButtonDownFcn = createCallbackFcn(app, @UIAxes2ButtonDown, true);

            % Create UIAxes
            app.UIAxes = uiaxes(app.GridLayout);
            zlabel(app.UIAxes, 'Z')
            app.UIAxes.FontName = 'Verdana';
            app.UIAxes.XTick = [];
            app.UIAxes.YTick = [];
            app.UIAxes.Layout.Row = [3 9];
            app.UIAxes.Layout.Column = [4 7];
            app.UIAxes.ButtonDownFcn = createCallbackFcn(app, @UIAxesButtonDown, true);

            % Create BrowseButton
            app.BrowseButton = uibutton(app.GridLayout, 'push');
            app.BrowseButton.ButtonPushedFcn = createCallbackFcn(app, @BrowseButtonPushed, true);
            app.BrowseButton.BackgroundColor = [0.0549 0.1725 0.3098];
            app.BrowseButton.FontName = 'Verdana';
            app.BrowseButton.FontSize = 14;
            app.BrowseButton.FontWeight = 'bold';
            app.BrowseButton.FontColor = [1 1 1];
            app.BrowseButton.Layout.Row = 1;
            app.BrowseButton.Layout.Column = [3 4];
            app.BrowseButton.Text = 'Browse ';

            % Create SetscaleButton
            app.SetscaleButton = uibutton(app.GridLayout, 'push');
            app.SetscaleButton.ButtonPushedFcn = createCallbackFcn(app, @SetscaleButtonPushed, true);
            app.SetscaleButton.BackgroundColor = [0.0549 0.1725 0.3098];
            app.SetscaleButton.FontName = 'Verdana';
            app.SetscaleButton.FontSize = 14;
            app.SetscaleButton.FontWeight = 'bold';
            app.SetscaleButton.FontColor = [1 1 1];
            app.SetscaleButton.Layout.Row = 3;
            app.SetscaleButton.Layout.Column = [1 2];
            app.SetscaleButton.Text = 'Set scale';

            % Create ResetButton
            app.ResetButton = uibutton(app.GridLayout, 'push');
            app.ResetButton.ButtonPushedFcn = createCallbackFcn(app, @ResetButtonPushed, true);
            app.ResetButton.BackgroundColor = [0.0549 0.1725 0.3098];
            app.ResetButton.FontName = 'Verdana';
            app.ResetButton.FontSize = 14;
            app.ResetButton.FontWeight = 'bold';
            app.ResetButton.FontColor = [0.9412 0.9412 0.9412];
            app.ResetButton.Layout.Row = 16;
            app.ResetButton.Layout.Column = 1;
            app.ResetButton.Text = 'Reset';

            % Create PixelslengthEditFieldLabel
            app.PixelslengthEditFieldLabel = uilabel(app.GridLayout);
            app.PixelslengthEditFieldLabel.BackgroundColor = [0.1765 0.251 0.0431];
            app.PixelslengthEditFieldLabel.HorizontalAlignment = 'center';
            app.PixelslengthEditFieldLabel.FontName = 'Verdana';
            app.PixelslengthEditFieldLabel.FontSize = 14;
            app.PixelslengthEditFieldLabel.FontWeight = 'bold';
            app.PixelslengthEditFieldLabel.FontColor = [1 1 1];
            app.PixelslengthEditFieldLabel.Layout.Row = 4;
            app.PixelslengthEditFieldLabel.Layout.Column = [1 2];
            app.PixelslengthEditFieldLabel.Text = 'Pixels length ';

            % Create PixelslengthEditField
            app.PixelslengthEditField = uieditfield(app.GridLayout, 'numeric');
            app.PixelslengthEditField.ValueChangedFcn = createCallbackFcn(app, @PixelslengthEditFieldValueChanged, true);
            app.PixelslengthEditField.HorizontalAlignment = 'center';
            app.PixelslengthEditField.FontName = 'Verdana';
            app.PixelslengthEditField.FontSize = 14;
            app.PixelslengthEditField.FontWeight = 'bold';
            app.PixelslengthEditField.Layout.Row = 4;
            app.PixelslengthEditField.Layout.Column = 3;

            % Create PhysicallengthEditFieldLabel
            app.PhysicallengthEditFieldLabel = uilabel(app.GridLayout);
            app.PhysicallengthEditFieldLabel.BackgroundColor = [0.1765 0.251 0.0431];
            app.PhysicallengthEditFieldLabel.HorizontalAlignment = 'center';
            app.PhysicallengthEditFieldLabel.FontName = 'Verdana';
            app.PhysicallengthEditFieldLabel.FontSize = 14;
            app.PhysicallengthEditFieldLabel.FontWeight = 'bold';
            app.PhysicallengthEditFieldLabel.FontColor = [1 1 1];
            app.PhysicallengthEditFieldLabel.Layout.Row = 5;
            app.PhysicallengthEditFieldLabel.Layout.Column = [1 2];
            app.PhysicallengthEditFieldLabel.Text = 'Physical length';

            % Create PhysicallengthEditField
            app.PhysicallengthEditField = uieditfield(app.GridLayout, 'numeric');
            app.PhysicallengthEditField.ValueChangedFcn = createCallbackFcn(app, @PhysicallengthEditFieldValueChanged, true);
            app.PhysicallengthEditField.HorizontalAlignment = 'center';
            app.PhysicallengthEditField.FontName = 'Verdana';
            app.PhysicallengthEditField.FontSize = 14;
            app.PhysicallengthEditField.FontWeight = 'bold';
            app.PhysicallengthEditField.Layout.Row = 5;
            app.PhysicallengthEditField.Layout.Column = 3;

            % Create EnterButton
            app.EnterButton = uibutton(app.GridLayout, 'push');
            app.EnterButton.ButtonPushedFcn = createCallbackFcn(app, @EnterButtonPushed, true);
            app.EnterButton.BackgroundColor = [0.0549 0.1725 0.3098];
            app.EnterButton.FontName = 'Verdana';
            app.EnterButton.FontSize = 14;
            app.EnterButton.FontWeight = 'bold';
            app.EnterButton.FontColor = [0.9412 0.9412 0.9412];
            app.EnterButton.Layout.Row = 7;
            app.EnterButton.Layout.Column = [1 2];
            app.EnterButton.Text = 'Enter';

            % Create EditField11
            app.EditField11 = uieditfield(app.GridLayout, 'numeric');
            app.EditField11.ValueChangedFcn = createCallbackFcn(app, @EditField11ValueChanged, true);
            app.EditField11.HorizontalAlignment = 'center';
            app.EditField11.FontName = 'Verdana';
            app.EditField11.FontSize = 14;
            app.EditField11.FontWeight = 'bold';
            app.EditField11.Layout.Row = 7;
            app.EditField11.Layout.Column = 3;

            % Create MaterialpropertiesLabel
            app.MaterialpropertiesLabel = uilabel(app.GridLayout);
            app.MaterialpropertiesLabel.BackgroundColor = [0.2392 0 0.0588];
            app.MaterialpropertiesLabel.HorizontalAlignment = 'center';
            app.MaterialpropertiesLabel.FontName = 'Verdana';
            app.MaterialpropertiesLabel.FontSize = 14;
            app.MaterialpropertiesLabel.FontWeight = 'bold';
            app.MaterialpropertiesLabel.FontColor = [1 1 1];
            app.MaterialpropertiesLabel.Layout.Row = 9;
            app.MaterialpropertiesLabel.Layout.Column = [1 3];
            app.MaterialpropertiesLabel.Text = 'Material properties';

            % Create CloseallButton
            app.CloseallButton = uibutton(app.GridLayout, 'push');
            app.CloseallButton.ButtonPushedFcn = createCallbackFcn(app, @CloseallButtonPushed, true);
            app.CloseallButton.BackgroundColor = [0.0549 0.1725 0.3098];
            app.CloseallButton.FontName = 'Verdana';
            app.CloseallButton.FontSize = 14;
            app.CloseallButton.FontWeight = 'bold';
            app.CloseallButton.FontColor = [0.9412 0.9412 0.9412];
            app.CloseallButton.Layout.Row = 16;
            app.CloseallButton.Layout.Column = 3;
            app.CloseallButton.Text = 'Close all';

            % Create CompressionButton
            app.CompressionButton = uibutton(app.GridLayout, 'push');
            app.CompressionButton.ButtonPushedFcn = createCallbackFcn(app, @CompressionButtonPushed2, true);
            app.CompressionButton.BackgroundColor = [0.051 0.1686 0.3098];
            app.CompressionButton.FontName = 'Verdana';
            app.CompressionButton.FontSize = 14;
            app.CompressionButton.FontWeight = 'bold';
            app.CompressionButton.FontColor = [0.9412 0.9412 0.9412];
            app.CompressionButton.Layout.Row = 10;
            app.CompressionButton.Layout.Column = [6 7];
            app.CompressionButton.Text = 'Compression';

            % Create YdisplacementLabel
            app.YdisplacementLabel = uilabel(app.GridLayout);
            app.YdisplacementLabel.BackgroundColor = [0.1765 0.251 0.0431];
            app.YdisplacementLabel.HorizontalAlignment = 'center';
            app.YdisplacementLabel.FontName = 'Verdana';
            app.YdisplacementLabel.FontSize = 14;
            app.YdisplacementLabel.FontWeight = 'bold';
            app.YdisplacementLabel.FontColor = [1 1 1];
            app.YdisplacementLabel.Layout.Row = 13;
            app.YdisplacementLabel.Layout.Column = [1 2];
            app.YdisplacementLabel.Text = 'Y-displacement(%)';

            % Create YdisplacementEditField
            app.YdisplacementEditField = uieditfield(app.GridLayout, 'numeric');
            app.YdisplacementEditField.ValueChangedFcn = createCallbackFcn(app, @YdisplacementEditFieldValueChanged, true);
            app.YdisplacementEditField.HorizontalAlignment = 'center';
            app.YdisplacementEditField.FontName = 'Verdana';
            app.YdisplacementEditField.FontSize = 14;
            app.YdisplacementEditField.FontWeight = 'bold';
            app.YdisplacementEditField.Layout.Row = 13;
            app.YdisplacementEditField.Layout.Column = 3;

            % Create EditField
            app.EditField = uieditfield(app.GridLayout, 'text');
            app.EditField.ValueChangedFcn = createCallbackFcn(app, @EditFieldValueChanged, true);
            app.EditField.FontName = 'Verdana';
            app.EditField.FontSize = 14;
            app.EditField.FontWeight = 'bold';
            app.EditField.Layout.Row = 12;
            app.EditField.Layout.Column = [8 11];

            % Create YoungsmodulusEditFieldLabel
            app.YoungsmodulusEditFieldLabel = uilabel(app.GridLayout);
            app.YoungsmodulusEditFieldLabel.BackgroundColor = [0.1765 0.251 0.0431];
            app.YoungsmodulusEditFieldLabel.HorizontalAlignment = 'center';
            app.YoungsmodulusEditFieldLabel.FontName = 'Verdana';
            app.YoungsmodulusEditFieldLabel.FontSize = 14;
            app.YoungsmodulusEditFieldLabel.FontWeight = 'bold';
            app.YoungsmodulusEditFieldLabel.FontColor = [1 1 1];
            app.YoungsmodulusEditFieldLabel.Layout.Row = 10;
            app.YoungsmodulusEditFieldLabel.Layout.Column = [1 2];
            app.YoungsmodulusEditFieldLabel.Text = 'Young''s modulus';

            % Create YoungsmodulusEditField
            app.YoungsmodulusEditField = uieditfield(app.GridLayout, 'numeric');
            app.YoungsmodulusEditField.ValueChangedFcn = createCallbackFcn(app, @YoungsmodulusEditFieldValueChanged, true);
            app.YoungsmodulusEditField.HorizontalAlignment = 'center';
            app.YoungsmodulusEditField.FontName = 'Verdana';
            app.YoungsmodulusEditField.FontSize = 14;
            app.YoungsmodulusEditField.FontWeight = 'bold';
            app.YoungsmodulusEditField.Layout.Row = 10;
            app.YoungsmodulusEditField.Layout.Column = 3;

            % Create XDisplacementButton
            app.XDisplacementButton = uibutton(app.GridLayout, 'push');
            app.XDisplacementButton.ButtonPushedFcn = createCallbackFcn(app, @XDisplacementButtonPushed, true);
            app.XDisplacementButton.BackgroundColor = [0.0549 0.1725 0.3098];
            app.XDisplacementButton.FontName = 'Verdana';
            app.XDisplacementButton.FontSize = 14;
            app.XDisplacementButton.FontWeight = 'bold';
            app.XDisplacementButton.FontColor = [0.9412 0.9412 0.9412];
            app.XDisplacementButton.Layout.Row = 15;
            app.XDisplacementButton.Layout.Column = [4 5];
            app.XDisplacementButton.Text = 'X-Displacement';

            % Create YDisplacementButton
            app.YDisplacementButton = uibutton(app.GridLayout, 'push');
            app.YDisplacementButton.ButtonPushedFcn = createCallbackFcn(app, @YDisplacementButtonPushed, true);
            app.YDisplacementButton.BackgroundColor = [0.0549 0.1725 0.3098];
            app.YDisplacementButton.FontName = 'Verdana';
            app.YDisplacementButton.FontSize = 14;
            app.YDisplacementButton.FontWeight = 'bold';
            app.YDisplacementButton.FontColor = [0.9412 0.9412 0.9412];
            app.YDisplacementButton.Layout.Row = 15;
            app.YDisplacementButton.Layout.Column = [6 7];
            app.YDisplacementButton.Text = 'Y-Displacement';

            % Create vonMisesstressButton
            app.vonMisesstressButton = uibutton(app.GridLayout, 'push');
            app.vonMisesstressButton.ButtonPushedFcn = createCallbackFcn(app, @vonMisesstressButtonPushed, true);
            app.vonMisesstressButton.BackgroundColor = [0.0549 0.1725 0.3098];
            app.vonMisesstressButton.FontName = 'Verdana';
            app.vonMisesstressButton.FontSize = 14;
            app.vonMisesstressButton.FontWeight = 'bold';
            app.vonMisesstressButton.FontColor = [0.9412 0.9412 0.9412];
            app.vonMisesstressButton.Layout.Row = 14;
            app.vonMisesstressButton.Layout.Column = [4 5];
            app.vonMisesstressButton.Text = 'von Mises stress';

            % Create ShearstressButton
            app.ShearstressButton = uibutton(app.GridLayout, 'push');
            app.ShearstressButton.ButtonPushedFcn = createCallbackFcn(app, @ShearstressButtonPushed, true);
            app.ShearstressButton.BackgroundColor = [0.0549 0.1725 0.3098];
            app.ShearstressButton.FontName = 'Verdana';
            app.ShearstressButton.FontSize = 14;
            app.ShearstressButton.FontWeight = 'bold';
            app.ShearstressButton.FontColor = [0.9412 0.9412 0.9412];
            app.ShearstressButton.Layout.Row = 14;
            app.ShearstressButton.Layout.Column = [6 7];
            app.ShearstressButton.Text = 'Shear stress';

            % Create SetunitDropDownLabel
            app.SetunitDropDownLabel = uilabel(app.GridLayout);
            app.SetunitDropDownLabel.BackgroundColor = [0.1765 0.251 0.0431];
            app.SetunitDropDownLabel.HorizontalAlignment = 'center';
            app.SetunitDropDownLabel.FontName = 'Verdana';
            app.SetunitDropDownLabel.FontSize = 14;
            app.SetunitDropDownLabel.FontWeight = 'bold';
            app.SetunitDropDownLabel.FontColor = [1 1 1];
            app.SetunitDropDownLabel.Layout.Row = 6;
            app.SetunitDropDownLabel.Layout.Column = [1 2];
            app.SetunitDropDownLabel.Text = 'Set unit';

            % Create SetunitDropDown
            app.SetunitDropDown = uidropdown(app.GridLayout);
            app.SetunitDropDown.Items = {'µm', 'mm', 'cm', 'inch'};
            app.SetunitDropDown.ValueChangedFcn = createCallbackFcn(app, @SetunitDropDownValueChanged, true);
            app.SetunitDropDown.FontName = 'Verdana';
            app.SetunitDropDown.FontSize = 14;
            app.SetunitDropDown.FontWeight = 'bold';
            app.SetunitDropDown.Layout.Row = 6;
            app.SetunitDropDown.Layout.Column = 3;
            app.SetunitDropDown.Value = 'µm';

            % Create StressstrainplotButton
            app.StressstrainplotButton = uibutton(app.GridLayout, 'push');
            app.StressstrainplotButton.ButtonPushedFcn = createCallbackFcn(app, @StressstrainplotButtonPushed, true);
            app.StressstrainplotButton.BackgroundColor = [0.0549 0.1725 0.3098];
            app.StressstrainplotButton.FontName = 'Verdana';
            app.StressstrainplotButton.FontSize = 14;
            app.StressstrainplotButton.FontWeight = 'bold';
            app.StressstrainplotButton.FontColor = [0.9412 0.9412 0.9412];
            app.StressstrainplotButton.Layout.Row = 17;
            app.StressstrainplotButton.Layout.Column = [4 5];
            app.StressstrainplotButton.Text = 'Stress-strain plot';

            % Create NormalstressXButton
            app.NormalstressXButton = uibutton(app.GridLayout, 'push');
            app.NormalstressXButton.ButtonPushedFcn = createCallbackFcn(app, @NormalstressXButtonPushed, true);
            app.NormalstressXButton.BackgroundColor = [0.0549 0.1725 0.3098];
            app.NormalstressXButton.FontName = 'Verdana';
            app.NormalstressXButton.FontSize = 14;
            app.NormalstressXButton.FontWeight = 'bold';
            app.NormalstressXButton.FontColor = [0.9412 0.9412 0.9412];
            app.NormalstressXButton.Layout.Row = 16;
            app.NormalstressXButton.Layout.Column = [4 5];
            app.NormalstressXButton.Text = 'Normal stress (X)';

            % Create NormalstressYButton
            app.NormalstressYButton = uibutton(app.GridLayout, 'push');
            app.NormalstressYButton.ButtonPushedFcn = createCallbackFcn(app, @NormalstressYButtonPushed, true);
            app.NormalstressYButton.BackgroundColor = [0.0549 0.1725 0.3098];
            app.NormalstressYButton.FontName = 'Verdana';
            app.NormalstressYButton.FontSize = 14;
            app.NormalstressYButton.FontWeight = 'bold';
            app.NormalstressYButton.FontColor = [0.9412 0.9412 0.9412];
            app.NormalstressYButton.Layout.Row = 16;
            app.NormalstressYButton.Layout.Column = [6 7];
            app.NormalstressYButton.Text = 'Normal stress (Y)';

            % Create CompressionButton_2
            app.CompressionButton_2 = uibutton(app.GridLayout, 'push');
            app.CompressionButton_2.ButtonPushedFcn = createCallbackFcn(app, @CompressionButton_2Pushed, true);
            app.CompressionButton_2.BackgroundColor = [0.0549 0.1725 0.3098];
            app.CompressionButton_2.FontName = 'Verdana';
            app.CompressionButton_2.FontSize = 14;
            app.CompressionButton_2.FontWeight = 'bold';
            app.CompressionButton_2.FontColor = [0.9412 0.9412 0.9412];
            app.CompressionButton_2.Layout.Row = 10;
            app.CompressionButton_2.Layout.Column = [10 11];
            app.CompressionButton_2.Text = 'Compression';

            % Create EditField_2
            app.EditField_2 = uieditfield(app.GridLayout, 'text');
            app.EditField_2.ValueChangedFcn = createCallbackFcn(app, @EditField_2ValueChanged, true);
            app.EditField_2.FontName = 'Verdana';
            app.EditField_2.FontSize = 14;
            app.EditField_2.FontWeight = 'bold';
            app.EditField_2.Layout.Row = 12;
            app.EditField_2.Layout.Column = [4 7];

            % Create PredictiontimesecEditFieldLabel
            app.PredictiontimesecEditFieldLabel = uilabel(app.GridLayout);
            app.PredictiontimesecEditFieldLabel.BackgroundColor = [0.1765 0.251 0.0431];
            app.PredictiontimesecEditFieldLabel.HorizontalAlignment = 'center';
            app.PredictiontimesecEditFieldLabel.FontName = 'Verdana';
            app.PredictiontimesecEditFieldLabel.FontSize = 14;
            app.PredictiontimesecEditFieldLabel.FontWeight = 'bold';
            app.PredictiontimesecEditFieldLabel.FontColor = [1 1 1];
            app.PredictiontimesecEditFieldLabel.Layout.Row = 13;
            app.PredictiontimesecEditFieldLabel.Layout.Column = [4 6];
            app.PredictiontimesecEditFieldLabel.Text = ' Prediction time (sec)';

            % Create PredictiontimesecEditField
            app.PredictiontimesecEditField = uieditfield(app.GridLayout, 'numeric');
            app.PredictiontimesecEditField.ValueChangedFcn = createCallbackFcn(app, @PredictiontimesecEditFieldValueChanged, true);
            app.PredictiontimesecEditField.HorizontalAlignment = 'center';
            app.PredictiontimesecEditField.FontName = 'Verdana';
            app.PredictiontimesecEditField.FontSize = 14;
            app.PredictiontimesecEditField.FontWeight = 'bold';
            app.PredictiontimesecEditField.Layout.Row = 13;
            app.PredictiontimesecEditField.Layout.Column = 7;

            % Create FEAtimesecEditFieldLabel
            app.FEAtimesecEditFieldLabel = uilabel(app.GridLayout);
            app.FEAtimesecEditFieldLabel.BackgroundColor = [0.1765 0.251 0.0431];
            app.FEAtimesecEditFieldLabel.HorizontalAlignment = 'center';
            app.FEAtimesecEditFieldLabel.FontName = 'Verdana';
            app.FEAtimesecEditFieldLabel.FontSize = 14;
            app.FEAtimesecEditFieldLabel.FontWeight = 'bold';
            app.FEAtimesecEditFieldLabel.FontColor = [1 1 1];
            app.FEAtimesecEditFieldLabel.Layout.Row = 13;
            app.FEAtimesecEditFieldLabel.Layout.Column = [8 10];
            app.FEAtimesecEditFieldLabel.Text = 'FEA time (sec)';

            % Create FEAtimesecEditField
            app.FEAtimesecEditField = uieditfield(app.GridLayout, 'numeric');
            app.FEAtimesecEditField.ValueChangedFcn = createCallbackFcn(app, @FEAtimesecEditFieldValueChanged, true);
            app.FEAtimesecEditField.HorizontalAlignment = 'center';
            app.FEAtimesecEditField.FontName = 'Verdana';
            app.FEAtimesecEditField.FontSize = 14;
            app.FEAtimesecEditField.FontWeight = 'bold';
            app.FEAtimesecEditField.Layout.Row = 13;
            app.FEAtimesecEditField.Layout.Column = 11;

            % Create StressstrainplotButton_2
            app.StressstrainplotButton_2 = uibutton(app.GridLayout, 'push');
            app.StressstrainplotButton_2.ButtonPushedFcn = createCallbackFcn(app, @StressstrainplotButton_2Pushed, true);
            app.StressstrainplotButton_2.BackgroundColor = [0.0549 0.1725 0.3098];
            app.StressstrainplotButton_2.FontName = 'Verdana';
            app.StressstrainplotButton_2.FontSize = 14;
            app.StressstrainplotButton_2.FontWeight = 'bold';
            app.StressstrainplotButton_2.FontColor = [0.9412 0.9412 0.9412];
            app.StressstrainplotButton_2.Layout.Row = 17;
            app.StressstrainplotButton_2.Layout.Column = [8 9];
            app.StressstrainplotButton_2.Text = 'Stress-strain plot';

            % Create XDisplacementButton_2
            app.XDisplacementButton_2 = uibutton(app.GridLayout, 'push');
            app.XDisplacementButton_2.ButtonPushedFcn = createCallbackFcn(app, @XDisplacementButton_2Pushed, true);
            app.XDisplacementButton_2.BackgroundColor = [0.0549 0.1725 0.3098];
            app.XDisplacementButton_2.FontName = 'Verdana';
            app.XDisplacementButton_2.FontSize = 14;
            app.XDisplacementButton_2.FontWeight = 'bold';
            app.XDisplacementButton_2.FontColor = [0.9412 0.9412 0.9412];
            app.XDisplacementButton_2.Layout.Row = 15;
            app.XDisplacementButton_2.Layout.Column = [8 9];
            app.XDisplacementButton_2.Text = 'X-Displacement';

            % Create YDisplacementButton_2
            app.YDisplacementButton_2 = uibutton(app.GridLayout, 'push');
            app.YDisplacementButton_2.ButtonPushedFcn = createCallbackFcn(app, @YDisplacementButton_2Pushed, true);
            app.YDisplacementButton_2.BackgroundColor = [0.0549 0.1725 0.3098];
            app.YDisplacementButton_2.FontName = 'Verdana';
            app.YDisplacementButton_2.FontSize = 14;
            app.YDisplacementButton_2.FontWeight = 'bold';
            app.YDisplacementButton_2.FontColor = [0.9412 0.9412 0.9412];
            app.YDisplacementButton_2.Layout.Row = 15;
            app.YDisplacementButton_2.Layout.Column = [10 11];
            app.YDisplacementButton_2.Text = 'Y-Displacement';

            % Create vonMisesstressButton_2
            app.vonMisesstressButton_2 = uibutton(app.GridLayout, 'push');
            app.vonMisesstressButton_2.ButtonPushedFcn = createCallbackFcn(app, @vonMisesstressButton_2Pushed, true);
            app.vonMisesstressButton_2.BackgroundColor = [0.0549 0.1725 0.3098];
            app.vonMisesstressButton_2.FontName = 'Verdana';
            app.vonMisesstressButton_2.FontSize = 14;
            app.vonMisesstressButton_2.FontWeight = 'bold';
            app.vonMisesstressButton_2.FontColor = [0.9412 0.9412 0.9412];
            app.vonMisesstressButton_2.Layout.Row = 14;
            app.vonMisesstressButton_2.Layout.Column = [8 9];
            app.vonMisesstressButton_2.Text = 'von Mises stress';

            % Create ShearstressButton_2
            app.ShearstressButton_2 = uibutton(app.GridLayout, 'push');
            app.ShearstressButton_2.ButtonPushedFcn = createCallbackFcn(app, @ShearstressButton_2Pushed, true);
            app.ShearstressButton_2.BackgroundColor = [0.0549 0.1725 0.3098];
            app.ShearstressButton_2.FontName = 'Verdana';
            app.ShearstressButton_2.FontSize = 14;
            app.ShearstressButton_2.FontWeight = 'bold';
            app.ShearstressButton_2.FontColor = [0.9412 0.9412 0.9412];
            app.ShearstressButton_2.Layout.Row = 14;
            app.ShearstressButton_2.Layout.Column = [10 11];
            app.ShearstressButton_2.Text = 'Shear stress';

            % Create NormalstressXButton_2
            app.NormalstressXButton_2 = uibutton(app.GridLayout, 'push');
            app.NormalstressXButton_2.ButtonPushedFcn = createCallbackFcn(app, @NormalstressXButton_2Pushed, true);
            app.NormalstressXButton_2.BackgroundColor = [0.0549 0.1725 0.3098];
            app.NormalstressXButton_2.FontName = 'Verdana';
            app.NormalstressXButton_2.FontSize = 14;
            app.NormalstressXButton_2.FontWeight = 'bold';
            app.NormalstressXButton_2.FontColor = [0.9412 0.9412 0.9412];
            app.NormalstressXButton_2.Layout.Row = 16;
            app.NormalstressXButton_2.Layout.Column = [8 9];
            app.NormalstressXButton_2.Text = 'Normal stress (X)';

            % Create NormalstressYButton_2
            app.NormalstressYButton_2 = uibutton(app.GridLayout, 'push');
            app.NormalstressYButton_2.ButtonPushedFcn = createCallbackFcn(app, @NormalstressYButton_2Pushed, true);
            app.NormalstressYButton_2.BackgroundColor = [0.0549 0.1725 0.3098];
            app.NormalstressYButton_2.FontName = 'Verdana';
            app.NormalstressYButton_2.FontSize = 14;
            app.NormalstressYButton_2.FontWeight = 'bold';
            app.NormalstressYButton_2.FontColor = [0.9412 0.9412 0.9412];
            app.NormalstressYButton_2.Layout.Row = 16;
            app.NormalstressYButton_2.Layout.Column = [10 11];
            app.NormalstressYButton_2.Text = 'Normal stress (Y)';

            % Create SelectoptionDropDownLabel
            app.SelectoptionDropDownLabel = uilabel(app.GridLayout);
            app.SelectoptionDropDownLabel.BackgroundColor = [0.1765 0.251 0.0431];
            app.SelectoptionDropDownLabel.HorizontalAlignment = 'center';
            app.SelectoptionDropDownLabel.FontName = 'Verdana';
            app.SelectoptionDropDownLabel.FontSize = 14;
            app.SelectoptionDropDownLabel.FontWeight = 'bold';
            app.SelectoptionDropDownLabel.FontColor = [1 1 1];
            app.SelectoptionDropDownLabel.Layout.Row = 14;
            app.SelectoptionDropDownLabel.Layout.Column = 1;
            app.SelectoptionDropDownLabel.Text = 'Select option';

            % Create SelectoptionDropDown
            app.SelectoptionDropDown = uidropdown(app.GridLayout);
            app.SelectoptionDropDown.Items = {'Plane-stress', 'Plane-strain'};
            app.SelectoptionDropDown.ValueChangedFcn = createCallbackFcn(app, @SelectoptionDropDownValueChanged, true);
            app.SelectoptionDropDown.FontName = 'Verdana';
            app.SelectoptionDropDown.FontSize = 14;
            app.SelectoptionDropDown.FontWeight = 'bold';
            app.SelectoptionDropDown.Layout.Row = 14;
            app.SelectoptionDropDown.Layout.Column = [2 3];
            app.SelectoptionDropDown.Value = 'Plane-stress';

            % Create AIBioMechpredictionLabel
            app.AIBioMechpredictionLabel = uilabel(app.GridLayout);
            app.AIBioMechpredictionLabel.BackgroundColor = [0.2392 0 0.0588];
            app.AIBioMechpredictionLabel.HorizontalAlignment = 'center';
            app.AIBioMechpredictionLabel.FontName = 'Verdana';
            app.AIBioMechpredictionLabel.FontSize = 14;
            app.AIBioMechpredictionLabel.FontWeight = 'bold';
            app.AIBioMechpredictionLabel.FontColor = [1 1 1];
            app.AIBioMechpredictionLabel.Layout.Row = [10 11];
            app.AIBioMechpredictionLabel.Layout.Column = [4 5];
            app.AIBioMechpredictionLabel.Text = 'AI-BioMech prediction';

            % Create ImagebasedFEAoutputLabel
            app.ImagebasedFEAoutputLabel = uilabel(app.GridLayout);
            app.ImagebasedFEAoutputLabel.BackgroundColor = [0.2392 0 0.0588];
            app.ImagebasedFEAoutputLabel.HorizontalAlignment = 'center';
            app.ImagebasedFEAoutputLabel.FontName = 'Verdana';
            app.ImagebasedFEAoutputLabel.FontSize = 14;
            app.ImagebasedFEAoutputLabel.FontWeight = 'bold';
            app.ImagebasedFEAoutputLabel.FontColor = [1 1 1];
            app.ImagebasedFEAoutputLabel.Layout.Row = [10 11];
            app.ImagebasedFEAoutputLabel.Layout.Column = [8 9];
            app.ImagebasedFEAoutputLabel.Text = 'Image-based FEA output';

            % Create PoissonsratioEditField
            app.PoissonsratioEditField = uieditfield(app.GridLayout, 'numeric');
            app.PoissonsratioEditField.ValueChangedFcn = createCallbackFcn(app, @PoissonsratioEditFieldValueChanged, true);
            app.PoissonsratioEditField.HorizontalAlignment = 'center';
            app.PoissonsratioEditField.FontName = 'Verdana';
            app.PoissonsratioEditField.FontSize = 14;
            app.PoissonsratioEditField.FontWeight = 'bold';
            app.PoissonsratioEditField.Layout.Row = 11;
            app.PoissonsratioEditField.Layout.Column = 3;

            % Create BackButton
            app.BackButton = uibutton(app.GridLayout, 'push');
            app.BackButton.ButtonPushedFcn = createCallbackFcn(app, @BackButtonPushed, true);
            app.BackButton.BackgroundColor = [0.0549 0.1725 0.3098];
            app.BackButton.FontName = 'Verdana';
            app.BackButton.FontSize = 14;
            app.BackButton.FontWeight = 'bold';
            app.BackButton.FontColor = [0.9412 0.9412 0.9412];
            app.BackButton.Layout.Row = 16;
            app.BackButton.Layout.Column = 2;
            app.BackButton.Text = 'Back';

            % Create AreaEditFieldLabel
            app.AreaEditFieldLabel = uilabel(app.GridLayout);
            app.AreaEditFieldLabel.BackgroundColor = [0.1765 0.251 0.0431];
            app.AreaEditFieldLabel.HorizontalAlignment = 'center';
            app.AreaEditFieldLabel.FontName = 'Verdana';
            app.AreaEditFieldLabel.FontSize = 14;
            app.AreaEditFieldLabel.FontWeight = 'bold';
            app.AreaEditFieldLabel.FontColor = [1 1 1];
            app.AreaEditFieldLabel.Layout.Row = 8;
            app.AreaEditFieldLabel.Layout.Column = [1 2];
            app.AreaEditFieldLabel.Text = 'Area';

            % Create AreaEditField
            app.AreaEditField = uieditfield(app.GridLayout, 'numeric');
            app.AreaEditField.ValueChangedFcn = createCallbackFcn(app, @AreaEditFieldValueChanged, true);
            app.AreaEditField.HorizontalAlignment = 'center';
            app.AreaEditField.FontName = 'Verdana';
            app.AreaEditField.FontSize = 14;
            app.AreaEditField.FontWeight = 'bold';
            app.AreaEditField.Layout.Row = 8;
            app.AreaEditField.Layout.Column = 3;

            % Create InputimageLabel
            app.InputimageLabel = uilabel(app.GridLayout);
            app.InputimageLabel.BackgroundColor = [0.2392 0 0.0588];
            app.InputimageLabel.HorizontalAlignment = 'center';
            app.InputimageLabel.FontName = 'Verdana';
            app.InputimageLabel.FontSize = 14;
            app.InputimageLabel.FontWeight = 'bold';
            app.InputimageLabel.FontColor = [1 1 1];
            app.InputimageLabel.Layout.Row = 2;
            app.InputimageLabel.Layout.Column = [4 7];
            app.InputimageLabel.Text = 'Input image';

            % Create BinaryconversionLabel
            app.BinaryconversionLabel = uilabel(app.GridLayout);
            app.BinaryconversionLabel.BackgroundColor = [0.2392 0 0.0588];
            app.BinaryconversionLabel.HorizontalAlignment = 'center';
            app.BinaryconversionLabel.FontName = 'Verdana';
            app.BinaryconversionLabel.FontSize = 14;
            app.BinaryconversionLabel.FontWeight = 'bold';
            app.BinaryconversionLabel.FontColor = [1 1 1];
            app.BinaryconversionLabel.Layout.Row = 2;
            app.BinaryconversionLabel.Layout.Column = [8 11];
            app.BinaryconversionLabel.Text = 'Binary conversion';

            % Create InputparametersLabel
            app.InputparametersLabel = uilabel(app.GridLayout);
            app.InputparametersLabel.BackgroundColor = [0.2392 0 0.0588];
            app.InputparametersLabel.HorizontalAlignment = 'center';
            app.InputparametersLabel.FontName = 'Verdana';
            app.InputparametersLabel.FontSize = 14;
            app.InputparametersLabel.FontWeight = 'bold';
            app.InputparametersLabel.FontColor = [1 1 1];
            app.InputparametersLabel.Layout.Row = 12;
            app.InputparametersLabel.Layout.Column = [1 3];
            app.InputparametersLabel.Text = 'Input parameters';

            % Create ExportstressstrainButton
            app.ExportstressstrainButton = uibutton(app.GridLayout, 'push');
            app.ExportstressstrainButton.ButtonPushedFcn = createCallbackFcn(app, @ExportstressstrainButtonPushed3, true);
            app.ExportstressstrainButton.BackgroundColor = [0.0549 0.1725 0.3098];
            app.ExportstressstrainButton.FontName = 'Verdana';
            app.ExportstressstrainButton.FontSize = 14;
            app.ExportstressstrainButton.FontWeight = 'bold';
            app.ExportstressstrainButton.FontColor = [1 1 1];
            app.ExportstressstrainButton.Layout.Row = 17;
            app.ExportstressstrainButton.Layout.Column = [6 7];
            app.ExportstressstrainButton.Text = 'Export stress-strain';

            % Create Image
            app.Image = uiimage(app.GridLayout);
            app.Image.Layout.Row = [1 2];
            app.Image.Layout.Column = 1;
            app.Image.ImageSource = fullfile(pathToMLAPP, 'logo (2).png');

            % Create PoissonsratioEditFieldLabel
            app.PoissonsratioEditFieldLabel = uilabel(app.GridLayout);
            app.PoissonsratioEditFieldLabel.BackgroundColor = [0.1765 0.251 0.0431];
            app.PoissonsratioEditFieldLabel.HorizontalAlignment = 'center';
            app.PoissonsratioEditFieldLabel.FontName = 'Verdana';
            app.PoissonsratioEditFieldLabel.FontSize = 14;
            app.PoissonsratioEditFieldLabel.FontWeight = 'bold';
            app.PoissonsratioEditFieldLabel.FontColor = [0.9412 0.9412 0.9412];
            app.PoissonsratioEditFieldLabel.Layout.Row = 11;
            app.PoissonsratioEditFieldLabel.Layout.Column = [1 2];
            app.PoissonsratioEditFieldLabel.Text = 'Poisson''s ratio ';

            % Create ExportstressstrainButton_2
            app.ExportstressstrainButton_2 = uibutton(app.GridLayout, 'push');
            app.ExportstressstrainButton_2.ButtonPushedFcn = createCallbackFcn(app, @ExportstressstrainButton_2Pushed, true);
            app.ExportstressstrainButton_2.BackgroundColor = [0.0549 0.1725 0.3098];
            app.ExportstressstrainButton_2.FontName = 'Verdana';
            app.ExportstressstrainButton_2.FontSize = 14;
            app.ExportstressstrainButton_2.FontWeight = 'bold';
            app.ExportstressstrainButton_2.FontColor = [1 1 1];
            app.ExportstressstrainButton_2.Layout.Row = 17;
            app.ExportstressstrainButton_2.Layout.Column = [10 11];
            app.ExportstressstrainButton_2.Text = 'Export stress-strain';

            % Create SelectROIDropDownLabel
            app.SelectROIDropDownLabel = uilabel(app.GridLayout);
            app.SelectROIDropDownLabel.BackgroundColor = [0.1686 0.2588 0.0745];
            app.SelectROIDropDownLabel.HorizontalAlignment = 'center';
            app.SelectROIDropDownLabel.FontName = 'Verdana';
            app.SelectROIDropDownLabel.FontSize = 14;
            app.SelectROIDropDownLabel.FontColor = [0.9412 0.9412 0.9412];
            app.SelectROIDropDownLabel.Layout.Row = 1;
            app.SelectROIDropDownLabel.Layout.Column = 7;
            app.SelectROIDropDownLabel.Text = 'Select ROI';

            % Create SelectROIDropDown
            app.SelectROIDropDown = uidropdown(app.GridLayout);
            app.SelectROIDropDown.Items = {'Select options', 'Black', 'White'};
            app.SelectROIDropDown.ValueChangedFcn = createCallbackFcn(app, @SelectROIDropDownValueChanged, true);
            app.SelectROIDropDown.FontName = 'Verdana';
            app.SelectROIDropDown.FontSize = 14;
            app.SelectROIDropDown.BackgroundColor = [0.9412 0.9412 0.9412];
            app.SelectROIDropDown.Layout.Row = 1;
            app.SelectROIDropDown.Layout.Column = [8 9];
            app.SelectROIDropDown.Value = 'Select options';

            % Create EnterButton_4
            app.EnterButton_4 = uibutton(app.GridLayout, 'push');
            app.EnterButton_4.ButtonPushedFcn = createCallbackFcn(app, @EnterButton_4Pushed4, true);
            app.EnterButton_4.BackgroundColor = [0.0549 0.1725 0.3098];
            app.EnterButton_4.FontName = 'v';
            app.EnterButton_4.FontSize = 14;
            app.EnterButton_4.FontWeight = 'bold';
            app.EnterButton_4.FontColor = [0.9412 0.9412 0.9412];
            app.EnterButton_4.Layout.Row = 1;
            app.EnterButton_4.Layout.Column = [10 11];
            app.EnterButton_4.Text = 'Enter';

            % Create TensionButton
            app.TensionButton = uibutton(app.GridLayout, 'push');
            app.TensionButton.ButtonPushedFcn = createCallbackFcn(app, @TensionButtonPushed, true);
            app.TensionButton.BackgroundColor = [0.0549 0.1725 0.3098];
            app.TensionButton.FontName = 'Verdana';
            app.TensionButton.FontSize = 14;
            app.TensionButton.FontWeight = 'bold';
            app.TensionButton.FontColor = [0.9412 0.9412 0.9412];
            app.TensionButton.Layout.Row = 11;
            app.TensionButton.Layout.Column = [10 11];
            app.TensionButton.Text = 'Tension';

            % Create CleanimageButton
            app.CleanimageButton = uibutton(app.GridLayout, 'push');
            app.CleanimageButton.ButtonPushedFcn = createCallbackFcn(app, @CleanimageButtonPushed5, true);
            app.CleanimageButton.BackgroundColor = [0.051 0.1686 0.3098];
            app.CleanimageButton.FontName = 'Verdana';
            app.CleanimageButton.FontSize = 14;
            app.CleanimageButton.FontWeight = 'bold';
            app.CleanimageButton.FontColor = [0.9412 0.9412 0.9412];
            app.CleanimageButton.Layout.Row = 1;
            app.CleanimageButton.Layout.Column = [5 6];
            app.CleanimageButton.Text = 'Clean image';

            % Create ContextMenu
            app.ContextMenu = uicontextmenu(app.UIFigure);

            % Create Menu
            app.Menu = uimenu(app.ContextMenu);
            app.Menu.Text = 'Menu';

            % Create Menu2
            app.Menu2 = uimenu(app.ContextMenu);
            app.Menu2.Text = 'Menu2';

            % Create ContextMenu2
            app.ContextMenu2 = uicontextmenu(app.UIFigure);

            % Create Menu_2
            app.Menu_2 = uimenu(app.ContextMenu2);
            app.Menu_2.Text = 'Menu';

            % Create Menu2_2
            app.Menu2_2 = uimenu(app.ContextMenu2);
            app.Menu2_2.Text = 'Menu2';
            
            % Assign app.ContextMenu2
            app.BrowseButton.ContextMenu = app.ContextMenu2;

            % Create ContextMenu3
            app.ContextMenu3 = uicontextmenu(app.UIFigure);

            % Create Menu_3
            app.Menu_3 = uimenu(app.ContextMenu3);
            app.Menu_3.Text = 'Menu';

            % Create Menu2_3
            app.Menu2_3 = uimenu(app.ContextMenu3);
            app.Menu2_3.Text = 'Menu2';
            
            % Assign app.ContextMenu3
            app.FEAtimesecEditField.ContextMenu = app.ContextMenu3;

            % Create ContextMenu4
            app.ContextMenu4 = uicontextmenu(app.UIFigure);

            % Create Menu_4
            app.Menu_4 = uimenu(app.ContextMenu4);
            app.Menu_4.Text = 'Menu';

            % Create Menu2_4
            app.Menu2_4 = uimenu(app.ContextMenu4);
            app.Menu2_4.Text = 'Menu2';
            
            % Assign app.ContextMenu4
            app.EnterButton.ContextMenu = app.ContextMenu4;

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = Linearity_prediction_code_AIBioMech_exported(varargin)

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @(app)startupFcn(app, varargin{:}))

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end