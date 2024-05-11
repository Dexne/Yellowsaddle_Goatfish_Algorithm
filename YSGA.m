%% Yellow Saddle Goatfish Algorithm (YSGA)                                    
%       Source Paper:
%           Bernardo Morales, Daniel Zaldívar, Alma Rodríguez, Arturo Valdivia-G, Erik Cuevas and Marco Pérez-Cisneros
%           "A novel bio-inspired optimization model based on Yellow Saddle Goatfish behavior"
%           https://doi.org/10.1016/j.biosystems.2018.09.007
%
%       Coded by: [Tu nombre o alias]
%       Questions about the code: [Tu dirección de correo electrónico]

% Limpiamos variables y memoria
close all
clear
clc

% Le indicamos al programa el path de las funciones
if(exist('Funciones','dir')==7)
    addpath(genpath('Funciones'))
end
if(exist('Complementos','dir')==7)
    addpath(genpath('Complementos'))
end

%% Parámetros del algoritmo
MaxIt = 1000;           % Número máximo de iteraciones
dims = 50;              % Número de variables de decisión
VarSize = [1 dims];     % Tamaño de la matriz de variables de decisión
FName = 'Ackley';       % Función a optimizar
[VarMin, VarMax, dims] = GetBounds(FName, dims); % Límites de las variables
VarMin = VarMin';
VarMax = VarMax';

%% Inicialización de parámetros
nPop = 100;             % Número de individuos en la población
cantidadGrupos = 4;     % Cantidad de agrupaciones de peces

%% Inicialización
globalBest.Pos = zeros(1,dims);
globalBest.Fitness = Inf;
globalBest.Group = 0;
grupos.Pos = cell(1,cantidadGrupos);
grupos.Fitness = cell(1,cantidadGrupos);
contadorEstancamiento = zeros(1,cantidadGrupos);
posicionesTotales = zeros(nPop,dims);

% Generación aleatoria de posiciones iniciales
for i = 1:dims
    posicionesTotales(:,i) = rand(nPop,1) * (VarMax(i) - VarMin(i)) + VarMin(i);
end

% Agrupamiento utilizando K-means
[indiceGrupos, ~] = kmeans(posicionesTotales, cantidadGrupos);

% Guardar individuos de cada grupo en la variable "Grupos"
for i = 1:cantidadGrupos
    posicionesGrupo = posicionesTotales(indiceGrupos == i,:);
    fitnessGrupo = zeros(size(posicionesGrupo(:,1)));
    nGrupo = size(fitnessGrupo,1);
    for j = 1:nGrupo
        fitnessGrupo(j) = GetFitness(FName, posicionesGrupo(j,:));
    end
    % aplicamos ordenamiento para apoyarnos con los mejores
    [fitnessOrdenado, indicesOrdenados] = sort(fitnessGrupo, 'ascend');
    posicionesOrdenadas = zeros(size(posicionesGrupo));
    for j = 1:dims
        posicionesOrdenadas(:,j) = posicionesGrupo(indicesOrdenados,j);
    end
    grupos.Pos{1,i} = posicionesOrdenadas;
    grupos.Fitness{1,i} = fitnessOrdenado;
    
    % Actualizar el mejor individuo global de la población
    % tomamos el primero del arreglo ordenado (El primero siempre será el
    % mejor)
    fitnessLiderGrupo = fitnessOrdenado(1);
    if fitnessLiderGrupo < globalBest.Fitness
        % Si es menor ?
        globalBest.Fitness = fitnessLiderGrupo;
        globalBest.Pos = posicionesOrdenadas(1,:);
        globalBest.Group = i;
    end
end

% Declarar la variable lambda y el contador de estancamiento q
lambda = 10; % Límite para el contador de estancamiento
q = zeros(1,cantidadGrupos); % Contador de estancamiento para cada grupo

