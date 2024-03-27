function [normCs, residuals, slope, intercept, r, r2] = normalized_criterion(dVec, cVec)
% normalized_criterion.m: Remove explained variance of d' from criterion values
% function [normCs, residuals, slope, intercept, r, r2] = normalized_criterion(dVec, cVec)
% 
% Created: 04/10/2018, Evan Layher
% Revised: 05/02/2018, Evan Layher % Added residuals output
% 
% --- LICENSE INFORMATION --- %
% Modified BSD-2 License - for Non-Commercial Use Only
%
% Copyright (c) 2018, The Regents of the University of California
% All rights reserved.
%
% Redistribution and use in source and binary forms, with or without modification, are 
% permitted for non-commercial use only provided that the following conditions are met:
%
% 1. Redistributions of source code must retain the above copyright notice, this list 
%    of conditions and the following disclaimer.
%
% 2. Redistributions in binary form must reproduce the above copyright notice, this list 
%    of conditions and the following disclaimer in the documentation and/or other 
%    materials provided with the distribution.
%
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY 
% EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES 
% OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT 
% SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, 
% INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED 
% TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; 
% OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
% CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY 
% WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
%
% For permission to use for commercial purposes, please contact UCSB's Office of 
% Technology & Industry Alliances at 805-893-5180 or info@tia.ucsb.edu.
% --------------------------- %
%
% Signal detection theory: Adjust criterion values to account for relationship with d'
% Use linear regression to find relationship between criterion and d'
% The regression residuals are added to mean criterion to get normalized criterion values.
%
% Inputs: 2 vectors of equal length
% (1) dVec: Vector of d' values
% (2) cVec: Vector of criterion values
%
% Outputs (6): normCs, residuals, slope, intercept, r, r2
% (1) normCs: normalized criterion values (residuals + criterion mean)
% (2) residuals: residual values only
% (3) slope: regression slope
% (4) intercept: regression intercept
% (5) r: Pearson's r
% (6) r2: Pearson's r^2

if length(dVec) ~= length(cVec)
    fprintf('VECTORS MUST BE OF SAME LENGTH\n')
end

meanDs = mean(dVec); % Average d' (x)
meanCs = mean(cVec); % Average criterion (y)

sumDsqrs = sum((dVec - meanDs) .^ 2); % Sum of d' squares (x)
sumCsqrs = sum((cVec - meanDs) .^ 2); % Sum of c squares (y)
sumDCs = sum((dVec - meanDs) .* (cVec - meanCs)); % Sum of criterion x d' squares (y)
    
slope = sumDCs / sumDsqrs;
intercept = meanCs - (slope * meanDs);

r = sumDCs / sqrt((sumDsqrs * sumCsqrs)); % pearson's r
r2 = r ^ 2; % Variance explained (%)

lineCvec = slope .* dVec + intercept; % mx + b

residuals = (cVec - lineCvec); % Residuals from regression
normCs = residuals + meanCs; % Residuals + mean
end

