#include <stdio.h>
#include <math.h>

int main()
{
    int a;
    int b;
    int c;
    int D;
    double x;
    double x1;
    double x2;

    printf("Zadaj a,b,c.\n");
    scanf("%d",&a);
    scanf("%d",&b);
    scanf("%d",&c);
    printf("Kvadraticka rovnica: %dx^2 + %dx + %d = 0\n",a,b,c);
    D = b*b - (4*a*c);
    printf("Diskriminant je: %d.\n",D);
    if (D<0)
	printf("Rovnica nema riesenie.\n");
    if (D==0)
    {
	x = -(double)b / (2*a);
	printf("x = %f\n", x);
    }
    if (D>0)
    {
	x1 = (-b + sqrt(D)) / (2*a);
	x2 = (-b - sqrt(D)) / (2*a);
	printf("x1 = %f\nx2 = %f\n",x1,x2);
    }

    return 0;
}