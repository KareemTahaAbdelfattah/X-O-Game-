#include <stdlib.h>
#include <stdio.h>
#include <math.h>

int checkwin();
int check_valid(int p);
void board();

char square[10] = {'0','1','2','3','4','5','6','7','8','9'};

/* Generate a random number structure */
time_t t;

int main(){
  
    /* Generate a random number initialization */  
    srand((unsigned) time(&t));
  
    int choice, player = 1, i = 0, c = 0;
  
    do
    {
       board();
      
       if(player % 2 == 0)
       {
           c = check_valid(player);
           square[c] = 'O';
       }
       else
       {
           c = check_valid(player);
           square[c] = 'X';
       }
      
       board();
       player++;
       i = checkwin();
      
    } while(i == -1);

   --player;
  
   if(i == 0) printf("Game Draw\n");
   else if(i == 1 && player % 2  == 0) printf("Computer won!\n");
   else if(i == 1 && player % 2 != 0) printf("Player won!\n");

   return 0;
}


/* Show System Screen */
void board()
{
    system("cls");
    printf("\n\n\tTic Tac Toe\n\n");

    printf("Player  (X)  -  Computer (O)\n\n\n");

    printf("     |     |     \n");
    printf("  %c  |  %c  |  %c \n", square[1], square[2], square[3]);

    printf("_____|_____|_____\n");
    printf("     |     |     \n");

    printf("  %c  |  %c  |  %c \n", square[4], square[5], square[6]);

    printf("_____|_____|_____\n");
    printf("     |     |     \n");

    printf("  %c  |  %c  |  %c \n", square[7], square[8], square[9]);

    printf("     |     |     \n\n");
}
