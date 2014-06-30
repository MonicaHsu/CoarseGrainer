function [XH] = concentrationscaler(filename,name,out,cell)
%Introduction: 
%INPUT: 
    %filename: raw 3D coordinates of a pdb file (parse pdb file using
        %pdbparse.awk)
    %num_clust: starting number of kmeans clusters
    %re: number of replicates
    %name: molecule name
    %outfile: name of defs file to write to (e.g. cytoplasm.defs)
%OUTPUT: appended defs file


file = load(filename);
L = length(file);
if not(L)
    XH = NaN;
    return
end

        total_volume = L*135/1000; 
        if total_volume <= 5,
            b = 1;
        elseif total_volume <= 14,
            b = 2;
        elseif total_volume <= 23,
            b = 3;
        elseif total_volume <= 32,
            b = 4;
        else b = 5;
        end

    %M = starting positions of centroids. (Arbitrarily close to encourage
    %gratuitous clusters to be dropped.)
[idk] = kmeans(file, b,'display','off');
%[idk, C, sumd, D] = kmeans(file, b,'emptyaction','drop','replicates',re,'display','off','distance','sqEuclidean');

    %kmeans clustering, Matlab built-in function.

radii = zeros(b,1);
cent = zeros(b,3);
kDa = zeros(b,3);

underscore = find(filename == '_');
abundance = (str2double(filename(underscore+1:underscore+5)))/100;



for z = 1:b,
        as = find(idk == z);   %finds which c-alpha atoms fall into each cluster 
        kDa(z) = length(as)*150/1000; 
        radii(z) = 7.8947*(kDa(z))^(0.3205);
end    

startfile = [out,'.start'];
outfile = [out,'.defs'];
n_sphere = length(radii);

    %da = ['MOLDEF  ', num2str(name)];
    %dlmwrite(outfile,da,'-append','delimiter','');

    vmol = 0;
for g = 1:n_sphere,
    vmol = vmol + (4/3)*pi*(radii(g)^3);
end

    XH = round((abundance*((cell*2)^3))./(vmol));

    if isnan(XH)
        return
    end

    displace = -cell + (cell*2).*rand;

    
for g = 1:n_sphere,
    dom = ['domain',num2str(g)];
    %da = ['  SPHERE ',dom,' ',num2str(round(radii(g)))];

    %dlmwrite(outfile,da,'-append','delimiter','');
    
    %for pai = 1:XH,
              %  da = [name,' ',dom,' ',num2str(round(cent(g,:)+displace))];
               % dlmwrite(startfile,da,'-append','delimiter','');
    %end
    
    if n_sphere > 1,
        for p = 1:n_sphere
            if p > g,
                xdo = ['domain',num2str(p)];
                ldo = (sqrt(((cent(p,1) - cent(g,1))^2) + ((cent(p,2) - cent(g,2))^2) + ((cent(p,3) - cent(g,3))^2)));
              %  da = ['  BOND ',dom,' ',xdo,' ','0.03 ',num2str(ldo)];
          %      dlmwrite(outfile,da,'-append','delimiter','');           
            end
        end
    end
    
    if n_sphere > 2,
    
    for ga = 3:n_sphere;
        
        if g > 2,
        one = ['domain',num2str(ga-2)];
        two = ['domain',num2str(ga-1)];
        three = ['domain',num2str(ga)];
        
        points = [cent(ga-2,:)
            cent(ga-1,:)
            cent(ga,:)];
        
        ang = (180/pi*anglePoints3d(points));
 %       da = ['  ANGL ',one,' ',two,' ',three,' 0.1 ',num2str(ang)];
      %  dlmwrite(outfile,da,'-append','delimiter','');
        one = ['domain',num2str(ga-1)];
        two = ['domain',num2str(ga-2)];
        three = ['domain',num2str(ga)];       
        points = [cent(ga-1,:)
            cent(ga-2,:)
            cent(ga,:)];
        
        ang = (180/pi*anglePoints3d(points));       

%        da = ['  ANGL ',one,' ',two,' ',three,' 0.1 ',num2str(ang)];
  %      dlmwrite(outfile,da,'-append','delimiter','');
                
        one = ['domain',num2str(ga-1)];
        two = ['domain',num2str(ga)];
        three = ['domain',num2str(ga-2)];
        
        points = [cent(ga-1,:)
            cent(ga,:)
            cent(ga-2,:)];
        
        ang = (180/pi*anglePoints3d(points));
        
   %             da = ['  ANGL ',one,' ',two,' ',three,' 0.1 ',num2str(ang)];
          %      dlmwrite(outfile,da,'-append','delimiter','');
        end
    end
    end
end
%    da = 'END';
%    dlmwrite(outfile,da,'-append','delimiter','');
return
