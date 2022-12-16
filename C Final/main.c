
#include <stdlib.h>
#include <stdio.h>
#include <math.h>

int checkwin();
int check_valid(int p);
void board();
int isEmpty(char arr[]);
void play_board(int); // first player is x
void bidding_board();

char square[10] = {'0','1','2','3','4','5','6','7','8','9'};

int player_bidding = 0;
int player1_count = 100;
int player2_count = 100;
int op = 0, input, temp, status, player = 1;

/* Generate a random number structure */
time_t t;

int main(){
    /* Generate a random number initialization */
    srand((unsigned) time(&t));
    int choice, i = 0, c = 0;
    
    system("cls");
    printf("\n\n\tTic Tac Toe\n\n");
    printf("Choose mode of Game :- \n");
    printf("(1) ----->     Player Vs Player       <------ \n");
    printf("(2) -----> Player Vs Player (Bidding) <------ \n");
    printf("(3) -----> Player Vs Computer (Easy)  <------ \n");
    status = scanf("%d", &op);
    while(op <= 0 || op > 3 || status != 1){
        while((temp = getchar()) != EOF && temp != '\n');
        printf("re enter option again: \n");
        status = scanf("%d", &op);
    }
    if(op == 1){
        /* Generate a random number initialization */
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
       else if(i == 1 && player % 2 == 0) printf("Player 2 won!\n");
       else if(i == 1 && player % 2 != 0) printf("Player 1 won!\n");

    }else if(op == 2){
        while(isEmpty(square)){
            board();
            bidding_board();
            int j = checkwin();
            if(j == 1 && player_bidding == 1){
                printf("player 1 wins the game\n");
                return 0;
            }
            else if(j == 1 && player_bidding == 2){
                printf("player 2 win the game\n");
                return 0;
            }else if(j == 0){
                printf("Game Draw \n");
                return 0;
            }
        }
    }else{
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
        else if(i == 1 && player % 2 == 0) printf("Computer won!\n");
        else if(i == 1 && player % 2 != 0) printf("Player won!\n");
    }
     return 0;
}

/* Show System Screen */
void board(){

    system("cls");
    if(op == 1) printf("Player 1  (X)  -  Player 2 (O)\n\n\n");
    else if (op == 2) printf("Player 1 (X)  -  Player 2 (O)\n           (Bidding) \n\n\n");
    else if (op == 3) printf("Player   (X)  -  Computer (O)\n\n\n");

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
int checkwin(){

    if (square[1] == square[2] && square[2] == square[3])
        return 1;

    else if (square[4] == square[5] && square[5] == square[6])
        return 1;

    else if (square[7] == square[8] && square[8] == square[9])
        return 1;

    else if (square[1] == square[4] && square[4] == square[7])
        return 1;

    else if (square[2] == square[5] && square[5] == square[8])
        return 1;

    else if (square[3] == square[6] && square[6] == square[9])
        return 1;

    else if (square[1] == square[5] && square[5] == square[9])
        return 1;

    else if (square[3] == square[5] && square[5] == square[7])
        return 1;

    else if (square[1] != '1' && square[2] != '2' && square[3] != '3' &&
        square[4] != '4' && square[5] != '5' && square[6] != '6' && square[7]
        != '7' && square[8] != '8' && square[9] != '9')

        return 0;
    else
        return -1;
}

int isEmpty(char arr[]){

    for(int i = 1; i <= 9; i++)
    {
        if(arr[i] != 'X' && arr[i] != 'O')
        {
            return 1;
        }
    }
    return 0;
}

void bidding_board(){
    int bid_player1;
    int bid_player2;
    do{
        printf("player no 1 enter a number to bid on\n");
        status = scanf("%d",&bid_player1);
        while((temp = getchar()) != EOF && temp != '\n');
    }while(bid_player1>100 || bid_player1<0 || status != 1);

    do{
        printf("player no 2 enter a number to bid on\n");
        status = scanf("%d",&bid_player2);
        while((temp = getchar()) != EOF && temp != '\n');
    }while(bid_player2>100 || bid_player1<0 || status != 1);

    if(bid_player1>bid_player2){
        //player 1 should play
        player1_count = player1_count - bid_player1;
        player2_count = player2_count + bid_player1;
        player_bidding = 1;
        play_board(1);
        
    }
    else if(bid_player2>bid_player1){
        //player 2 should play
        player2_count = player2_count - bid_player2;
        player1_count = player1_count + bid_player2;
        player_bidding = 2;
        play_board(2);
   
    }
    else{
        // equal numbers
        printf("\nbidding numbers are equal please re enter the numbers\n");
    }
}

void play_board(int player){

    char letter;
    int position = 0;
    int flag = 0;
    if(player == 1){
        letter = 'X';
    }else if(player == 2){
        letter = 'O';
    }
    do{
        printf("player %d: please enter a position \n" ,player);
        status = scanf("%d", &position);
        if(square[position] == 'X'|| square[position] == 'O'){
            printf("the position is already taken\n");
            flag = 1;
        }else{
            switch(position){
                case 1:
                case 2:
                case 3:
                case 4:
                case 5:
                case 6:
                case 7:
                case 8:
                case 9:
                square[position] = letter;
                board();
                flag = 0;
                break;
                default:
                printf("invalid position\n");
                flag = 1;
                break;
            }
        }
        while((temp = getchar()) != EOF && temp != '\n');
    }while(flag == 1 || status != 1);
}


/*******check validation of the player or computer turn******/
int check_valid(int p){
    int c;
    if(op == 3){
        if(p % 2 == 0)
        {
            do{
                c = rand() % 10;

           }while(square[c] == 'X' || square[c] == 'O' || c == 0);

        }
        else
        {
            printf("enter your choice = ");
            status = scanf("%d" ,&c);
            while(square[c] == 'X' || square[c] == 'O' || c == 0 || c > 9 || status != 1){
                while((temp = getchar()) != EOF && temp != '\n');
                printf("enter valid number\n");
                printf("enter your choice = ");
                status = scanf("%d" ,&c);
            }
        }
    }
    else{
        printf("Enter your choice = ");
        status = scanf("%d" ,&c);
        while(square[c] == 'X' || square[c] == 'O' || c == 0 || c > 9 || status != 1){
            while((temp = getchar()) != EOF && temp != '\n');
            printf("Enter valid number\n");
            printf("Enter your choice = ");
            status = scanf("%d" ,&c);
        }
    }
    return c;
}
