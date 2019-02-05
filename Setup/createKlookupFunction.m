function createKlookupFunction(K)

    fid = fopen('k_lookup.m','w');
    
    fprintf(fid,"function K = k_lookup(v,vmin,vmax)\n\n");
    fprintf(fid,"%% Auto generated lookup function\n\n");
    
    n = size(K,3);
    
    fprintf(fid,"n = %d;\n",n);
    fprintf(fid,"K_L = [\n");
    for i = 1:n
        fprintf(fid,"\t%f %f %f %f %f\n",K(1,1,i),K(1,2,i),K(1,3,i),K(1,4,i),K(1,5,i));
        fprintf(fid,"\t%f %f %f %f %f\n",K(2,1,i),K(2,2,i),K(2,3,i),K(2,4,i),K(2,5,i));
    end
    fprintf(fid,"];\n\n");
    
    fprintf(fid,"if v <= vmin\n");
    fprintf(fid,"\tindex = 1;\n");
    fprintf(fid,"elseif v >= vmax\n");
    fprintf(fid,"\tindex = n-1;\n");
    fprintf(fid,"else\n");
    fprintf(fid,"\tindex = floor(n/2*(v-vmin)/(vmax-vmin))*2+1;\n");
    fprintf(fid,"end\n");
    fprintf(fid,"K = K_L(index:index+1,:);\n");
    
    
    fclose(fid);



end