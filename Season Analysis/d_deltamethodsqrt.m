% Delta method
clear all; close all; clc;

% Import data
Data = readtable('6 Delta Method Sqrt.csv');
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
    AlphaRook = Coefs(NPos+1:NPos+NPos); OptRook = 100*Beta.^2.*AlphaRook.^2/(Beta.^2'*AlphaRook.^2);
    AlphaVet = Coefs(2*NPos+1:2*NPos+NPos); OptVet = 100*Beta.^2.*AlphaVet.^2/(Beta.^2'*AlphaVet.^2);
    Opt = [OptRook;OptVet];

    % Calculate RookJacob
    JacobRook = zeros(NPos,3*NPos); DenomRook = (Beta.^2'*AlphaRook.^2)^2;
    for i = 1:NPos
        % w.r.t. Beta
        JacobRook(i,1:NPos) = -200*Beta(i)^2*AlphaRook(i)^2*Beta'.*AlphaRook.^2'/DenomRook;
        JacobRook(i,i) = 200*Beta(i)*AlphaRook(i)^2*((Beta.^2'*AlphaRook.^2)-Beta(i)^2*AlphaRook(i)^2)/DenomRook;
        
        % w.r.t. Alpha
        JacobRook(i,NPos+1:NPos+NPos) = -200*Beta(i)^2*AlphaRook(i)^2*Beta.^2'.*AlphaRook'/DenomRook;
        JacobRook(i,NPos+i) = 200*Beta(i)^2*AlphaRook(i)*((Beta.^2'*AlphaRook.^2)-Beta(i)^2*AlphaRook(i)^2)/DenomRook;
    end
    
    % Calculate VetJacob
    JacobVet = zeros(NPos,3*NPos); DenomVet = (Beta.^2'*AlphaVet.^2)^2;
    for i = 1:NPos
        % w.r.t. Beta
        JacobVet(i,1:NPos) = -200*Beta(i)^2*AlphaVet(i)^2*Beta'.*AlphaVet.^2'/DenomVet;
        JacobVet(i,i) = 200*Beta(i)*AlphaVet(i)^2*((Beta.^2'*AlphaVet.^2)-Beta(i)^2*AlphaVet(i)^2)/DenomVet;
        
        % w.r.t. Alpha
        JacobVet(i,2*NPos+1:2*NPos+NPos) = -200*Beta(i)^2*AlphaVet(i)^2*Beta.^2'.*AlphaVet'/DenomVet;
        JacobVet(i,2*NPos+i) = 200*Beta(i)^2*AlphaVet(i)*((Beta.^2'*AlphaVet.^2)-Beta(i)^2*AlphaVet(i)^2)/DenomVet;
    end

    Jacob = [JacobRook;JacobVet];
end