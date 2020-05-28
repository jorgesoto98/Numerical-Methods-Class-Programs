clear
function MATRIZ = ELIMINACIONGAUSS();
    
    //Pedir numero de renglones
    r = input("Cuantos renglones quieres? ")
    
    //Pedir numero de columnas
    c = input ("Cuantas columnas quieres? ")
    
    fact = 0;
    X(r) = 0;
    
    //Ciclo para recabar datos dentro de matriz
    for i = 1 : r
        for j = 1 : c
            MATRIZ (i,j) = input ("Da el elemento: [" + string (i) + "," + string(j) + "]: ")
        end
    end
    
    for i = 1 : (r-1)
        fact = MATRIZ (i,i)
        for k = (i+1) : r
            
            firstrow = MATRIZ (k,i)
            MATRIZ (k, : ) =  MATRIZ(k, : ) - (MATRIZ(i, : )/fact) * firstrow
            
         end
    end
    
    disp ("Matriz despues de elimacion de Gauss:")
    disp (MATRIZ)
    
    
endfunction

ELIMINACIONGAUSS;
