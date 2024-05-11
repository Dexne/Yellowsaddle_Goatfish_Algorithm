%   Pressure Vessel Design problem:
%
%   A cylindrical vessel is capped at both ends by hemispherical heads.
%   The objective is to minimize the total cost (material, forming and
%   welding).
%   The variables are the thickness of the pressure vessel(x1), the
%   thickness of the head (x2), the inner radius of the vessel(x3) and the
%   length of the cylindrical component(x4).
%   Fit represent the total cost in dollars.

classdef RecipientePresion
    methods(Static)
        
      function [fit] = Fit(x,checkBounds)
            if nargin==1
                checkBounds=0;
            else
                obj=RecipientePresion();
            end
            [f, c]= size(x);
            if f > c
                x=x';
            end
            if checkBounds==true
                if (CheckFunctionsBounds(x,obj)==1)
                    fit=1e+300;
                    return;
                end
            end
            
            dim=length(x);
            if(dim~=4)
                fit=1e+300;
                return;
            end
            x=round(x);
            Constrains=0;
            
            low = [0; 0; 10; 10];
            up = [100; 100; 200; 200];

            g(1) = -1*x(1)+0.0193*x(3);
            g(2) = -1*x(2) +0.00954*x(3);  
            g(3) = (-1*pi*x(3)^2*x(4))-( 4/3*pi*x(3)^3 )+1296000;
            g(4) = x(4)-240; 
            g(8) = x(1)<low(1) || x(2)<low(2) || x(3)<low(3) || x(4)<low(4); %side constrains
            g(9) = x(1)>up(1) || x(2)>up(2) || x(3)>up(3) || x(4)>up (4); %side constrains
            
            g=g>0;

            if sum(g)>0
                Constrains = Constrains+1;
            end
            
            if Constrains == 0
                fit=0.6224*x(1)*x(3)*x(4)+1.7781*x(2)*x(3)^2+3.1661*x(1)^2*x(4)+19.84*x(1)^2*x(3);
            else
                fit = 1e+300;
            end
        end
        
        function [low,up,dims] = Bounds(~) %Get dimensions
            dims=4;
            low = [0; 0; 10; 10];
            up = [100; 100; 200; 200];
        end
        
    end
end