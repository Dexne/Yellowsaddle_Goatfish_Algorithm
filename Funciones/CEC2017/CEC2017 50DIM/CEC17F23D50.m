%   CEC2017 Composition Function 3 (N=4):
%
%   Number or variables(dimensions): 50.
%   Search domain: -100<=xi<=100, i = 1,2...50. 
%   Global minima: CEC17F23D50.Fit(x*) = 2300
%   Global solution: Unk.
%   Get bounds: [low,up,dims] = CEC17F23D50.Bounds(i);
%   g1: Rosenbrock�s Function F4�
%   g2:	Ackley�s Function F13� 
%   g3: Modified Schwefel's Function F10�
%   g4:	Rastrigin�s Function F5�
%   Cover Range ind. = [10, 20, 30, 40] ;
%   Height ind. =  [1, 10, 1, 1];
%   Global op ind. = [0, 100, 200, 300];

classdef CEC17F23D50
   methods(Static)
        function [fit] = Fit(x,checkBounds)
            if nargin==1
                checkBounds=0;
            else
                obj=CEC17F23D50();
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
            if(dim~=50)
                fit=1e+300;
            else
                fit=cec17_func(x, 23);
            end
      end
      
      function [low,up,dims] = Bounds(~) %Overwrite dimensions
         dims=50;
         low=-100;
         up=100;
         low=repmat(low,dims,1);
         up=repmat(up,dims,1);
      end
   end
end