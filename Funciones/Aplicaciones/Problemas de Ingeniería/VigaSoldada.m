%   Welded Beam Design problem:
%
%   The welded beam is designed for minimum cost, subject to constrains on
%   sherar stress in weld, bending stress in the beam, buckling load on the
%   bar, end deflection of the beam and the side constrains
%   Fit represent the value in dollars of 


classdef VigaSoldada
    methods(Static)

        function [fit] = Fit(x,checkBounds)
            if nargin==1
                checkBounds=0;
            else
                obj=VigaSoldada();
            end
            [f, c]= size(x);
            if f > c
                x=x';
            end
            if checkBounds==true
                if (CheckFunctionsBounds(x,obj)==1)
                    fit=1e+300;
                    return;
                end
            end
            
            dim=length(x);
            if(dim~=4)
                fit=1e+300;
                return;
            end
            low = [0.1; 0.1; 0.1; 0.1];
            up = [2; 10; 10; 2];

            Constrains=0;
            P = 6000;
            LL = 14;
            E = 30e6;
            G = 12e6;
            tMax = 13600;
            sigmaMax=30000;
            deltaMax = 0.25;
            
            M = P * (LL+x(2)/2);
            R = sqrt((x(2)^2)/4 + ((x(1)+x(3)) /2)^2);
            J = 2*(sqrt(2)*x(1)*x(2)*((x(2)^2)/12 + ((x(1)+x(3))/2)^2));
            sigmaF = (6 * P * LL)/((x(3)^2) * x(4));
            deltaF = (4 * P *(LL^3)) / (E * (x(3)^3) * x(4));
            Aux = (4.013*E*sqrt(((x(3)^2 * x(4)^6)/36)))/LL^2;
            PcF = Aux*(1-(x(3)/(2*LL))*sqrt(E/(4*G)));
            Tprima = P / (sqrt(2) * x(1) * x(2));
            Tbiprima = (M*R) / J;
            tF = sqrt((Tprima^2) + (2 * Tprima * Tbiprima * x(2) / (2 * R)) + (Tbiprima^2));

            % Constrains
            g(1) = tF - tMax; % stress in weld
            g(2) = sigmaF - sigmaMax; % bending stress in the beam
            g(3) = x(1) - x(4); % the member thickness must be greater than the weld thickness
            g(4) = 0.10471 * (x(1)^2) + 0.04811 * x(3)*x(4)*(14+x(2)) - 5; %the cost of the weld material and the bar cannot exceed a quantity (5)
            g(5) = 0.125 - x(1); % the weld thickness must be larger than a defined minimum
            g(6) = deltaF - deltaMax; % end deflection of the beam
            g(7) = P-PcF; %buckling load on the bar
            g(8) = x(1)<low(1) || x(2)<low(2) || x(3)<low(3) || x(4)<low(4); %side constrains
            g(9) = x(1)>up(1) || x(2)>up(2) || x(3)>up(3) || x(4)>up (4); %side constrains

            g=g>0;

            if sum(g)>0
                Constrains = Constrains+1;
            end
            
            if Constrains == 0
                fit = 1.1047*(x(1)^2) * x(2) + 0.04811*x(3)*x(4)*(14 + x(2)); % Cost of the welded beam w/ material
            else
                fit = 1e+300;
            end
        end
        
        function [low,up,dims] = Bounds(~) %Get dimensions
            dims = 4;
            low = [0.1; 0.1; 0.1; 0.1];
            up = [2; 10; 10; 2];
        end
    end
end