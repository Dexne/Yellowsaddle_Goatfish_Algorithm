%   CEC2017 Shifted and Rotated Zakharov Function:
%
%   Number or variables(dimensions): 2.
%   Search domain: -100<=xi<=100, i = 1,2. 
%   Global minima: CEC17F3D2.Fit(x*) = 300
%   Global solution: Unk.
%   Get bounds: [low,up,dims] = CEC17F3D2.Bounds(i);

classdef CEC17F3D2
   methods(Static)
        function [fit] = Fit(x,checkBounds)
            if nargin==1
                checkBounds=0;
            else
                obj=CEC17F3D2();
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
            if(dim~=2)
                fit=1e+300;
            else
                fit=cec17_func(x, 3);
            end
      end
      
      function [low,up,dims] = Bounds(~) %Overwrite dimensions
         dims=2;
         low=-100;
         up=100;
         low=repmat(low,dims,1);
         up=repmat(up,dims,1);
      end
   end
end