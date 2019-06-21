%% This function analyzes muscle contractions, added gaussian blur for Eugene

function [variation] = Muscle_contraction_v3(file) 

tic
%% The first step is to load the data of interest
frames = glob(strcat(file,'*'));

%this section makes an array of numbers used to load data
numbers = [1:numel(frames)]';
numbers = num2str(numbers);
array  = cellstr(numbers);

core = frames{1}(1:end-7);
filenames = cell(numel(frames),1);

% the way the cytation numbers images is strange, and these for loops are
% necessary to account for that weirdness
for n = 1:99
    filenames{n} = frames{n};
end

for n = 100:999
    filenames{n} = strcat(core,array{n}(2:end),'.tif');
end

for n = 1000:numel(frames)
    filenames{n} = strcat(core,array{n},'.tif');
end

%clear variables not being used to save memory
clear frames array core numbers;


variation = zeros(numel(filenames),1);

backgroundframe = zeros(904,1224,1,'int16');
backgroundframe(:,:,1) = imread(filenames{1});
backgroundframe(:,:,1) = imgaussfilt(backgroundframe(:,:,1),2);
for n = 2:numel(filenames)
    analysisframe = zeros(904,1224,1,'int16');
    analysisframe(:,:,1) = imread(filenames{n});
    delta = abs(backgroundframe-analysisframe);
    variation(n) = mean(delta,'all');
    backgroundframe = imgaussfilt(analysisframe,2);
end
toc
