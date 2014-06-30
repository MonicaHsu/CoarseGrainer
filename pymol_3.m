function pymol_3(filename, NM,N_FRAME,box,start_F,v)
%filename = 'genome.snaps.txt'
%NM = 632
%N_FRAME = 400
%box = 5000

    file = load(filename);
    outfile = [filename,'.seg'];
    [LSD] = size(file);
    
%         for f = 1:LSD(1);
%         while (file(f,2)) > box/2,
%             file(f,2) = file(f,2) - box;
%         end
%         while (file(f,2)) < -box/2,
%             file(f,2) = file(f,2) + box;
%         end
% 
%         while (file(f,3)) > box/2,
%             file(f,3) = file(f,3) - box;
%         end
%         while (file(f,3)) < -box/2,
%             file(f,3) = file(f,3) + box;
%         end
%         
%         while (file(f,4)) > box/2,
%             file(f,4) = file(f,4) - box;
%         end
%         while (file(f,4)) < -box/2,
%             file(f,4) = file(f,4) + box;
%         end
%         end


    da = 'from pymol.cgo import *';
    dlmwrite(outfile,da,'-append','delimiter','');
    da = 'from pymol import cmd';
    dlmwrite(outfile,da,'-append','delimiter','');
    c_mix = num2str((-1)*box/2);
    c_max = box/2;
    da = 'box = [';
    dlmwrite(outfile,da,'-append','delimiter','');
    da = '   LINEWIDTH, 3.0,';
    dlmwrite(outfile,da,'-append','delimiter','');
    da = '   BEGIN, LINES,';
    dlmwrite(outfile,da,'-append','delimiter','');
    da = '   COLOR, 0, 0, 0,';
    dlmwrite(outfile,da,'-append','delimiter','');
    da = ['   VERTEX,   ',num2str(c_max),', ',num2str(c_max),', ',num2str(c_max),','];
    dlmwrite(outfile,da,'-append','delimiter','');
    da = ['   VERTEX,   ',num2str(c_max),', ',num2str(c_mix),', ',num2str(c_max),','];
    dlmwrite(outfile,da,'-append','delimiter','');
    da = ['   VERTEX,   ',num2str(c_max),', ',num2str(c_max),', ',num2str(c_max),','];
    dlmwrite(outfile,da,'-append','delimiter','');
    da = ['   VERTEX,   ',num2str(c_max),', ',num2str(c_max),', ',num2str(c_mix),','];
    dlmwrite(outfile,da,'-append','delimiter','');
    da = ['   VERTEX,   ',num2str(c_max),', ',num2str(c_max),', ',num2str(c_max),','];
    dlmwrite(outfile,da,'-append','delimiter','');
    da = ['   VERTEX,   ',num2str(c_mix),', ',num2str(c_max),', ',num2str(c_max),','];
    dlmwrite(outfile,da,'-append','delimiter','');
    da =    '   COLOR, 0, 0, 0,';
    dlmwrite(outfile,da,'-append','delimiter','');
    da = ['   VERTEX,   ',num2str(c_mix),', ',num2str(c_mix),', ',num2str(c_mix),','];
    dlmwrite(outfile,da,'-append','delimiter','');
    da = ['   VERTEX,   ',num2str(c_mix),', ',num2str(c_max),', ',num2str(c_mix),','];
    dlmwrite(outfile,da,'-append','delimiter','');
    da = ['   VERTEX,   ',num2str(c_mix),', ',num2str(c_mix),', ',num2str(c_mix),','];
    dlmwrite(outfile,da,'-append','delimiter','');
    da = ['   VERTEX,   ',num2str(c_mix),', ',num2str(c_mix),', ',num2str(c_max),','];
    dlmwrite(outfile,da,'-append','delimiter','');
    da = ['   VERTEX,   ',num2str(c_mix),', ',num2str(c_mix),', ',num2str(c_mix),','];
    dlmwrite(outfile,da,'-append','delimiter','');
    da = ['   VERTEX,   ',num2str(c_max),', ',num2str(c_mix),', ',num2str(c_mix),','];
    dlmwrite(outfile,da,'-append','delimiter','');
    da =    '   COLOR, 0, 0, 0,';
    dlmwrite(outfile,da,'-append','delimiter','');
    da = ['   VERTEX,   ',num2str(c_max),', ',num2str(c_mix),', ',num2str(c_max),','];
    dlmwrite(outfile,da,'-append','delimiter','');
    da = ['   VERTEX,   ',num2str(c_mix),', ',num2str(c_mix),', ',num2str(c_max),','];
    dlmwrite(outfile,da,'-append','delimiter','');
    da = ['   VERTEX,   ',num2str(c_max),', ',num2str(c_mix),', ',num2str(c_max),','];
    dlmwrite(outfile,da,'-append','delimiter','');
    da = ['   VERTEX,   ',num2str(c_max),', ',num2str(c_mix),', ',num2str(c_mix),','];
    dlmwrite(outfile,da,'-append','delimiter','');
    da = ['   VERTEX,   ',num2str(c_max),', ',num2str(c_max),', ',num2str(c_mix),','];
    dlmwrite(outfile,da,'-append','delimiter','');
    da = ['   VERTEX,   ',num2str(c_mix),', ',num2str(c_max),', ',num2str(c_mix),','];
    dlmwrite(outfile,da,'-append','delimiter','');
    da = ['   VERTEX,   ',num2str(c_max),', ',num2str(c_max),', ',num2str(c_mix),','];
    dlmwrite(outfile,da,'-append','delimiter','');
    da = ['   VERTEX,   ',num2str(c_max),', ',num2str(c_mix),', ',num2str(c_mix),','];
    dlmwrite(outfile,da,'-append','delimiter','');
    da = ['   VERTEX,   ',num2str(c_mix),', ',num2str(c_max),', ',num2str(c_max),','];
    dlmwrite(outfile,da,'-append','delimiter','');
    da = ['   VERTEX,   ',num2str(c_mix),', ',num2str(c_max),', ',num2str(c_mix),','];
    dlmwrite(outfile,da,'-append','delimiter','');
    da = ['   VERTEX,   ',num2str(c_mix),', ',num2str(c_max),', ',num2str(c_max),','];
    dlmwrite(outfile,da,'-append','delimiter','');
    da = ['   VERTEX,   ',num2str(c_mix),', ',num2str(c_mix),', ',num2str(c_max),','];
    dlmwrite(outfile,da,'-append','delimiter','');
    da =    '   END';
    dlmwrite(outfile,da,'-append','delimiter','');
    da =    '   ]';
    dlmwrite(outfile,da,'-append','delimiter','');


