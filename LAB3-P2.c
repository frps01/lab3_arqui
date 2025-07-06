#include <stdio.h>

int main() {
    int t0 = 20;   // límite del ciclo
    int t1 = 0;    // acumulador
    int t2 = 1;    // contador (inicia en 1)

    while (t2 <= t0) {   // Mientras contador (t2) no supere límite (t0)
        if (t2 % 2 == 0) 
            t1 += t2;    // Si t2 es par, suma al acumulador t1
        else
            t1 -= t2;    // Si t2 es impar, resta al acumulador t1
        t2+= 1;          // Incrementa contador (t2)
    }

    printf("%d\n", t1);  // Imprime resultado acumulado en t1
    return 0;
}