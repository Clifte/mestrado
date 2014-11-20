function saveconfusionMat(name, m , labels)
   fileID = fopen(name,'w');
   nL = length(labels(:,1));
   
   fprintf(fileID,'X\t');  
   for i=1:nL
       fprintf(fileID,'%s\t', labels(i,:));  
   end
   
   
   fprintf(fileID,'\n');
   for i=1:nL
	   fprintf(fileID,'%s\t', labels(i,:));
	   fprintf(fileID,'%2.2f\t',m(i,:));
       fprintf(fileID,'\n');
   end
fclose(fileID);
end
 