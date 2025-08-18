% -----------------------------------------------------------------------------
% Script: Analyze Aurora dFNC Variables (for the emotion network) with Clinical Outcomes
% Description:
%   This script processes Aurora study data to analyze dynamic functional
%   network connectivity (dFNC) variables in relation to stress, anxiety, and depression.
%   It runs multiple linear regressions with demographic covariates, computes
%   effect sizes (Beta, SE, t, r, R²), applies FDR correction, and saves results.
%
% Requirements:
%   - MATLAB R2022b
%   - Data file 'cog_emo_dfnc_variable.mat' containing:
%       - emo_dfnc_var (table of dFNC variables)
%       - aurora_demo (table of demographics/clinical measures)
%   - Function 'fdr_bh' on the MATLAB path
%
% Author: Mo Sendi
% Date: 2024-12-15
% -----------------------------------------------------------------------------
%Figure 5c,d,e
%Top pannel (stress) 
clear; clc; close all;

% --- Load data
load('~/data/cog_emo_dfnc_variable.mat')

% --- Setup covariates
AgeSex = aurora_demo.age .* aurora_demo.sex;
aurora_demo.sex        = categorical(aurora_demo.sex);
aurora_demo.site       = categorical(aurora_demo.site);
Age2                   = aurora_demo.age .^ 2;
aurora_demo.truma_type = categorical(aurora_demo.truma_type);
aurora_demo.incom      = categorical(aurora_demo.incom);
score                  = aurora_demo.PCL5;

% --- Variables to analyze
nRows    = 3;
rowNames = {'ocr1','ocr2','ocr3'}';

selected_dfnc = table2array(emo_dfnc_var);

% --- Initialize results table
results = table(rowNames, zeros(nRows, 1), zeros(nRows, 1), zeros(nRows, 1), ...
                zeros(nRows, 1), zeros(nRows, 1), zeros(nRows, 1), zeros(nRows, 1), ...
    'VariableNames', {'dFNC','Beta','SE','tValue','rValue','R2','Pvalue','adjPvalue'});

% --- Regression loop
for i = 1:nRows
    model_data = table(selected_dfnc(:, i), score, aurora_demo.age, aurora_demo.sex, ...
        aurora_demo.site, Age2, AgeSex, aurora_demo.truma_type, ...
        aurora_demo.education, aurora_demo.incom, ...
        'VariableNames', {'dFNC_var','Score','Age','Sex','Site','Age2','AgeSex','Truma_type','Education','Income'});

    lm = fitlm(model_data, ...
        'Score ~ dFNC_var + Age + Sex + Site + Age2 + AgeSex + Truma_type + Education + Income');

    results.Beta(i)   = lm.Coefficients.Estimate(2);
    results.SE(i)     = lm.Coefficients.SE(2);
    results.tValue(i) = lm.Coefficients.tStat(2);
    results.Pvalue(i) = lm.Coefficients.pValue(2);
    results.R2(i)     = lm.Rsquared.Adjusted;
end

% --- Compute r values (effect size)
df = size(selected_dfnc, 1) - 2;
results.rValue = arrayfun(@(x) sign(x) * sqrt(x^2 / (x^2 + df)), results.tValue);

% --- FDR correction
[~, ~, ~, adj_p] = fdr_bh(results.Pvalue, 0.05, 'pdep','yes');
results.adjPvalue = adj_p;

% --- Display results
disp(results)

%%
%Figure 5c,d,e 
%Middle pannel (anxiety)
clear; clc; close all;

% --- Load data
load('~/data/cog_emo_dfnc_variable.mat')

% --- Setup covariates
AgeSex = aurora_demo.age .* aurora_demo.sex;
aurora_demo.sex        = categorical(aurora_demo.sex);
aurora_demo.site       = categorical(aurora_demo.site);
Age2                   = aurora_demo.age .^ 2;
aurora_demo.truma_type = categorical(aurora_demo.truma_type);
aurora_demo.incom      = categorical(aurora_demo.incom);
score                  = aurora_demo.AnxBank;

% --- Variables to analyze
nRows    = 3;
rowNames = {'ocr1','ocr2','ocr3'}';

selected_dfnc = table2array(emo_dfnc_var);

