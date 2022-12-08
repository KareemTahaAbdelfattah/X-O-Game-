/*******check validation of the player or computer turn******/
int check_valid(int p)

{
    int c;
    if(p%2==0)
      {
          do{
            c=rand()%10;

       } while(square[c]=='X'||square[c]=='O'||c==0);

      }
      else
      {
              printf("enter your choice=");
              scanf("%d",&c);
          while(square[c]=='X'||square[c]=='O'||c==0||c>9)
          {
              printf("enter valid number\n");
              printf("enter your choice=");
              scanf("%d",&c);

          }

      }
       return c;


}
/*******check if player or computer win or the game is over or still running******/
int checkwin()
{
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
        return  - 1;
}
