%   CEC2017 Composition Function 8 (N=6):
%
%   Number or variables(dimensions): 10.
%   Search domain: -100<=xi<=100, i = 1,2...10. 
%   Global minima: CEC17F28D10.Fit(x*) = 2800
%   Global solution: Unk.
%   Get bounds: [low,up,dims] = CEC17F28D10.Bounds(i);
%   g1: Ackley’s Function F13’
%   g2: Griewank’s Function F15’
%   g3: Discus Function F12’
%   g4: Rosenbrock’s Function F4’
%   g5: HappyCat Function F17’
%   g6: Expanded Scaffer’s F6 Function F6’
%   Cover Range ind. = [10, 20, 30, 40, 50, 60] 
%   Height ind. = [10, 10, 1e-6, 1, 1, 5e-4]
%   Global op ind. = [0, 100, 200, 300, 400, 500] 

classdef CEC17F28D10
   methods(Static)
        function [fit] = Fit(x,checkBounds)
            if nargin==1
                checkBounds=0;
            else
                obj=CEC17F28D10();
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
                fit=cec17_func(x, 28);
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