% --- Initialize results table
results = table(rowNames, zeros(nRows, 1), zeros(nRows, 1), zeros(nRows, 1), ...
                zeros(nRows, 1), zeros(nRows, 1), zeros(nRows, 1), zeros(nRows, 1), ...
    'VariableNames', {'dFNC','Beta','SE','tValue','rValue','R2','Pvalue','adjPvalue'});

% --- Regression loop
for i = 1:nRows
    model_data = table(selected_dfnc(:, i), score, aurora_demo.age, aurora_demo.sex, ...
        aurora_demo.site, Age2, AgeSex, aurora_demo.truma_type, ...
        aurora_demo.education, aurora_demo.incom, ...
        'VariableNames', {'dFNC_var','Score','Age','Sex','Site','Age2','AgeSex','Truma_type','Education','Income'});

    lm = fitlm(model_data, ...
        'Score ~ dFNC_var + Age + Sex + Site + Age2 + AgeSex + Truma_type + Education + Income');

    results.Beta(i)   = lm.Coefficients.Estimate(2);
    results.SE(i)     = lm.Coefficients.SE(2);
    results.tValue(i) = lm.Coefficients.tStat(2);
    results.Pvalue(i) = lm.Coefficients.pValue(2);
    results.R2(i)     = lm.Rsquared.Adjusted;
end

% --- Compute r values (effect size)
df = size(selected_dfnc, 1) - 2;
results.rValue = arrayfun(@(x) sign(x) * sqrt(x^2 / (x^2 + df)), results.tValue);

% --- FDR correction
[~, ~, ~, adj_p] = fdr_bh(results.Pvalue, 0.05, 'pdep','yes');
results.adjPvalue = adj_p;

% --- Display results
disp(results)
%%
%Figure 5c,d,e
%Bottom pannel (depression)
clear; clc; close all;

% --- Load data
load('~/data/cog_emo_dfnc_variable.mat')

% --- Setup covariates
AgeSex = aurora_demo.age .* aurora_demo.sex;
aurora_demo.sex        = categorical(aurora_demo.sex);
aurora_demo.site       = categorical(aurora_demo.site);
Age2                   = aurora_demo.age .^ 2;
aurora_demo.truma_type = categorical(aurora_demo.truma_type);
aurora_demo.incom      = categorical(aurora_demo.incom);
score                  = aurora_demo.depression;

% --- Variables to analyze
nRows    = 3;
rowNames = {'ocr1','ocr2','ocr3'}';

selected_dfnc = table2array(emo_dfnc_var);

% --- Initialize results table
results = table(rowNames, zeros(nRows, 1), zeros(nRows, 1), zeros(nRows, 1), ...
                zeros(nRows, 1), zeros(nRows, 1), zeros(nRows, 1), zeros(nRows, 1), ...
    'VariableNames', {'dFNC','Beta','SE','tValue','rValue','R2','Pvalue','adjPvalue'});

% --- Regression loop
for i = 1:nRows
    model_data = table(selected_dfnc(:, i), score, aurora_demo.age, aurora_demo.sex, ...
        aurora_demo.site, Age2, AgeSex, aurora_demo.truma_type, ...
        aurora_demo.education, aurora_demo.incom, ...
        'VariableNames', {'dFNC_var','Score','Age','Sex','Site','Age2','AgeSex','Truma_type','Education','Income'});

    lm = fitlm(model_data, ...
        'Score ~ dFNC_var + Age + Sex + Site + Age2 + AgeSex + Truma_type + Education + Income');

    results.Beta(i)   = lm.Coefficients.Estimate(2);
    results.SE(i)     = lm.Coefficients.SE(2);
    results.tValue(i) = lm.Coefficients.tStat(2);
    results.Pvalue(i) = lm.Coefficients.pValue(2);
    results.R2(i)     = lm.Rsquared.Adjusted;
end

% --- Compute r values (effect size)
df = size(selected_dfnc, 1) - 2;
results.rValue = arrayfun(@(x) sign(x) * sqrt(x^2 / (x^2 + df)), results.tValue);

% --- FDR correction
[~, ~, ~, adj_p] = fdr_bh(results.Pvalue, 0.05, 'pdep','yes');
results.adjPvalue = adj_p;

% --- Display results
disp(results)