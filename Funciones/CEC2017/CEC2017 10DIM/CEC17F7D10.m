%   CEC2017 Shifted and Rotated Lunacek Bi_Rastrigin Function:
%
%   Number or variables(dimensions): 10.
%   Search domain: -100<=xi<=100, i = 1,2...10. 
%   Global minima: CEC17F7D10.Fit(x*) = 700
%   Global solution: Unk.
%   Get bounds: [low,up,dims] = CEC17F7D10.Bounds(i);

classdef CEC17F7D10
   methods(Static)
        function [fit] = Fit(x,checkBounds)
            if nargin==1
                checkBounds=0;
            else
                obj=CEC17F7D10();
            end
            [f, c]= size(x);
            if f < c
                x=x';
            end
            if checkBounds==true
                if (CheckFunctionsBounds(x,obj)==1)
                    fit=1e+300;
                    return;
                end
            end
            dim=length(x);
            if(dim~=10)
                fit=1e+300;
            else
                fit=cec17_func(x, 7);
            end
      end
      
      function [low,up,dims] = Bounds(~) %Overwrite dimensions
         dims=10;
         low=-100;
         up=100;
         low=repmat(low,dims,1);
         up=repmat(up,dims,1);
      end
   end
end