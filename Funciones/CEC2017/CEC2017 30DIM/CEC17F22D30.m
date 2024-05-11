%   CEC2017 Composition Function 2 (N=3):
%
%   Number or variables(dimensions): 30.
%   Search domain: -100<=xi<=100, i = 1,2...30. 
%   Global minima: CEC17F22D30.Fit(x*) = 2200
%   Global solution: Unk.
%   Get bounds: [low,up,dims] = CEC17F22D30.Bounds(i);
%   g1:	Rastrigin’s Function F5’
%   g2: Griewank’s Function F15’
%   g3: Modifed Schwefel's Function F10’ 
%   Cover Range ind. = [10, 20, 30] ;
%   Height ind. =  [1, 10, 1];
%   Global op ind. = [0, 100, 200];

classdef CEC17F22D30
   methods(Static)
        function [fit] = Fit(x,checkBounds)
            if nargin==1
                checkBounds=0;
            else
                obj=CEC17F22D30();
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
                fit=cec17_func(x, 22);
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