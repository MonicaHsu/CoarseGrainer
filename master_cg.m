%MASTER_CG creates a .start and .defs file for a concentration-scaled,
%coarse-grained cytoplasm. 

addpath('parsed/');
CONC = load('CONC.txt');
ala = ones(209,1);
for i = 1:209, 
    filename = [num2str(i),'_',num2str(CONC(i)),'.pdb.txt'];
    [HX] = concentrationscaler(filename,num2str(i),'f',189); %f is a scrap file.
    ala(i) = HX;    disp(HX);
end

CONC = load('CONC.txt'); 
COUNT = 10; %This is for the start file (start numbering molecules @ 10)
ff = 'test'; %name for the job.
for i = 1:209,
    d = [i ala(i)];
    filename = [num2str(i),'_',num2str(CONC(i)),'.pdb.txt'];
    [COUNT] = cg(filename,num2str(i),ff,200,ala(i),COUNT);
end