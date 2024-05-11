%   Shifted GRIEWANK function:
%
%   Number or variables(dimensions): n.
%   Search domain: -500<=xi<=700, i = 1,2,...,n. 
%   Global minima: Griewank.Fit(x*) = 0
%   Global solution: x* = (100,...100).
%   Get bounds: Griewank.Bounds(n);


classdef ShiftedGriewank
    
   methods(Static)
        function [fit] = Fit(x,checkBounds)
            x=x-100;  %shifted Griewank
            if nargin==1
                checkBounds=0;
            else
                obj=ShiftedGriewank();
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
            d = length(x);
            sum = 0;
            prod = 1;
            
            for ii = 1:d
                xi = x(ii);
                sum = sum + xi^2/4000;
                prod = prod * cos(xi/sqrt(ii));
            end
            
            fit = sum - prod + 1;
      end
      
      function [low,up,dims] = Bounds(dims) %Get dimensions
         low=-600+100; % ShiftedGriewank
         up=600+100;   % ShiftedGriewank
         low=repmat(low,dims,1);
         up=repmat(up,dims,1);
      end
      
   end
end