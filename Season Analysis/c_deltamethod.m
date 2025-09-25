% Delta method
clear all; close all; clc;

% Import data
SeasonFlag = 0;
if SeasonFlag == 0
    Data = readtable('3 Delta Method.csv');
elseif SeasonFlag == 1
    Data = readtable('4 Delta Method Pre-2018.csv');
elseif SeasonFlag == 2
    Data = readtable('5 Delta Method Post-2018.csv');
end
Data = Data{:,:};

% Construct Coefs and Var
NPos = 18; Beta = Data(1:NPos,4); Alpha = Data(:,2); Coefs = [Beta;Alpha];
BetaV = Data(1:NPos,4+1:4+NPos); AlphaV = diag(Data(:,3)); Var = blkdiag(BetaV, AlphaV);

% Calculate standard errors and confidence intervals
[Opt,Jacob] = DeltaFun(Coefs,NPos); SE = sqrt(diag(Jacob*Var*Jacob')); alpha = .05;
CIRook = arrayfun(@(lb,ub) sprintf('(%.1f%%, %.1f%%)',lb,ub),Opt(1:NPos,1)-norminv(1-alpha/2)*SE(1:NPos,1),Opt(1:NPos,1)+norminv(1-alpha/2)*SE(1:NPos,1),'UniformOutput',false);
CIVet = arrayfun(@(lb,ub) sprintf('(%.1f%%, %.1f%%)',lb,ub),Opt(NPos+1:2*NPos,1)-norminv(1-alpha/2)*SE(NPos+1:2*NPos,1),Opt(NPos+1:2*NPos,1)+norminv(1-alpha/2)*SE(NPos+1:2*NPos,1),'UniformOutput',false);
Table = [Data(1:NPos,1), Opt(1:NPos,1)/100, string(CIRook), Data(1:NPos,1)-Opt(1:NPos,1)/100, Data(NPos+1:2*NPos,1), Opt(NPos+1:2*NPos,1)/100, string(CIVet), Data(NPos+1:2*NPos,1)-Opt(NPos+1:2*NPos,1)/100];

% Check gradients
Valid = checkGradients(@(Coefs) DeltaFun(Coefs,NPos),Coefs,Display="on");

% Delta method function
function [Opt,Jacob] = DeltaFun(Coefs,NPos)
    Beta = Coefs(1:NPos);
    AlphaRook = Coefs(NPos+1:NPos+NPos); OptRook = 100*Beta.*AlphaRook/(Beta'*AlphaRook);
    AlphaVet = Coefs(2*NPos+1:2*NPos+NPos); OptVet = 100*Beta.*AlphaVet/(Beta'*AlphaVet);
    Opt = [OptRook;OptVet];

    % Calculate RookJacob
    JacobRook = zeros(NPos,3*NPos); DenomRook = (Beta'*AlphaRook)^2;
    for i = 1:NPos
        % w.r.t. Beta
        JacobRook(i,1:NPos) = -100*Beta(i)*AlphaRook(i)*AlphaRook'/DenomRook;
        JacobRook(i,i) = 100*AlphaRook(i)*((Beta'*AlphaRook)-Beta(i)*AlphaRook(i))/DenomRook;
        
        % w.r.t. Alpha
        JacobRook(i,NPos+1:NPos+NPos) = -100*Beta(i)*AlphaRook(i)*Beta'/DenomRook;
        JacobRook(i,NPos+i) = 100*Beta(i)*((Beta'*AlphaRook)-Beta(i)*AlphaRook(i))/DenomRook;
    end
    
    % Calculate VetJacob
    JacobVet = zeros(NPos,3*NPos); DenomVet = (Beta'*AlphaVet)^2;
    for i = 1:NPos
        % w.r.t. Beta
        JacobVet(i,1:NPos) = -100*Beta(i)*AlphaVet(i)*AlphaVet'/DenomVet;
        JacobVet(i,i) = 100*AlphaVet(i)*((Beta'*AlphaVet)-Beta(i)*AlphaVet(i))/DenomVet;
        
        % w.r.t. Alpha
        JacobVet(i,2*NPos+1:2*NPos+NPos) = -100*Beta(i)*AlphaVet(i)*Beta'/DenomVet;
        JacobVet(i,2*NPos+i) = 100*Beta(i)*((Beta'*AlphaVet)-Beta(i)*AlphaVet(i))/DenomVet;
    end

    Jacob = [JacobRook;JacobVet];
end