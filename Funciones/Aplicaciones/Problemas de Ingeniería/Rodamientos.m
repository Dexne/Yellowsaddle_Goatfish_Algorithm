%   Optimal Design of a rolling element bearing problem: https://doi.org/10.1016/j.mechmachtheory.2006.02.004
%
%   Maximization problem
%   Design parameters are internal structural sizes and other variables
%   which need to be determined in the bearing design.
%   The five design variables chosen in this problem are diameter of balls
%   (Db), mean diameter (Dm), number of balls (Z), curvature radius
%   coefficient of inner raceway groove (fi) and outer raceway groove (fo).
%   Design  constrains go from g1 to g9
%   Fit represents the dynamic load capacity
%   Best fitness is near [26678.4]
%   D	d	w	Db(mm)	Dm(mm)	Z	fi	      fo        KD min	KD max	eps     e       B       
%   80	40	18	12.41	60.00	9	0.51526	  0.51546	0.443	0.621	0.302	0.034	0.809
%   Fit above = [17140.5334273285]


classdef Rodamientos
    methods(Static)
        
      function [fit] = Fit(x,checkBounds)
            if nargin==1
                checkBounds=0;
            else
                obj=Rodamientos();
            end
            [f, c]= size(x);
            if f > c
                x=x';
            end
            if checkBounds==true
                if (CheckFunctionsBounds(x,obj)==1)
                    fit=-1e+300;
                    return;
                end
            end
            
            dim=length(x);
            if(dim~=10)
                fit=-1e+300;
                return;
            end

            Constrains=0;
            
            low=12;
            up=60;
            
            Db = x(1);      % Diameter of balls, Eq9   [8;14]
            Dm = x(2);      % Mean Diameter     47 to 73
            Z = x(3);       % Number of balls   4 to 31(Dm/Db)
            ri = x(4);      % Raddi of inner ring groove curvature  0<= ri <=7
            ro = x(5);      % Raddi of outer ring groove curvature  0<= ro <=7
            Kdmin = x(6);   % constraint constant Eq20  [0.4;0.5]
            Kdmax = x(7);   % constraint constant Eq20  [0.6;0.7]
            epsilon = x(8); % constraint constant ? Eq21 [0.3;0.35]
            e = x(9);       % constraint constant Eq21   [0.03;0.08]
            B = x(10);      % constraint constant Eq22   [0.7;0.85]
            
            fi = ri/Db;     % Curvature radius cofficient of inner raceway groove
            fo = ro/Db;     % Curvature radius cofficient of outer raceway groove
            gamma = Db/Dm;  
            fc1 = 37.91*(1+(1.04*((1-gamma)/(1+gamma)).^1.72)*((fi*(2*fo-1)/fo*(2*fi-1)).^0.41).^(10/3)).^-0.3;
            fc2 = (gamma.^0.3*(1-gamma).^1.39)/((1+gamma).^(1/3));
            fc3 = ((2*fi)/(2*fi-1)).^0.41;
            fc = fc1+fc2+fc3;
            D=80;
            d=40;
            w=18;
            T=(D-d-2*Db)/4;
            U=(D-d)/2-3*T;
            phi=2*pi-2*acos((U.^2+(D/2-T-Db).^2-(d/2+T).^2)/(2*U*(D/2-T-Db))); % Maximum tolerable assembly angle
            di=((D-d)/2-Db)*2+d;   % 52  to  64
            do=di+Db*2;     %  68 to 92
            
            
            low = [8;47;4;0;0;0.4;0.6;0.3;0.03;0.7];
            up = [14;73;31;7;7;0.5;0.7;0.35;0.08;0.85];
            
            g(1) = phi/(2*asin(Db/Dm))-Z+1<0;
            g(2) = 2*Db-Kdmin*(D-d)<0;
            g(3) = Kdmax*(D-d)-2*Db<0;
            g(4) = Dm-(0.5-e)*(D+d)<0;
            g(5) = (0.5+e)*(D+d)-Dm<0;
            g(6) = ((di-d)/2)-((D-do)/2)<0; %di & do unkw
            g(7) = 0.5*(D-Dm-Db)-epsilon*Db<0;
            g(8) = B*w-Db<0;
            g(9) = fi<0.515;
            g(10) = fo<0.515;   
            g(11) = 0;% lower side constrains
            for i=1:length(up)
                if (x(i)<low(i))
                    g(11)=1;
                    break;
                end
            end
            g(12) = 0;% upper side constrains
            for i=1:length(up)
                if (x(i)>up(i))
                    g(12)=1;
                    break;
                end
            end
            
            g=g>0;

            if sum(g)>0
                Constrains = Constrains+1;
            end
            
            if Constrains == 0
                if Db<=25.4
                    fit = -fc*Z.^(2/3)*Db.^1.8;
                else
                    fit = -3.647*fc*Z.^(2/3)*Db.^1.4;
                end
                fit = -fit;%Maximize
            else
                fit = -1e+300;
                fit = -fit;%Maximize
            end
        end
        
        function [low,up,dims] = Bounds(~) %Get dimensions
            dims=10;
            low = [8;47;4;0;0;0.4;0.6;0.3;0.03;0.7];
            up = [14;73;31;7;7;0.5;0.7;0.35;0.08;0.85];
        end
        
    end
end