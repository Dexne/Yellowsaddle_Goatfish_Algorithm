%   MULTIMODAL function:
%
%   Number or variables(dimensions): n.
%   Search domain: -10<=xi<=10, i = 1,2,...,n. 
%   Global minima: MultiModal.Fit(x*) = 0
%   Global solution: x* = (0,...,0).
%   Get bounds: MultiModal.Bounds(n);

classdef MultiModal
   methods(Static)
       
      function [fit] = Fit(x,checkBounds)
            if nargin==1
                checkBounds=0;
            else
                obj=MultiModal();
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
            n = length(x);
            sum = 0;
            prod = 1;
            for i = 1:n
                abs_xi = abs(x(i));
                sum = sum + abs_xi;
                prod = prod*abs_xi;
            end
            fit = sum*prod;
      end
      
      function [low,up,dims] = Bounds(dims) %Get dimensions
         low=-10;
         up=10;
         low=repmat(low,dims,1);
         up=repmat(up,dims,1);
      end
      
   end
end