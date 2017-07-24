#include <stdio.h>
#include <stdlib.h>

int main(int argc, char* argv[])
{
   int num = *argv[1]-0x30;
   int i, j;   
   
   
   for(i=1; i<=num; i++)
   {
      for(j=1; j<=i; j++)
      {
         printf("*");
      }
      printf("\n");
   }

   for(i=num-1; i>0; i--)
   {
      for(j=1; j<=i; j++)
      {
         printf("*");
      }
      printf("\n");
   }

   
   return 0;

}