t = 0;
framN= 1;

for F = start_F:10:N_FRAME, %[start_F:10:round(1000/4), round(1000/4):100:N_FRAME],
    
if length(file) >= (NM*(F-1)+1),
            
    disp(F)
    da = [   '#FRAME','    ', num2str(framN)];
    dlmwrite(outfile,da,'-append','delimiter','');

    da = 'atoms = [';
    dlmwrite(outfile,da,'-append','delimiter','');

    t = t + 1;
    count = 1;
    CI = 1;
    
    for N = 1:NM,
        
        str = file(NM*(F-1)+N,1);
        x = file(NM*(F-1)+N,2);
        y = file(NM*(F-1)+N,3);
        z = file(NM*(F-1)+N,4);
        d = file(NM*(F-1)+N,5);

            da = ['   COLOR,    ',num2str(v(str,1)),',    ',num2str(v(str,2)),',    ',num2str(v(str,3)),','];
            dlmwrite(outfile,da,'-append','delimiter','');
            da = ['   SPHERE',',',' ',num2str(x),',', num2str(y),',', num2str(z),',', num2str(d),','];
            dlmwrite(outfile,da,'-append','delimiter','');            
            count = count + 1;
            
        if count == 7,
            count = 1;
            CI = CI+1;
        end
        
    end
    
    da = '   ]';
    dlmwrite(outfile,da,'-append','delimiter','');
    da =     'obj = box + atoms';
    dlmwrite(outfile,da,'-append','delimiter','');
    da = [    'cmd.load_cgo(obj,','''',filename,'''',',','   ',num2str(framN),')'];
    dlmwrite(outfile,da,'-append','delimiter','');
        else return
end

%         if rem(F,50) == 0,
%             user_entry = input('continue? (1/0)');
%             if user_entry == 0,
%                 return
%             end
%         end

framN=framN+1;
end
end