%% Ciclo principal del algoritmo YSGA
for it = 1:MaxIt
    % Para cada grupo
    for i = 1:cantidadGrupos
        %% Operador de movimiento: Persecución por el pez cazador líder
        PosicionesLider = grupos.Pos{1,i}(1,:); % Posición del líder del grupo
        PosicionesGrupo = grupos.Pos{1,i}; % Posiciones de todos los individuos del grupo

        % Calcular el parámetro Beta para el vuelo de Levy
        beta = 1.99 + (0.001 * it / (MaxIt / 10));
        if beta > 2
            beta = 2;
        end

        % Generar los pasos de Levy
        levySteps = levyStep(10, dims, beta);

        % Influencia de la posición del mejor global en el vuelo de Levy
        if norm(PosicionesLider - globalBest.Pos) ~= 0
            for j = 1:10
                levySteps(j,:) = levySteps(j,:) .* (PosicionesLider - globalBest.Pos);
                nuevasPosiciones = PosicionesLider + levySteps(j,:);
            end
        else
            for j = 1:dims
                %nuevasPosiciones(:,j) = PosicionesLider + levySteps(:,j);
                nuevasPosiciones = bsxfun(@plus, PosicionesLider, levySteps);
            end
            % Evaluar la calidad de las nuevas posiciones y actualizar el líder si es necesario
        end

        %% Operador de movimiento: Acorralamiento por los peces bloqueadores
        for j = 2:size(PosicionesGrupo, 1) % Empezamos desde el segundo individuo, ya que el primero es el líder
            alpha = -1 + it * ((-1) / MaxIt);
            b = 1;
            p = (alpha - 1) * rand + 1;
            D = zeros(1, dims);
            for k = 1:dims
                r = (rand * 2 - 1);
                D(k) = abs(PosicionesLider(k) * r - PosicionesGrupo(j,k)); 
            end
            nuevasPosiciones = D .* exp(b .* p) .* cos(p .* 2 * pi) + PosicionesLider;
            % Evaluar la calidad de las nuevas posiciones y actualizar el individuo si es necesario
        end
        
        % Evaluar la calidad de las nuevas soluciones
        nuevasCalidades = zeros(size(nuevasPosiciones,1),1);
        for j = 1:size(nuevasPosiciones,1)
            nuevasCalidades(j) = GetFitness(FName, nuevasPosiciones(j,:));
        end
        
        % Actualizar el mejor individuo global de cada grupo
        mejorCalidadNueva = min(nuevasCalidades);
        mejorIndiceNueva = find(nuevasCalidades == mejorCalidadNueva, 1);
        if mejorCalidadNueva < grupos.Fitness{1,i}(1)
            grupos.Fitness{1,i}(1) = mejorCalidadNueva;
            grupos.Pos{1,i}(1,:) = nuevasPosiciones(mejorIndiceNueva,:);
            
            % Actualizar el mejor individuo global si es necesario
            if mejorCalidadNueva < globalBest.Fitness
                globalBest.Fitness = mejorCalidadNueva;
                globalBest.Pos = nuevasPosiciones(mejorIndiceNueva,:);
                globalBest.Group = i;
            end
        end
        
        %% Operador de movimiento: Cambio de roles
        % Este operador se ejecuta automáticamente al actualizar al pez que tiene la mejor calidad de solución en cada iteración.
        % No se requiere implementación adicional.
        
        %% Operador de movimiento: Cambio de zona
        % Este operador se ejecuta después del movimiento de persecución del pez cazador líder, si ningún movimiento resulta en una mejor solución.
        % Se incrementa un contador de estancamiento y cuando este llega a un cierto límite, se realiza el cambio de zona.
        % La implementación se hace al final del ciclo principal del algoritmo.

        % Incrementar el contador de estancamiento si no se encontró una mejor solución
        if mejorCalidadNueva == grupos.Fitness{1,i}(1)
            q(i) = q(i) + 1;
        end

        if q(i) > lambda % Donde q es el contador de estancamiento y lambda es el límite
            % Ejecutar el cambio de zona para el grupo i
            for j = 1:dims
                PosicionesGrupo(:,j) = (globalBest.Pos(j) + PosicionesGrupo(:,j)) / 2;
            end
            q(i) = 0; % Reiniciar el contador de estancamiento
        end
    end
end

%% Mostrar resultados
fprintf('Mejor valor encontrado: %f\n', globalBest.Fitness);

%% <------ COMPARACIÓN DE RESULTADOS ------>
%% Valor obtenido por el profesor (archivo base sin modificar):
% 20.9525
%% Versión mia del algoritmo:
% 20.273820