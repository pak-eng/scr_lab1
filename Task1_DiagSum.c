#include <stdio.h>

void diag_sum_func(int* sum_md, int* sum_ad, int mat[4][4])
{
    for (int i = 0 ; i < 4; i++)
    {
        *sum_md = *sum_md + mat[i][i];     
        *sum_ad = *sum_ad + mat[i][3 - i]; 
    }
}

int main()
{
    int Sum_MainDiag = 0;
    int Sum_AntiDiag = 0;
    int Matrix[4][4] = {{1, 0, 0, 8}, {0, 3, 4, 0}, {0, 2, 5, 0}, {1, 0, 0, 7}};
    diag_sum_func(&Sum_MainDiag, &Sum_AntiDiag, Matrix);
    printf("Main diagonal sum = %d Antidiagonal sum = %d", Sum_MainDiag, Sum_AntiDiag);
}
