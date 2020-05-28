clear 


//Funcion para pedir los valores de una matriz
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
        
        
//

 
///////////////////////////////////////////////////////////////////////
//   GAUSSJORDAN
function dMat = gaussJordan(dMat)
   iRowPivote = 1
   iColPivote = 1
   while iRowPivote <= size(dMat, 1)
       dPivote = dMat(iRowPivote, iColPivote);
       for i = iColPivote : size(dMat, 2)
           dMat(iRowPivote, i) = dMat(iRowPivote, i) / dPivote;
       end
       for iRow = 1 : size(dMat, 1)
           dFactor = -dMat(iRow, iColPivote);
           if iRow <> iRowPivote
               for iCol = 1 : size(dMat, 2)
                   dMat(iRow, iCol) = dMat(iRow, iCol) + ...
                                     dFactor * dMat(iRowPivote, iCol);
               end
           end
       end
       iRowPivote = iRowPivote + 1;
       iColPivote = iColPivote + 1;      
   end
endfunction

///////////////////////////////////////////////////////////////////////
// Despliega la matriz
function displayMatrix(dMatrix)
   // for every row
   for iI = 1 : size(dMatrix, 1)
       //for every column
       sLinea = ""
       for iJ = 1 : size(dMatrix, 2)
           sLinea = sLinea + string(dMatrix(iI, iJ)) + " , ";
       end
       disp(sLinea);
   end
endfunction

 
///////////////////////////////////////////////////////////////////////
//   SOLUCIONES
function displaySoluciones(dMatrix)
   for iI = 1 : size(dMatrix, 1)
      disp(string(dMatrix(iI, size(dMatrix, 2))))
   end
endfunction


