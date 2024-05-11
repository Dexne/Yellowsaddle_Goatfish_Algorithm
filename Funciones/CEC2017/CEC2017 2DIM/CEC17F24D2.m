%   CEC2017 Composition Function 4 (N=4):
%
%   Number or variables(dimensions): 2.
%   Search domain: -100<=xi<=100, i = 1,2. 
%   Global minima: CEC17F24D2.Fit(x*) = 2400
%   Global solution: Unk.
%   Get bounds: [low,up,dims] = CEC17F24D2.Bounds(i);
%   g1: Ackley’s Function F13’
%   g2: High Conditioned Elliptic Function F11’
%   g3: Girewank Function F15’
%   g4: Rastrigin’s Function F5’
%   Cover Range ind. = [10, 20, 30, 40] ;
%   Height ind. =  [10, 1e-6, 10, 1];
%   Global op ind. = [0, 100, 200, 300];

classdef CEC17F24D2
   methods(Static)
        function [fit] = Fit(x,checkBounds)
            if nargin==1
                checkBounds=0;
            else
                obj=CEC17F24D2();
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
                fit=cec17_func(x, 24);
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