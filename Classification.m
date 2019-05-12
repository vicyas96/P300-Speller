workspaceVars = who;
findVars = strfind(workspaceVars, 'BrainWaveAverage');
indexVars = find(not(cellfun('isempty', findVars)));

%%%%if you have 100 characters in your dataset, use 80 for training, 20 for
%%%%testing (approximately)

%%%%Training set (80 characters)
X = [];
for i = 1 : 80
    eval(['dataset = ',workspaceVars{indexVars(i)},';']);
    X = [X; dataset];
end

%%%%%Testing set (20 characters)
testData = [];
for i = 81 : 100
    eval(['dataset = ',workspaceVars{indexVars(i)},';']);
    testData = [testData; dataset];
end


classVar = X;

%%%%%Normalize data in the range [-1 1]
classVar(:,1:14) = normalize(classVar(:,1:14),'range', [-1 1]);

testData(:,1:14) = normalize(testData(:,1:14),'range', [-1 1]);

%%%%Once you've got enough data, train Linear Discriminant Analysis(LDA)
%%%%classifier
Mdl = fitcdiscr(classVar(:,1:14),classVar(:,15),'OptimizeHyperparameters','auto',...
    'HyperparameterOptimizationOptions',...
    struct('AcquisitionFunctionName','expected-improvement-plus'));

%%%%Use the classification model to predict training accuracy
yfit = predict(Mdl, classVar(:,1:14));

%%%%Use the classification model to predict testing accuracy
yfit = predict(Mdl, testData(:,1:14));

%%%%Check the accuracy
AccuracyCheck;
