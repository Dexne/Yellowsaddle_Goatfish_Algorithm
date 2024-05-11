%   Design of a Three-bar truss problem:
%
%   The optimal design of the three-bar truss is considered using two
%   different objectives with the cross-sectional areas of members 1 and 2
%   Fit represent the weight 

classdef TresBarras
    methods(Static)
        
      function [fit] = Fit(x,checkBounds)
            if nargin==1
                checkBounds=0;
            else
                obj=TresBarras();
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
            if(dim~=2)
                fit=1e+300;
                return;
            end
            low=0.00000000000000000000000001;
            up=1;
            
            Constrains = 0;
            p = 2;
            sigma = 2;
            li = 100;
            
            % Constrains
            g(1) =((sqrt(2)*x(1)+x(2))/(sqrt(2)*x(1)^2+2*x(1)*x(2)))*p-sigma  ; 
            g(2) = ((x(2))/(sqrt(2)*x(1)^2+2*x(1)*x(2)))*p-sigma;
            g(3) = (1/(sqrt(2)*x(2)+x(1)))*p-sigma; 
            g(4) = x(1)<low || x(2)<low;
            g(5) = x(1)>up || x(2)>up;
            
            g=g>0;

            if sum(g)>0
                Constrains = Constrains+1;
            end
            
            if Constrains == 0
                fit = (2*sqrt(2)*x(1)+x(2))*li;
            else
                fit = 1e+300;
            end
        end
        
        function [low,up,dims] = Bounds(~) %Get dimensions
            dims=2;
            low=0.00000000000000000000000001;
            up=1;
            low=repmat(low,dims,1);
            up=repmat(up,dims,1); %#ok<REPMAT>
        end
        
    end
end