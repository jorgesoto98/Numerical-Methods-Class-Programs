clear 
 /*
 Proyecto Metodos_1.sce
 
 Este programa recibe un archivo de excel para tomar datos 
 hace regrecion Lineal, Cuadratica, Exponencial y Potencial
 regresa la mejor regresion como tambien una grafica con las 
 funciones ya mencionadas, ademas de identificar si hay datos
 atipicos en el dataset.
 
 Jorge Miguel Soto Rodriguez
 A01282936
 Noviembre 26, 2019
 
 */
 
//                      Funcion para extraer datos de un .xls
/*
Usamos la funcion readslx() para tener acceso a un archivo 
para que sea mas practico para el usuario preguntamos 
por el nombre del archivo sin necesidad de poner el .xls
Toma los datos de solo la primera Hoja del archivo .xls
*/
function imatValues = GetValues()
    //Pregunta por el nombre del archivo
    sNombreArch=input("Cual es el nombre del archivo?(sin .xls)","string")
    //Convierte el string a XXX.xls
    sNombreArch= sNombreArch + ".xls"
    //Accesa al Excel
    dSheets = readxls(sNombreArch)
    //Accesa a la primera hoja
    dSheet1= dSheets(1);
    //Extrae los datos de la hoja
    imatValues = dSheet1(:,:)
endfunction
//---------------------------------------------------------------------------

//                          Extrae los daots del Excel a una matriz
/*
Los datos del excel los pasamos a una matriz para comenzar con el proceso de las regresiones
*/

dmatValores = GetValues()
iRenglones = size(dmatValores,'r') // Numero de iRenglones en la matriz
iColumnas = size(dmatValores,'c') //Numero de iColumnas en la matriz

dValorEstimar =input("Cual es el valor x que se desea estimar ?");
//----------------------------------------------------------------------------

//                                  Montante                                  
/*
Metodo implementado en una tarea anterior para solucoinar un sistema de ecuaciones
*/
function darrVectorDeRespuesta = Montante(dmatValores)
    dPivoteAnterior = 1;
    iTamano = size(dmatValores,2);
    for i=1:size(dmatValores,1)    
        for k=1:size(dmatValores,1)
            if(k<>i)
                for CJ = i+1:size(dmatValores,2)
                dmatValores(k,CJ)= (dmatValores(i,i) * dmatValores(k,CJ) - dmatValores(k,i) * dmatValores(i,CJ)) / dPivoteAnterior
                end
                    dmatValores(k,i)=0;
            end
     end
     
        dPivoteAnterior = dmatValores(i,i)
        for p = 1: i - 1
           dmatValores(p,p) = dPivoteAnterior
       end
end

for i=1:size(dmatValores,1)     
    dmatValores(i, iTamano) = dmatValores(i,iTamano)/dPivoteAnterior
    darrVectorDeRespuesta(i)= dmatValores(i,iTamano);
end
endfunction
//----------------------------------------------------------------------------

//                     Parametros de las Regreciones                     
/*
Inicializamos en 0s todas las variables necesarias para elaborar las matrices de las regresiones:
Lineal:N, x, y, x^2, x*y.
Cuadratica:N, x, y, x^2, x^3, x^4, x*y, x^2*y.
Exponencial:N,x,x^2, ln(y),ln(y)*x;
Potencial:N,ln(x),ln(x)*ln(x), ln(y),ln(y)*ln(x).
*/

//Numero de Datos
iN = iRenglones;
//Suma de X
dX = 0;
//Suma de X^2
dXalCuadrado = 0;
//Suma de X^3
dXalCubo = 0;
//Suma de X^4
dXalaCuarta = 0;
//Suma de YX
dYporX = 0;
//Suma de YX^2
dYporXcuadrada =0;
//Suma de Y
dY = 0;
//Suma de ln(Y) * X
dLnYporX =0;
//Suma de Ln(Y)
dLnY = 0;
//Suma de Ln(Y) Ln(Y)
dLnYporLnY=0;
//Suma de Ln(X)
dLnX = 0;
//Suma de Ln(X)*Ln(X)
dLnXporLnX = 0;
//Suma de Ln(Y)*Ln(X)
dLnXporLnY = 0;
//Suma de log(x)
dLogX=0;
//Suma de log(y)
dLogY=0;
//Suma de log(x) * log(y)
dLogXporLogY=0;
//Suma de log(x) * log(x)
dLogXporLogX=0;
//Suma de log(y) * log(y)
dLogYporLogY=0;

//----------------------------------------------------------------------------

