%   Tension/Compression Spring Design problem:
%
%   The problem consist of minimizing the weight of a tension/compression
%   spring subject to constrains of shear stress, surge frequency and minimum deflection.
%   The design variables are the mean coil diameter(x1), the wire diameter
%   (x2) and the number of active coils (x3)
%   Fit represent the weight of the spring.

classdef Resorte
    methods(Static)
        
      function [fit] = Fit(x,checkBounds)
            if nargin==1
                checkBounds=0;
            else
                obj=Resorte();
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
            if(dim~=3)
                fit=1e+300;
                return;
            end
            Constrains=0;
            
            low = [0.05; 0.25; 2];
            up = [2; 1.3; 15];

            g(1) = 1-( (x(2)^3*x(3))/(71785*x(1)^4) );
            p1=4*x(2)^2-x(1)*x(2)/12566*(x(2)*x(1)^3-x(1)^4);
            p2=1/(5108*x(1)^2);	
            g(2) = (p1+p2-1) ;
            g(3) = ( 1-( (140.45*x(1))/(x(2)^2*x(3)) ) );
            g(4) = (( (x(2)+x(1))/1.5)-1);
            g(5) = x(1)<low(1) || x(2)<low(2) || x(3)<low(3); %side constrains
            g(6) = x(1)>up(1) || x(2)>up(2) || x(3)>up(3); %side constrains
            
            g=g>0;

            if sum(g)>0
                Constrains = Constrains+1;
            end
            
            if Constrains == 0
                fit=(x(3)+2)*x(2)*x(1)^2;
            else
                fit = 1e+300;
            end
        end
        
        function [low,up,dims] = Bounds(~) %Get dimensions
            dims = 3;
            low = [0.05; 0.25; 2];
            up = [2; 1.3; 15];
        end
        
    end
end