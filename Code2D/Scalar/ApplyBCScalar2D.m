function QG = ApplyBCScalar2D(Q,time,Mesh,flag)
 
% function  QG = ApplyBCScalar2D(Q,time)
% Purpose: Set Boundary Condition in ghost elements for physical or auxiliary (gradient) variable. 

QG = zeros(Mesh.Np,Mesh.KG,1);

BC_keys = Mesh.BC_ess_flags(:,1);

% Applying BC on triangles
for k=1:length(BC_keys)
    ckey   = BC_keys(k);
    bctype = Mesh.BC_ess_flags(k,2);
    
    QBC    = BC(ckey,time);
    
    for f=1:3
        bc_ind = find(Mesh.BCTag(:,f) == ckey);
        gc_ind = Mesh.EToGE(bc_ind,f)';
        
        if(bctype==Mesh.BC_ENUM.Sym)
            if strcmp(flag,'phi')
                QG(:,gc_ind,1) = Q(Mesh.MMAP(:,f),bc_ind',1);
            else
                QG(:,gc_ind,1) = -Q(Mesh.MMAP(:,f),bc_ind',1);
            end
        elseif(bctype==Mesh.BC_ENUM.Dirichlet)
            if strcmp(flag,'phi')
                QG(:,gc_ind,1) = QBC(Mesh.xG(:,gc_ind),Mesh.yG(:,gc_ind),1); 
            else
                QG(:,gc_ind,1) = Q(Mesh.MMAP(:,f),bc_ind',1);
            end
             
        else
            error('Unknown boundary condition for Scalar problems');
        end 
    end
end


return;


