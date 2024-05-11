%   Optimal Design of a gear train problem:
%
%   Consider a gear train in wich the gear pairs are numbered from 1 to n.
%   The pitch diamenters (or theet number) of the gears are assumed to be
%   known and the face widths of the gear pairs are treated as design
%   variables.
%   The number of theet of each gear must be between 12 and 60
%   Fit represent the weight of the gear train.

classdef Engranajes
    methods(Static)
        
      function [fit] = Fit(x,checkBounds)
            if nargin==1
                checkBounds=0;
            else
                obj=Engranajes();
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

            x=round(x);
            Constrains=0;
            
            low=12;
            up=60;
            
            g(1) = x(1)<low || x(2)<low || x(3)<low || x(4)<low;
            g(2) = x(1)>up || x(2)>up || x(3)>up || x(4)>up;
            
            g=g>0;

            if sum(g)>0
                Constrains = Constrains+1;
            end
            
            if Constrains == 0
                fit=((1/6.931)-(x(1)*x(2))/(x(3)*x(4)))^2;
            else
                fit = 1e+300;
            end
        end
        
        function [low,up,dims] = Bounds(~) %Get dimensions
            dims=4;
            low=12;
            up=60;
            low=repmat(low,dims,1);
            up=repmat(up,dims,1);
        end
        
    end
end