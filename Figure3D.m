% -----------------------------------------------------------------------------
% Script: Analyze Anhedonia-realted FNC with Clinical Outcomes in AURORA
% Description:
%This code output is  Supplementary Data 14,15, and 16
%   This script processes Aurora study data to analyze structural-functional
%   network connectivity (sFNC) edges in relation to clinical measures of
%   PTSD (PCL-5), anxiety (AnxBank), and depression. For each outcome, the
%   script performs multiple linear regression with demographic covariates,
%   computes effect sizes (Beta, SE, t, r, R²), applies FDR correction, and
%   writes results to CSV files.
%
% Requirements:
%   - MATLAB R2022b
%   - Data file 'aurora.mat' containing 'aurora_sfnc' (sFNC data) and
%     'aurora_demo' (demographic and clinical data)
%   - CSV file 'Significant_RT_Edges.csv' listing significant predictors
%   - Function 'fdr_bh' available on MATLAB path
%
% Outputs:
%   - Anh_Edges_stress.csv
%   - Anh_Edges_anxiety.csv
%   - Anh_Edges_depression.csv
%
% Author: Mo Sendi
% Date: 2024-12-10
% -----------------------------------------------------------------------------
%Top pannel 
clear
load('~/data/aurora.mat');
filename = '~/results/Significant_Anh_Edges.csv';
ukbb_result = readtable(filename);
rowNames = ukbb_result.Connectivity;
selected_predictor=ukbb_result.Predictor;
nRows = length(rowNames);

% Setup demographic interaction terms and recode variables
AgeSex = aurora_demo.age .* aurora_demo.sex;
aurora_demo.sex = categorical(aurora_demo.sex);
aurora_demo.site = categorical(aurora_demo.site);
Age2 = aurora_demo.age .^ 2;
aurora_demo.truma_type = categorical(aurora_demo.truma_type);
aurora_demo.incom = categorical(aurora_demo.incom);
selected_sfnc = aurora_sfnc(:, ukbb_result.Predictor);
score = aurora_demo.PCL5;

 % Create a table to store regression results with rowNames as the first column
results = table(rowNames, zeros(nRows, 1), zeros(nRows, 1), zeros(nRows, 1), ...
                zeros(nRows, 1), zeros(nRows, 1), zeros(nRows, 1), zeros(nRows, 1), zeros(nRows, 1), ...
                'VariableNames', {'Connectivity', 'Predictor', 'Beta', 'SE', 'tValue', 'rValue', 'R2', 'Pvalue', 'adjPvalue'});


% Perform linear regression analysis for each connectivity predictor
for i = 1:nRows
    model_data = table(selected_sfnc(:, i), score, aurora_demo.age, aurora_demo.sex, ...
        aurora_demo.site, Age2, AgeSex, aurora_demo.truma_type, aurora_demo.education,aurora_demo.incom ,...
        'VariableNames', {'sFNC_Edge', 'Score', 'Age', 'Sex', 'Site', 'Age2', 'AgeSex', 'Truma_type', 'Education','Income'});

    lm = fitlm(model_data, 'Score ~ sFNC_Edge + Age + Sex + Site + Age2 + AgeSex + Truma_type + Education+Income');
    results.Beta(i) = lm.Coefficients.Estimate(2);
    results.SE(i) = lm.Coefficients.SE(2);
    results.tValue(i) = lm.Coefficients.tStat(2);
    results.Pvalue(i) = lm.Coefficients.pValue(2);
    results.R2(i) = lm.Rsquared.Adjusted;
    results.Predictor(i) = ukbb_result.Predictor(i);
end

% Compute r values using the degrees of freedom, N-2
df = size(selected_sfnc, 1) - 2;
results.rValue = arrayfun(@(x) sign(x) * sqrt(x^2 / (x^2 + df)), results.tValue);

% Apply False Discovery Rate (FDR) correction
[fdr, ~, ~, adj_p] = fdr_bh(results.Pvalue, 0.05, 'pdep', 'yes');
results.adjPvalue = adj_p;


output_dir='~/results/aurora';
cd(output_dir)
writetable(results, 'Anh_Edges_stress.csv');% This is Supplementary Data 14

%%
%Middle pannel 
clear
load('~/data/aurora.mat');
filename = '~/results/Significant_Anh_Edges.csv';
ukbb_result = readtable(filename);
rowNames = ukbb_result.Connectivity;
selected_predictor=ukbb_result.Predictor;
nRows = length(rowNames);

% Setup demographic interaction terms and recode variables
AgeSex = aurora_demo.age .* aurora_demo.sex;
aurora_demo.sex = categorical(aurora_demo.sex);
aurora_demo.site = categorical(aurora_demo.site);
Age2 = aurora_demo.age .^ 2;
aurora_demo.truma_type = categorical(aurora_demo.truma_type);
aurora_demo.incom = categorical(aurora_demo.incom);
selected_sfnc = aurora_sfnc(:, ukbb_result.Predictor);
score = aurora_demo.AnxBank;

 % Create a table to store regression results with rowNames as the first column