//          Ciclo para asignar valores a parametros de las regresiones        
/*
Por medio de un ciclo for asignamos a las variables anteriores sus respectivos valores
*/
for i=1 : iRenglones 
    dX = dX + dmatValores(i,1)
    dXalCuadrado = dXalCuadrado + (dmatValores(i,1))^2
    dXalCubo = dXalCubo + (dmatValores(i,1))^3
    dXalaCuarta = dXalaCuarta + (dmatValores(i,1))^4 
    dLnX = dLnX + log((dmatValores(i,1))) 
    dLnXporLnX = dLnXporLnX + (log(dmatValores(i,1)) * log(dmatValores(i,1)))
    dLogX= dLogX + log10(dmatValores(i,1))
    dY = dY + dmatValores(i,2)
    dYporX = dYporX + dmatValores(i,1) *  dmatValores(i,2)
    dYporXcuadrada = dYporXcuadrada + ((dmatValores(i,1))^2) *  dmatValores(i,2)
    dLnYporX = dLnYporX + (dmatValores(i,1)) * log(dmatValores(i,2))
    dLnY = dLnY + (log(dmatValores(i,2)))
    dLnYporLnY= dLnYporLnY + (log(dmatValores(i,2)) * log(dmatValores(i,2)))
    dLnXporLnY = dLnXporLnY + (log(dmatValores(i,1)) * log(dmatValores(i,2)))
    dLogY= dLogY + log10(dmatValores(i,2))
    dLogXporLogY = dLogXporLogY + (log10(dmatValores(i,1)) * log10(dmatValores(i,2)))
    dLogXporLogX = dLogXporLogX + (log10(dmatValores(i,1)) * log10(dmatValores(i,1)))
    dLogYporLogY = dLogYporLogY + (log10(dmatValores(i,2)) * log10(dmatValores(i,2)))
end
//----------------------------------------------------------------------------

//         Matrices de las regresiones                      
/*
Se definen las matrices de las regresiones con las variables anterirores ya con sus valores.
*/

dmatLin  =    [iN, dX, dY ; dX, dXalCuadrado, dYporX];
dmatCuad =    [iN,dX,dXalCuadrado,dY;dX,dXalCuadrado,dXalCubo,dYporX;dXalCuadrado,dXalCubo,dXalaCuarta,dYporXcuadrada];
dmatExp  =    [iN,dX,dLnY;dX,dXalCuadrado,dLnYporX];
dmatPot  =    [iN,dLnX,dLnY;dLnX,dLnXporLnX,dLnXporLnY];

//---------------------------------------------------------------------------

//                          Regresiones                                       

// Regresion Lineal
deff('y=lineal(dXLin)','y = dALin + dBLin * dXLin');
darrVectorLineal = Montante(dmatLin);
dALin = darrVectorLineal(1);
dBLin = darrVectorLineal(2);
dResultadoLin = lineal(dValorEstimar);


// Regresion Cuadratica
deff('y = cuadratica(dXCuad)','y = dACuad + dBCuad * dXCuad + dCCuad * dXCuad^2');
darrvectorCuadratica = Montante(dmatCuad);
dACuad = darrvectorCuadratica(1);
dBCuad = darrvectorCuadratica(2);
dCCuad = darrvectorCuadratica(3);
dResultadoCuad = cuadratica(dValorEstimar);


// Regresion Exponencial
deff('y = exponencial(dXExp)','y = dAExp * exp(dBExp * dXExp)')
darrvectorExponencial = Montante(dmatExp);
dAExp = exp(darrvectorExponencial(1));
dBExp = darrvectorExponencial(2);
dResultadoExp = exponencial(dValorEstimar);


// Regresion Potencial
deff('y=potencial(dXPot)','y= dAPot * dXPot^(dBPot)')
darrvectorPotencial =Montante(dmatPot);
dAPot = exp(darrvectorPotencial(1));
dBPot = darrvectorPotencial(2);
dResultadoPot = potencial(dValorEstimar);


//----------------------------------------------------------------------------

//              Evaluacion para sacar la mejor regresion                   
dMean = dY / iRenglones;
dSST= 0;
dYactual=0;
dSSELineal=0;
dSSECuadratica=0;
//Metodo para regresion lineal y Cuadratica  Para sacar r^2
for i=1: iRenglones
    dSST= dSST + (dmatValores(i,2) - dMean)^2;
    dYactual = dmatValores(i,2);
    
    dyLineal = lineal(dmatValores(i,1));
    dSSELineal = dSSELineal + (dYactual-dyLineal)^2
    
    dyCuadratica    = cuadratica(dmatValores(i,1));
    dSSECuadratica = dSSECuadratica + (dYactual-dyCuadratica)^2
end
dRsqrLin =(dSST - dSSELineal)/dSST;
dRsqrCuad =(dSST - dSSECuadratica)/dSST;

//Metodo para regresion exponencial para sacar r^2
dPaso1 = iN * dLnYporX - dX * dLnY;
dPaso2 = iN * dXalCuadrado -dX * dX;
dPaso3 = iN * dLnYporLnY -dLnY * dLnY;
dPaso4 = dPaso2 * dPaso3;
dPaso5 = sqrt(dPaso4);
dPaso6 = dPaso1/dPaso5;
dPaso7 = dPaso6^2;
dRsqrExp = dPaso7;

