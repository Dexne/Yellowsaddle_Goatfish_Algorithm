%   Template Matching problem:
%
%   Find parts of an image which match to a given template

classdef TMWallE
    methods(Static)
        function [fit] = Fit(x,checkBounds)
            if nargin==1
                checkBounds=0;
            else
                obj=TMWallE();
            end
            
            FuncName='TMWallE'; 
            ImageFull=strcat(FuncName,'Given.jpg');
            ImagePart=strcat(FuncName,'T.jpg');
        
            
            if exist(strcat('Funciones/Aplicaciones/Template Matching/',FuncName,'.mat'),'file')==2
                load(strcat('Funciones/Aplicaciones/Template Matching/',FuncName,'.mat'),strcat('FunObj'))
            else
                IFull = rgb2gray(imread(ImageFull));    
                IPart = rgb2gray(imread(ImagePart));
                FunObj=normxcorr2(IPart,IFull); % Obteniendo función Objetivo
                save(strcat('Funciones/Aplicaciones/Template Matching/',FuncName,'.mat'),'FunObj')
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
            if(dim~=2)
                fit=1e+300;
                return;
            end
            Constrains=0;
            
            [r_I,c_I] = size(FunObj);
        

            low = [1;1];    % Límites inferiores del espacio de búsqueda
            up = [r_I;c_I]; % Límites superiores del espacio de búsqueda


            g(1) = x(1)<low(1) || x(2)<low(2); %side constrains
            g(2) = x(1)>up(1) || x(2)>up(2); %side constrains
            
            g=g>0;

            if sum(g)>0
                Constrains = Constrains+1;
            end
            
            if Constrains == 0
                x=round(x);
                fit=FunObj(x(1),x(2));
                if isnan(fit)
                    fit=-1e+300; %% Un fitness malo ... cuando A=0
                end
                fit=-fit;        %% Cambio a minimización
            else
                fit = 1e+300;
            end
        end 
      
        function [low,up,dims] = Bounds(~)
            FuncName='TMWallE'; 
            ImageFull=strcat(FuncName,'Given.jpg');
            ImagePart=strcat(FuncName,'T.jpg');

            if exist(strcat('Funciones/Aplicaciones/Template Matching/',FuncName,'.mat'),'file')==2
                load(strcat('Funciones/Aplicaciones/Template Matching/',FuncName,'.mat'),strcat('FunObj'))
            else
                IFull = rgb2gray(imread(ImageFull));    
                IPart = rgb2gray(imread(ImagePart));
                FunObj=normxcorr2(IPart,IFull); % Obteniendo función Objetivo
                save(strcat('Funciones/Aplicaciones/Template Matching/',FuncName,'.mat'),'FunObj')
            end 
            [r_I,c_I] = size(FunObj);
            dims=2;
            low = [1;1];             % Límites inferiores del espacio de búsqueda
            up = [r_I;c_I]; % Límites superiores del espacio de búsqueda
        end 
    end
end