results = table(rowNames, zeros(nRows, 1), zeros(nRows, 1), zeros(nRows, 1), ...
                zeros(nRows, 1), zeros(nRows, 1), zeros(nRows, 1), zeros(nRows, 1), zeros(nRows, 1), ...
                'VariableNames', {'Connectivity', 'Predictor', 'Beta', 'SE', 'tValue', 'rValue', 'R2', 'Pvalue', 'adjPvalue'});


% Perform linear regression analysis for each connectivity predictor
for i = 1:nRows
    model_data = table(selected_sfnc(:, i), score, aurora_demo.age, aurora_demo.sex, ...
        aurora_demo.site, Age2, AgeSex, aurora_demo.truma_type, aurora_demo.education,aurora_demo.incom ,...
        'VariableNames', {'sFNC_Edge', 'Score', 'Age', 'Sex', 'Site', 'Age2', 'AgeSex', 'Truma_type', 'Education','Income'});

    lm = fitlm(model_data, 'Score ~ sFNC_Edge + Age + Sex + Site + Age2 + AgeSex + Truma_type + Education+Income');
    results.Beta(i) = lm.Coefficients.Estimate(2);
    results.SE(i) = lm.Coefficients.SE(2);
    results.tValue(i) = lm.Coefficients.tStat(2);
    results.Pvalue(i) = lm.Coefficients.pValue(2);
    results.R2(i) = lm.Rsquared.Adjusted;
    results.Predictor(i) = ukbb_result.Predictor(i);
end

% Compute r values using the degrees of freedom, N-2
df = size(selected_sfnc, 1) - 2;
results.rValue = arrayfun(@(x) sign(x) * sqrt(x^2 / (x^2 + df)), results.tValue);

% Apply False Discovery Rate (FDR) correction
[fdr, ~, ~, adj_p] = fdr_bh(results.Pvalue, 0.05, 'pdep', 'yes');
results.adjPvalue = adj_p;


output_dir='~/results/aurora';
cd(output_dir)
writetable(results, 'Anh_Edges_anxiety.csv');% This is Supplementary Data 15

%%
%%Bottom pannel 
clear
load('~/data/aurora.mat');
filename = '~/results/Significant_Anh_Edges.csv';
ukbb_result = readtable(filename);
rowNames = ukbb_result.Connectivity;
selected_predictor=ukbb_result.Predictor;
nRows = length(rowNames);

% Setup demographic interaction terms and recode variables
AgeSex = aurora_demo.age .* aurora_demo.sex;
aurora_demo.sex = categorical(aurora_demo.sex);
aurora_demo.site = categorical(aurora_demo.site);
Age2 = aurora_demo.age .^ 2;
aurora_demo.truma_type = categorical(aurora_demo.truma_type);
aurora_demo.incom = categorical(aurora_demo.incom);
selected_sfnc = aurora_sfnc(:, ukbb_result.Predictor);
score = aurora_demo.depression;

 % Create a table to store regression results with rowNames as the first column
results = table(rowNames, zeros(nRows, 1), zeros(nRows, 1), zeros(nRows, 1), ...
                zeros(nRows, 1), zeros(nRows, 1), zeros(nRows, 1), zeros(nRows, 1), zeros(nRows, 1), ...
                'VariableNames', {'Connectivity', 'Predictor', 'Beta', 'SE', 'tValue', 'rValue', 'R2', 'Pvalue', 'adjPvalue'});


% Perform linear regression analysis for each connectivity predictor
for i = 1:nRows
    model_data = table(selected_sfnc(:, i), score, aurora_demo.age, aurora_demo.sex, ...
        aurora_demo.site, Age2, AgeSex, aurora_demo.truma_type, aurora_demo.education,aurora_demo.incom ,...
        'VariableNames', {'sFNC_Edge', 'Score', 'Age', 'Sex', 'Site', 'Age2', 'AgeSex', 'Truma_type', 'Education','Income'});

    lm = fitlm(model_data, 'Score ~ sFNC_Edge + Age + Sex + Site + Age2 + AgeSex + Truma_type + Education+Income');
    results.Beta(i) = lm.Coefficients.Estimate(2);
    results.SE(i) = lm.Coefficients.SE(2);
    results.tValue(i) = lm.Coefficients.tStat(2);
    results.Pvalue(i) = lm.Coefficients.pValue(2);
    results.R2(i) = lm.Rsquared.Adjusted;
    results.Predictor(i) = ukbb_result.Predictor(i);
end

% Compute r values using the degrees of freedom, N-2
df = size(selected_sfnc, 1) - 2;
results.rValue = arrayfun(@(x) sign(x) * sqrt(x^2 / (x^2 + df)), results.tValue);

% Apply False Discovery Rate (FDR) correction
[fdr, ~, ~, adj_p] = fdr_bh(results.Pvalue, 0.05, 'pdep', 'yes');
results.adjPvalue = adj_p;


output_dir='~/results/aurora';
cd(output_dir)
writetable(results, 'Anh_Edges_depression.csv');% This is Supplementary Data 16