//Metodo para regresion potencial para sacar r^2
dPaso1= iN * dLogXporLogY - dLogX*dLogY;
dPaso2= iN * dLogXporLogX - dLogX*dLogX;
dPaso3= iN * dLogYporLogY - dLogY*dLogY;
dPaso4= sqrt(dPaso3*dPaso2);
dPaso5= dPaso1 / dPaso4;
dPaso6 = dPaso5^2;
dRsqrPot = dPaso6;

//Evaluar r^2 para saber cual es la mejor 
//Se agregaron las r^2 para encontrar el mayor mas facil
vectorDeRespuestas = [dRsqrLin,dRsqrCuad,dRsqrExp,dRsqrPot];
mejorRegresion = max(vectorDeRespuestas);

//-------------------------------------------------------------------------- 
//Desplegar Datos de las regresiones

//Encontrar mejor model
if mejorRegresion == dRsqrLin then
    sMejorModeloRegresion='Lineal';
end

if mejorRegresion == dRsqrCuad then
    sMejorModeloRegresion='Cuadratica';
end

if mejorRegresion == dRsqrExp then
    sMejorModeloRegresion='Exponencial';
end

if mejorRegresion == dRsqrPot then
    sMejorModeloRegresion='Potencial';
end
//----------------

disp('Regresion Lineal:')
disp('              Ecuacion: y = ('+string(dALin) +') + ('+ string(dBLin) + ')x');
disp('              Resultado estimado para x='+string(dValorEstimar)+': '+string(dResultadoLin));
disp('              r^2 =' + string(dRsqrLin));

disp('Regresion Cuadratica:')
disp('              Ecuacion: y = ('+ string(dACuad) + ') + (' + string(dBCuad)+')x ' + '+ ('+string(dCCuad)+')x^2');
disp('              Resultado estimado para x='+string(dValorEstimar)+': '+string(dResultadoCuad));
disp('              r^2 =' + string(dRsqrCuad));

disp('Regresion Exponencial:')
disp('              Ecuacion: y = ('+string(dAExp) + ') * e^(('+string(dBExp)+') * x )');
disp('              Resultado estimado para x='+string(dValorEstimar)+': '+string(dResultadoExp));
disp('              r^2 =' + string(dRsqrExp));

disp('Regresion Potencial:')
disp('              Potencial: y= ('+string(dAPot)+') * x^('+string(dBPot)+')');
disp('              Resultado estimado para x='+string(dValorEstimar)+': '+string(dResultadoPot));
disp('              r^2 =' + string(dRsqrPot));

disp('La mejor regresion es del modelo '+string(sMejorModeloRegresion) +' con r^2 de: '+string(mejorRegresion));

//-------------------------------------------------------------------------- 
//                       Graficar                                            

for i=1: iN
    x(i) = dmatValores(i,1);
    y(i) = dmatValores(i,2);
    dmatNuevos(i,1) = dmatValores(i,1);
    dmatNuevos(i,2) = dmatValores(i,2);
    dmatNuevos(i,3) = dmatValores(i,1) * dmatValores(i,2);
    c(i) = dmatValores(i,1) * dmatValores(i,2);
end
scatter(x,y,75,'x');
x(iN+1) = min(x) -10;
x(iN+2) = max(x) +10;
x=gsort(x);

plot(x,lineal,'r+-',x,cuadratica,'g+-',x,exponencial,'c+-',x,potencial,'k+-');
hl=legend(['Puntos';'Lineal';'Caudratica';'Exponencial';'Potencial']);

//----------------------------------------------------------------------------

//                          Datos Atipicos 
c=gsort(c,'lr','i');
mediana = c(ceil(iN/2));
q1 =c(ceil(iN/4));
q3 = c(ceil(3*iN/4));
Ri = q3-q1;

AtipicosLevesMenores = q1 - 1.5 * Ri;
AtipicosLevesMayores = q3 + 1.5 * Ri;

for i=1:iN
    if(c(i) < AtipicosLevesMenores)then
        
        for j =1: iN
            if(c(i) == dmatNuevos(j,3)) then
                        disp('Hay un Dato Atipico en ('+ string(dmatNuevos(j,1)) + ', '+ string(dmatNuevos(j,2))+')');
                end
            end
     end
    if(c(i) > AtipicosLevesMayores)then
        
          for j =1: iN
            if(c(i) == dmatNuevos(j,3)) then
                        disp('Hay un Dato Atipico en ('+ string(dmatNuevos(j,1)) + ', '+ string(dmatNuevos(j,2))+')');
                end
            end
       
    end
end
//------------------------------------------------------------------------
//Exportar Datos a un excell



//----------------------------------------------------------------------------/

