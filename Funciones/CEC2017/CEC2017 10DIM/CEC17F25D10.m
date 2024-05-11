%   CEC2017 Composition Function 5 (N=5):
%
%   Number or variables(dimensions): 10.
%   Search domain: -100<=xi<=100, i = 1,2...10. 
%   Global minima: CEC17F25D10.Fit(x*) = 2500
%   Global solution: Unk.
%   Get bounds: [low,up,dims] = CEC17F25D10.Bounds(i);
%   g1: Rastrigin’s Function F5’
%   g2: Happycat Function F17’
%   g3: Ackley Function F13’
%   g4: Discus Function F12’
%   g5: Rosenbrock’s Function F4’
%   Cover Range ind. = [10, 20, 30, 40, 50] ;
%   Height ind. =  [10, 1, 10, 1e-6, 1];
%   Global op ind. = [0, 100, 200, 300, 400] ;

classdef CEC17F25D10
   methods(Static)
        function [fit] = Fit(x,checkBounds)
            if nargin==1
                checkBounds=0;
            else
                obj=CEC17F25D10();
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
                fit=cec17_func(x, 25);
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