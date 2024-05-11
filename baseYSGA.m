
%% Yellow Saddle Goatfish Algorithm (YSGA)                                    
%       Source Paper:
%           Bernardo Morales, Daniel Zaldívar, Alma Rodríguez, Arturo Valdivia-G, Erik Cuevas and Marco Pérez-Cisneros
%           "A novel bio-inspired optimization model based on Yellow Saddle Goatfish behavior"
%           https://doi.org/10.1016/j.biosystems.2018.09.007
%
%       Coded by: Bernardo Morales
%       Questions about the code: jb.moralescastaneda@gmail.com 

close all
clear
clc

if(exist('Funciones','dir')==7)
    addpath(genpath('Funciones'))
end
if(exist('Complementos','dir')==7)
    addpath(genpath('Complementos'))
end

% Se definen las iteraciones, dimensiones, límites y función a optimizar

MaxIt=1000;      % Maximum Number of Iterations
dims=50;            % Number of Decision Variables
VarSize=[1 dims];   % Decision Variables Matrix Size
FName = 'Ackley';
[VarMin,VarMax,dims] = GetBounds(FName,dims);
VarMin = VarMin';
VarMax = VarMax';

%% Inicialización de parámetros

nPop = 100;        % Número de agentes de búsqueda
cantidadGrupos = 4;         % Cantidad de agrupaciones de peces

%% Inicialización

% Variable para almacenar el mejor individuo global
globalBest.Pos = zeros(1,dims);
globalBest.Fitness = Inf;
globalBest.Group = 0;

% Variable "grupos" que contendrá posiciones y fitness de cada grupo
grupos.Pos = cell(1,cantidadGrupos);
grupos.Fitness = cell(1,cantidadGrupos);

% Contador de estancamiento para cambio de zona
contadorEstancamiento = zeros(1,cantidadGrupos);

% Variable para guardar las posiciones iniciales antes de agruparlas
posicionesTotales = zeros(nPop,dims);

% Se generan las posiciones aleatoriamente en el espacio
for i=1:dims
    posicionesTotales(:,i) = rand(nPop,1)*(VarMax(i)-VarMin(i))+VarMin(i);
end

% Utilizando K-means, se crean las agrupaciones
[indiceGrupos,~] = kmeans(posicionesTotales,cantidadGrupos);

% Se guardan los individuos de cada grupo en la variable "Grupos"
for i=1:cantidadGrupos
    % Se extraen de las posiciones totales, las posiciones de cada grupo
    posicionesGrupo = posicionesTotales(indiceGrupos==i,:);

    % Se evaluan las posiciones para obtener la calidad de cada una
    fitnessGrupo = zeros(size(posicionesGrupo(:,1)));
    nGrupo = size(fitnessGrupo,1);
    for j = 1:nGrupo
        fitnessGrupo(j) = GetFitness(FName,posicionesGrupo(j,:));
    end

    % Se realiza el ordenamiento de acuerdo a la calidad de las soluciones
    [fitnessOrdenado,indicesOrdenados]=sort(fitnessGrupo, 'ascend');
    posicionesOrdenadas = zeros(size(posicionesGrupo));
    for j=1:dims
        posicionesOrdenadas(:,j) = posicionesGrupo(indicesOrdenados,j);
    end

    % Se guardan las posiciones y calidades ordenadas en la variable "Grupos"
    grupos.Pos{1,i} = posicionesOrdenadas;
    grupos.Fitness{1,i} = fitnessOrdenado;

    %% Ejemplo manejo de celdas:
    % Se extrae de un grupo específico el vector que contiene las
    % posiciones con la función "cell2mat"
    posicionesExtraidas = cell2mat(grupos.Pos(1,i));

    % Se extrae también el vector que contiene los fitness 
    fitnessExtraidos = cell2mat(grupos.Fitness(1,i));

    % Gracias al ordenamiento, la primera posición corresponde al lider
    fitnessLiderGrupo = fitnessExtraidos(1);
    
    % Se actualiza el mejor individuo global de la población
    if fitnessLiderGrupo(1) < globalBest.Fitness
        globalBest.Fitness = fitnessLiderGrupo(1);
        globalBest.Pos = posicionesExtraidas(1,:);
        globalBest.Group = i;
    end
end

%% Ejemplo de manejo de celdas en Matlab:
% Se accede directamente en la celda de grupos a la posición y 
% fitness del individuo "5" del grupo "2"
grupos.Pos{1,2}(5,:)
grupos.Fitness{1,2}(5)

%% YSGA ciclo principal

for it=1:MaxIt
    
end