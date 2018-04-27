clc
clear all
close all

% Global variables
Globals1D_DG;
Globals1D_MLP;

% Scalar Model
% model --> Advection, Burgers, BuckLev
model = 'Advection';

% Domain and time parameters by declaring variables
% Domain    --->  [bnd_l , bnd_r]
% bc_cond   ---> {'bc_type_left', bc_val_left, 'bc_type_right',bc_val_right}
%                  bc_types can be 'P', 'D' or 'N'
%                  bc_val is used only if bc_type is 'D'
% FinalTIme 
% CFL
% Nelem     ---> Number of cell/elements in the mesh
bnd_l     = 0.0;  
bnd_r     = 1.4;
mesh_pert = 0.0;
bc_cond   = {'P',0.0,'P',0.0};
FinalTime = 1.4;
CFL       = 0.2;
Nelem     = 100;

% Initial condition
test_name = 'Shapes';
u_IC =@(x) 10*(x-0.2).*(x>=0.2).*(x<0.3)... 
            + 10*(0.4-x).*(x>=.3).*(x<0.4)...
            + 1*(x>=.6).*(x<0.8)...
            + 100*(x-1.0).*(1.2-x).*(x>=1.0).*(x<1.2);                        

% Order of polymomials used for approximation 
N = 4;

% Troubled-cell indicator
% inidcator_type ---> minmod, TVB, NN
% TVB_M          ---> Parameter needed by TVB limiter
indicator_type = 'minmod';
indicator_type = 'TVB'; TVB_M = 10;
indicator_type = 'TVB'; TVB_M = 100;
indicator_type = 'TVB'; TVB_M = 1000;
indicator_type = 'NN';
%indicator_type = 'FuShu';

% Neural Network
nn_model      = 'MLP_v1';	

% Limiter used for reconstruction (this need not be the same as the 
% troubled-cell indicator)
% rec_limiter ---> none, minmod
rec_limiter = 'minmod';

% Plot and save parameters
plot_iter = 100;
save_soln = true;
save_ind  = true;

% Call code driver
ScalarDriver1D; 



