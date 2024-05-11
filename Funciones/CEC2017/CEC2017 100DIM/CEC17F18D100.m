%   CEC2017 Hybrid Function 8 (N=5):
%
%   Number or variables(dimensions): 100.
%   Search domain: -100<=xi<=100, i = 1,2...100. 
%   Global minima: CEC17F18D100.Fit(x*) = 1800
%   Global solution: Unk.
%   Get bounds: [low,up,dims] = CEC17F18D100.Bounds(i);
%   g1: High Conditioned Elliptic Function f1
%   g2: Ackley�s Function f13
%   g3: Rastrigin�s Function f5
%   g4: HGBat Function f18
%   g5: Discus Function f12 
%   percentage g(x) = [0.2, 0.2, 0.2, 0.2, 0.2]

classdef CEC17F18D100
   methods(Static)
        function [fit] = Fit(x,checkBounds)
            if nargin==1
                checkBounds=0;
            else
                obj=CEC17F18D100();
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
                fit=cec17_func(x, 18);
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