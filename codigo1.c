#include <stdio.h>

int main() {
    int a = 10;
    int b = 3;
    int resultado = 0;

    for (int i = 0; i < 8; i++) {
        resultado += a;
        resultado -= b;
        if (resultado % 4 == 0) {
            resultado *= 2;
        } else {
            resultado -= 1;
        }
    }

    int j = 0;
    while (j < 10) {
        resultado -= (a / b);
        if (resultado % 6 == 0) {
            resultado += 6;
        } else if (resultado % 2 == 1) {
            resultado *= -1;
        } else {
            resultado += b;
        }
        j++;
    }

    if (resultado < 0) {
        resultado = -resultado;
    } else {
        resultado /= 2;
    }

    printf("Resultado: %d\n", resultado);
    return 0; 
}
