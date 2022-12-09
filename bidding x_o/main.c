#include <stdio.h>
#include <stdlib.h>

void Display_board();
int CheckFreespaces(void);
void play_board(int); // first player is x
int bidding_board();
char box[10]={'1','2','3','4','5','6','7','8','9'};

int player1_count =100;
int player2_count = 100;
int main()
{
    while(isEmpty(box))
    {
        Display_board();
        bidding_board();
        if(check()==1){
            printf("player 1 wins the game\n");
            return 0;
        }
        else if(check()==2){
            printf("player 2 win the game\n");
            return 0;
        }
    }
        return 0;
}


void Display_board()
{

    printf("\n\n\tTic Tac Toe\n\n");

    printf("Player 1 (X) -VS- Player 2 (O)\n\n");
    printf("player 1 bid (%d) vs player 2 bid (%d)\n\n",player1_count,player2_count);
    printf("     |     |     \n");
    printf(" %c   | %c   | %c   \n",box[0],box[1],box[2]);
    printf("_____|_____|_____\n");
    printf("     |     |      \n");
    printf(" %c   | %c   | %c   \n",box[3],box[4],box[5]);
    printf("_____|_____|_____\n");
    printf("     |     |      \n");
    printf(" %c   | %c   | %c   \n",box[6],box[7],box[8]);
    printf("_____|_____|_____\n");
    printf("     |     |      \n");

}

void isEmpty(char arr[])
{
    for(int i=0; i<9; i++)
    {
        if(arr[i]!='X' || arr[i]!='O')
        {
            return 1;
        }
    }
    return 0;
}
