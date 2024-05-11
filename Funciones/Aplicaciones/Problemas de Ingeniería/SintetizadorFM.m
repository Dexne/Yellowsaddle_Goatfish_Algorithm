%   Parameter estimation for FM synthesizers problem:
%
%   An fM synthesizer is a device witch purpose to generate a sound similar to other target sound
%   Fit represents the error between signals.
%   More info can be obtained from chapter 6.1 on https://doi.org/10.1016/j.asoc.2017.08.012
%   Even x represent amplitude and odd represent angular frecuency

classdef SintetizadorFM
    methods(Static)
        function [fit] = Fit(x,checkBounds)
            if nargin==1
                checkBounds=0;
            else
                obj=SintetizadorFM();
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
            if(dim~=6)
                fit=1e+300;
                return;
            end
            x=round(x);
            Constrains=0;
            
            low = -6.4;
            up = 6.35;

            g(1) = x(1)<low || x(2)<low || x(3)<low || x(4)<low || x(5)<low || x(6)<low; %side constrains
            g(2) = x(1)>up || x(2)>up || x(3)>up || x(4)>up || x(5)>up || x(6)>up; %side constrains
            
            g=g>0;

            if sum(g)>0
                Constrains = Constrains+1;
            end
            
            if Constrains == 0
                theta=2*pi/100;
                fit=0;
                for t=0:100
                    y_t=x(1)*sin(x(2)*t*theta+x(3)*sin(x(4)*t*theta+x(5)*sin(x(6)*t*theta)));
                    y_0_t=1*sin(5*t*theta-1.5*sin(4.8*t*theta+2*sin(4.9*t*theta)));
                    fit=fit+(y_t-y_0_t)^2;
                end
            else
                fit = 1e+300;
            end
        end
        
        function [low,up,dims] = Bounds(~) %Get dimensions
            dims = 6;
            low = -6.4;
            up = 6.35;
            low=repmat(low,dims,1);
            up=repmat(up,dims,1);
        end
        
    end
end