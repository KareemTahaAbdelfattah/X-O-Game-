
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
    if(box[position-1]=='X'|| box[position-1]=='O'){
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
                box[position-1] = letter;
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

int check()
{
    if(box[0]==box[1] && box[1]==box[2]){
        if(box[0]=='X'){
            return 1; //player 1
        }else{
            return 2; //player 2
        }
    }
   else if(box[3]==box[4] && box[4]==box[5]){
        if(box[3]=='X'){
            return 1; //player 1
        }else{
            return 2; //player 2
        }
   }
                        // horizontal match
    else if (box[6]==box[7] && box[7]==box[8]){
        if(box[6]=='X'){
            return 1; //player 1
        }else{
            return 2; //player 2
        }
    }

    else if (box[0]==box[3] && box[3]==box[6]){
        if(box[0]=='X'){
            return 1; //player 1
        }else{
            return 2; //player 2
        }
    }

    else if(box[1]==box[4] && box[4]==box[7]){
        if(box[1]=='X'){
            return 1; //player 1
        }else{
            return 2; //player 2
        }
    }           // vertical match
    else if(box[2]==box[5] && box[5]==box[8]){
        if(box[2]=='X'){
            return 1; //player 1
        }else{
            return 2; //player 2
        }
    }

    else if(box[0]==box[4] && box[4]==box[8]){
        if(box[0]=='X'){
            return 1; //player 1
        }else{
            return 2; //player 2
        }
    }
    else if(box[2]==box[4] && box[4]==box[6]) {
        if(box[2]=='X'){
            return 1; //player 1
        }else{
            return 2; //player 2
        }
    }          //diagonal match
    else
        return -1;


}


