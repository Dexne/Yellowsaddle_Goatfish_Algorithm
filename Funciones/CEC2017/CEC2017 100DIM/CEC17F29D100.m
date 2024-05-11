%   CEC2017 Composition Function 9 (N=3):
%
%   Number or variables(dimensions): 100.
%   Search domain: -100<=xi<=100, i = 1,2...100. 
%   Global minima: CEC17F29D100.Fit(x*) = 2900
%   Global solution: Unk.
%   Get bounds: [low,up,dims] = CEC17F29D100.Bounds(i);
%   g1: Hybrid Function 5 F5’
%   g2: Hybrid Function 6 F6’
%   g3: Hybrid Function 7 F7’
%   Cover Range ind. = [10, 30, 50] 
%   Height ind. = [1, 1, 1]
%   Global op ind. = [0, 100, 200] 

classdef CEC17F29D100
   methods(Static)
        function [fit] = Fit(x,checkBounds)
            if nargin==1
                checkBounds=0;
            else
                obj=CEC17F29D100();
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
            if(dim~=100)
                fit=1e+300;
            else
                fit=cec17_func(x, 29);
            end
      end
      
      function [low,up,dims] = Bounds(~) %Overwrite dimensions
         dims=100;
         low=-100;
         up=100;
         low=repmat(low,dims,1);
         up=repmat(up,dims,1);
      end
   end
end