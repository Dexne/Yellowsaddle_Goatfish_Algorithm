%   CEC2017 Hybrid Function 5 (N=4):
%
%   Number or variables(dimensions): 30.
%   Search domain: -100<=xi<=100, i = 1,2...30. 
%   Global minima: CEC17F15D30.Fit(x*) = 1500
%   Global solution: Unk.
%   Get bounds: [low,up,dims] = CEC17F15D30.Bounds(i);
%   g1: Bent Cigar Function f1
%   g2: HGBat Function f18
%   g3: Rastrigin’s Function f5
%   g4: Rosenbrock’s Function f4
%   percentage g(x) = [0.2, 0.2, 0.3, 0.3]

classdef CEC17F15D30
   methods(Static)
        function [fit] = Fit(x,checkBounds)
            if nargin==1
                checkBounds=0;
            else
                obj=CEC17F15D30();
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
            if(dim~=30)
                fit=1e+300;
            else
                fit=cec17_func(x, 15);
            end
      end
      
      function [low,up,dims] = Bounds(~) %Overwrite dimensions
         dims=30;
         low=-100;
         up=100;
         low=repmat(low,dims,1);
         up=repmat(up,dims,1);
      end
   end
end