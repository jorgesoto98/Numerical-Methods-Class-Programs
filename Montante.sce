clear 

//  Jorge Miguel Soto Rodriguez     A01282936
//  Jose Peart Lozano               A00819709

//Programa pra resolver sistema de ecuaciones por el metodo de Montante



//Funcion para pedir los valores de la matriz
  function  MATRIZ  =  PidoValores  ()
           // pido el numero de renglones
            r  =  input  (  "¿Cuantos renglones quieres?"  )
            // pido el numero de colummnas
            c  =  input  (  "¿Cuantas columnas quieres?"  )
            // para cada renglon     
            for  i  =  1  :  r
                 // para cada columna
                 for  j  =  1  :  c
                        // con string(i) puedo desplegar que elemento estoy pidiendo
                        MATRIZ  (  i,  j  )  =  input  (  "Da el elemento: ["  +  string  (  i  )  +  ","  +  string  (  j  )  +  "]"  )
                 end
            end
        endfunction


function vectorDeRespuesta = Montante(mat)
    pivoteAnterior = 1;
    tamano = size(mat,2);
    for i=1:size(mat,1)    
        for k=1:size(mat,1)
            if(k<>i)
                for CJ = i+1:size(mat,2)
                mat(k,CJ)= (mat(i,i) * mat(k,CJ) - mat(k,i) * mat(i,CJ)) / pivoteAnterior
                end
                    mat(k,i)=0;
            end
     end
     
        pivoteAnterior = mat(i,i)
        for p = 1: i - 1
           mat(p,p) = pivoteAnterior
       end
end

for i=1:size(mat,1)     
    mat(i, tamano) = mat(i,tamano)/pivoteAnterior
    vectorDeRespuesta(i)= mat(i,tamano);
end
endfunction

mat = PidoValores();
vector = Montante(mat);
disp(vector);

