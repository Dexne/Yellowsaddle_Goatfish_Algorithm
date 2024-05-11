%   CEC2017 Hybrid Function 7 (N=5):
%
%   Number or variables(dimensions): 10.
%   Search domain: -100<=xi<=100, i = 1,2...10. 
%   Global minima: CEC17F17D10.Fit(x*) = 1700
%   Global solution: Unk.
%   Get bounds: [low,up,dims] = CEC17F17D10.Bounds(i);
%   g1: Katsuura Function f16
%   g2: Ackley’s Function f13
%   g3: Expanded Griewank’s plus Rosenbrock’s Function f19
%   g4: Modified Schwefel’s Function f10
%   g5: Rastrigin’s Function f5
%   percentage g(x) = [0.1, 0.2, 0.2, 0.2, 0.3]

classdef CEC17F17D10
   methods(Static)
        function [fit] = Fit(x,checkBounds)
            if nargin==1
                checkBounds=0;
            else
                obj=CEC17F17D10();
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
                fit=cec17_func(x, 17);
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