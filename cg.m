function [COUNT] = cg(filename,name,out,cell,ala,COUNT)
%CG creates coarse grain models from coordinate files
%   filename = raw x,y,z cooordinates of alpha carbons from a protein structure
%   name = molecule name
%   out = filenames to write to
%   cell = box size to place molecules
%   ala = array containing number of molecules of each type scaled by their
%   concentrations
%   COUNT = molecule counter (input and output)

file = load(filename);
L = length(file); %number of amino acids

if not(L)
    disp(['Error: empty coordinate file for ',name]);
    return
end

        MW = L*135/1000; %rough MW in kDa
        if MW <= 5,
            b = 1; %number of clusters (b) determined by molecular weight
        elseif MW <= 14,
            b = 2;
        elseif MW <= 23,
            b = 3;
        elseif MW <= 32,
            b = 4;
        else b = 5;
        end

[idk, C] = kmeans(file, b,'display','off'); %kmeans clustering, which 
%returns 1) an L-by-1 vector idk containing the cluster indices of each 
%point, and 2) the b cluster centroid locations in the b-by-3 matrix C.

radii = zeros(b,1);
kDa = zeros(b,3);

if isnan(ala),
    disp(['Error: no proteins placed for ',name]);
    return
elseif ala,

%%%This is a way to get an even starting distribution of proteins in the
%cell, but probably not the best way:
x = 1:cell;    
%oda = x.^(2)./((cell)^2); %function for distribution of proteins' displacements...
y = zeros(ala,3);
for ap = 1:ala,
    y(ap,:) = -cell/2 + (cell/2 + cell/2)*rand(1,3); %randsample(cell,3,true,oda);
    u = randsample(2,1);
end
if u == 1,
    displace = -y; %y = number of angrstroms to displace the protein
else displace = y; 
end
%%%
else return
end

%From the size of each cluster, determine the radius from the specific
%volume of protein.
    for cluster = 1:b,
        residues = find(idk == cluster);
        
        tempV = length(residues)*(3e-22)*(1); %in cm^3
        
        radii(cluster) = (((tempV)*(3/4)*(1/pi)).^(1/3))*(1e8);
    end    

   
    
%The rest is for printing to files...
startfile = [out,'.start'];
outfile = [out,'.defs'];
n_sphere = length(radii);

    da = ['MOLDEF  ', num2str(name)];
    dlmwrite(outfile,da,'-append','delimiter','');

for aaa = 1:ala,
    COUNT = COUNT + 1;

    for g = 1:n_sphere,
            dom = ['domain',num2str(g)];
            xD=displace(aaa,1);
            yD=displace(aaa,2);
            zD=displace(aaa,3);
            
                da = [num2str(COUNT), ' ',name,' ',dom,' ',num2str((C(g,1)+xD)),' ',num2str((C(g,2)+yD)),' ',num2str((C(g,3)+ zD))];
                dlmwrite(startfile,da,'-append','delimiter','');
    end
end
    
for g = 1:n_sphere,
    dom = ['domain',num2str(g)];
    da = ['  SPHERE ',dom,' ',num2str(round(radii(g)))];

    dlmwrite(outfile,da,'-append','delimiter','');
    if n_sphere > 1,
        for p = 1:n_sphere
            if p > g,
                xdo = ['domain',num2str(p)];
                ldo = round(sqrt(((C(p,1) - C(g,1))^2) + ((C(p,2) - C(g,2))^2) + ((C(p,3) - C(g,3))^2)));
                da = ['  BOND ',dom,' ',xdo,' ','0.03 ',num2str(ldo)];
                dlmwrite(outfile,da,'-append','delimiter','');           
            end
        end
    end
end
    if n_sphere > 2,
    
    for ga = 3:n_sphere;
        
        if g > 2,
        one = ['domain',num2str(ga-2)];
        two = ['domain',num2str(ga-1)];
        three = ['domain',num2str(ga)];
        
        points = [C(ga-2,:)
            C(ga-1,:)
            C(ga,:)];
        
        ang = round(180/pi*anglePoints3d(points));
        da = ['  ANGL ',one,' ',two,' ',three,' 0.003 ',num2str(ang)];
        dlmwrite(outfile,da,'-append','delimiter','');
        one = ['domain',num2str(ga-1)];
        two = ['domain',num2str(ga-2)];
        three = ['domain',num2str(ga)];       
        points = [C(ga-1,:)
            C(ga-2,:)
            C(ga,:)];
        
        ang = round(180/pi*anglePoints3d(points));       

        da = ['  ANGL ',one,' ',two,' ',three,' 0.003 ',num2str(ang)];
        dlmwrite(outfile,da,'-append','delimiter','');
                
        one = ['domain',num2str(ga-1)];
        two = ['domain',num2str(ga)];
        three = ['domain',num2str(ga-2)];
        
        points = [C(ga-1,:)
            C(ga,:)
            C(ga-2,:)];
        
        ang = round(180/pi*anglePoints3d(points));
        
                da = ['  ANGL ',one,' ',two,' ',three,' 0.003 ',num2str(ang)];
                dlmwrite(outfile,da,'-append','delimiter','');
        end
    end
    end

    da = 'END';
    dlmwrite(outfile,da,'-append','delimiter','');
return