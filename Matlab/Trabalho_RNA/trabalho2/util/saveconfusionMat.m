function saveconfusionMat(name, m , labels)
   mx = sum(m,2) ;
   m = bsxfun(@times, 1./mx, m) *100;


   fileID = fopen(name,'w');
   nL = length(labels(:,1));
   
   fprintf(fileID,' \t');  
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
 