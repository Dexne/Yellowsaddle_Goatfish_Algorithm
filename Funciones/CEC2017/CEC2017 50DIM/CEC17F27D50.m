%   CEC2017 Composition Function 7 (N=6):
%
%   Number or variables(dimensions): 50.
%   Search domain: -100<=xi<=100, i = 1,2...50. 
%   Global minima: CEC17F27D50.Fit(x*) = 2700
%   Global solution: Unk.
%   Get bounds: [low,up,dims] = CEC17F27D50.Bounds(i);
%   g1: HGBat Function F18’
%   g2: Rastrigin’s Function F5’
%   g3: Modified Schwefel's Function F10’
%   g4: Bent-Cigar Function F11’
%   g5: High Conditioned Elliptic Function F11’
%   g6: Expanded Scaffer’s F6 Function F6’
%   Cover Range ind. = [10, 20, 30, 40, 50, 60] ;
%   Height ind. = [10, 10, 2.5, 1e-26, 1e-6, 5e-4] 
%   Global op ind. =[0, 100, 200, 300, 400, 500];

classdef CEC17F27D50
   methods(Static)
        function [fit] = Fit(x,checkBounds)
            if nargin==1
                checkBounds=0;
            else
                obj=CEC17F27D50();
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
                fit=cec17_func(x, 27);
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