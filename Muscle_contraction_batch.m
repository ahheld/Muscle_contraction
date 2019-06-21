%% This batch script loads muscle contraction videos and analyzes them

%% This first section navigates to the folder and loads scripts
files = glob('190*');

datamatrix = zeros(numel(files),3001);

tic
for n = 1:numel(files)
    datamatrix(n,:) = Muscle_contraction_v3(files{n});
end
toc

xlswrite('Contraction_analysis_AH.xlsx',datamatrix,'Summary','b1') %writes data out
xlswrite('Contraction_analysis_AH.xlsx',files,'Summary','a1') %writes filenames out
