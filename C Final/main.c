
int isEmpty(char arr[]){

    for(int i = 1; i <= 9; i++)
    {
        if(arr[i] != 'X' || arr[i] != 'O')
        {
            return 1;
        }
    }
    return 0;
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
        player2_count = player2_count + bid_player1;
        player_bidding = 1;
        play_board(1);
        return 1;
    }
    else if(bid_player2>bid_player1){
        //player 2 should play
        player2_count = player2_count - bid_player2;
        player1_count = player1_count + bid_player2;
        player_bidding = 2;
        play_board(2);
        return 2;
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
        scanf("%d", &position);
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
    }while(flag==1);
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
            scanf("%d" ,&c);
            while(square[c] == 'X' || square[c] == 'O' || c == 0 || c > 9){
                printf("enter valid number\n");
                printf("enter your choice = ");
                scanf("%d" ,&c);
            }
        }
    }
    else{
        printf("Enter your choice = ");
        scanf("%d" ,&c);
        while(square[c] == 'X' || square[c] == 'O' || c == 0 || c > 9){
            printf("Enter valid number\n");
            printf("Enter your choice = ");
            scanf("%d" ,&c);
        }
    }
    return c;
}
