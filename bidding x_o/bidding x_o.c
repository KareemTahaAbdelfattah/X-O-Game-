
void Display_board()
{

    printf("\n\n\tTic Tac Toe\n\n");

    printf("Player 1 (X) -VS- Player 2 (O)\n\n");
    printf("player 1 bid (%d) vs player 2 bid (%d)\n\n",player1_count,player2_count);
    printf("     |     |     \n");
    printf(" %c   | %c   | %c   \n",box[1],box[2],box[3]);
    printf("_____|_____|_____\n");
    printf("     |     |      \n");
    printf(" %c   | %c   | %c   \n",box[4],box[5],box[6]);
    printf("_____|_____|_____\n");
    printf("     |     |      \n");
    printf(" %c   | %c   | %c   \n",box[7],box[8],box[9]);
    printf("_____|_____|_____\n");
    printf("     |     |      \n");


}
void play_board(int player){

    char letter;
    int position;
    int flag = 0;
    if(player == 1){
        letter='X';
    }else if(player == 2){
        letter = 'O';
    }
do{
    printf("player %d: please enter a position \n",player);
    scanf("%d",&position);
    if(box[position]=='X'|| box[position]=='O'){
        printf("the position is already taken\n");
        flag=1;
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
                box[position] = letter;
                Display_board();
                flag=0;
                break;
            default:
                printf("invalid position\n");
                flag=1;
                break;


            }

    }
}while(flag==1);

}

int bidding_board(){
int bid_player1;
int bid_player2;
do{
printf("player no 1 enter a number to bid on\n");
scanf("%d",&bid_player1);
}while(bid_player1>100 || bid_player1<0);
do{
printf("player no 2 enter a number to bid on\n");
scanf("%d",&bid_player2);
}while(bid_player2>100 || bid_player1<0);

if(bid_player1>bid_player2){
    //player 1 should play
    player1_count = player1_count - bid_player1;
    player2_count =player2_count +bid_player1;
    play_board(1);
    return 1;
}
else if(bid_player2>bid_player1){
//player 2 should play
player2_count =player2_count - bid_player2;
player1_count =player1_count + bid_player2;
play_board(2);
  return 2;
}
else{
// equal numbers
}

}

