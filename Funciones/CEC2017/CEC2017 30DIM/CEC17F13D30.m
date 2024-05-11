%   CEC2017 Hybrid Function 3 (N=3):
%
%   Number or variables(dimensions): 30.
%   Search domain: -100<=xi<=100, i = 1,2...30. 
%   Global minima: CEC17F13D30.Fit(x*) = 1300
%   Global solution: Unk.
%   Get bounds: [low,up,dims] = CEC17F13D30.Bounds(i);
%   g1: Bent Cigar Function f1
%   g2: Rosenbrock Function f4
%   g3: Lunache Bi-Rastrigin Function f7 
%   percentage g(x) = [ 0.3, 0.3, 0.4]

classdef CEC17F13D30
   methods(Static)
        function [fit] = Fit(x,checkBounds)
            if nargin==1
                checkBounds=0;
            else
                obj=CEC17F13D30();
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
                fit=cec17_func(x, 13);
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