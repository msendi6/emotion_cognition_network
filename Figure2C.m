% -----------------------------------------------------------------------------
% Script: Analyze UK Biobank SFNC Data
% Description:
%   This script processes UK Biobank data to analyze structural-functional
%   network connectivity (sFNC) and reaction times (RT). It performs regression
%   analysis on sFNC edges, applies FDR correction, and outputs significant edges.
%
% Requirements:
%   - MATLAB R2022b 
%   - Data file 'ukbb.mat' containing 'ukbb_sfnc' (sFNC data) and 'ukbb_demo' (demographic data)
%
% Author: Mo Sendi
% Date: 2024-12-06
% -----------------------------------------------------------------------------

%% Load Data
clc
clear
input_dir = '~/data/ukbb.mat';
load(input_dir, 'ukbb_sfnc', 'ukbb_demo');

%% Preprocess Data
missing_idx = isnan(ukbb_demo.neuroticism);
ukbb_sfnc(missing_idx, :) = [];
ukbb_demo(missing_idx, :) = [];
score = (ukbb_demo.neuroticism - nanmean(ukbb_demo.neuroticism)) / nanstd(ukbb_demo.neuroticism);

%% Initialize Results Structure
numICs = 53;
rowNames = {};
for i = 1:numICs-1
    for j = i+1:numICs
        rowNames{end+1} = sprintf('IC%d/IC%d', i, j);
    end
end

% Create a table to store regression results and ensure Connectivity is the first column
results = table(rowNames', zeros(length(rowNames), 1), zeros(length(rowNames), 1), zeros(length(rowNames), 1), ...
                zeros(length(rowNames), 1), zeros(length(rowNames), 1), zeros(length(rowNames), 1), zeros(length(rowNames), 1),zeros(length(rowNames), 1), ...
                'VariableNames', {'Connectivity','Predictor', 'Beta', 'SE', 'tValue', 'rValue', 'R2', 'Pvalue', 'adjPvalue'});

%% Regression Analysis
   AgeSex = ukbb_demo.age.* ukbb_demo.sex;
    ukbb_demo.sex=categorical(ukbb_demo.sex);
    ukbb_demo.site=categorical(ukbb_demo.site);
    Age2 = ukbb_demo.age.^2;
for i = 1:length(rowNames)
  
    model_data = table(ukbb_sfnc(:, i), score, ukbb_demo.age, ukbb_demo.sex, ukbb_demo.site, Age2, AgeSex, ...
        'VariableNames', {'sFNC_Edge', 'Score', 'Age', 'Sex', 'Site', 'Age2', 'AgeSex'});

    lm = fitlm(model_data, 'Score ~ sFNC_Edge + Age + Sex + Site + Age2 + AgeSex');
    results.Beta(i) = lm.Coefficients.Estimate(2);
    results.SE(i) = lm.Coefficients.SE(2);
    results.tValue(i) = lm.Coefficients.tStat(2);
    results.Pvalue(i) = lm.Coefficients.pValue(2);
    results.R2(i) = lm.Rsquared.Adjusted;
    results.Predictor(i)=i;

end

%% Compute r-values from t-values
df = size(ukbb_sfnc, 1) - 2;  
for i = 1:length(rowNames)
    results.rValue(i) = sign(results.tValue(i)) * sqrt(results.tValue(i)^2 / (results.tValue(i)^2 + df));
end

%% FDR Correction
[fdr, ~, ~, adj_p] = fdr_bh(results.Pvalue, 0.05, 'pdep', 'yes');
results.adjPvalue = adj_p;

%% Output Results
significant_results = results(results.adjPvalue <= 0.05, :);
output_dir='~/results';
cd(output_dir)
writetable(significant_results, 'Significant_NT_Edges.csv');
disp(significant_results);
