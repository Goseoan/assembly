#include <stdio.h> //printf
#include <unistd.h>
#include <sys/socket.h>    //socket
#include <arpa/inet.h> //inet_addr

int main(int argc , char *argv[])
{
    int sock,n,c,d;
    struct sockaddr_in server;
    char message[50], server_reply[50];
     
    sock = socket(AF_INET , SOCK_STREAM , 0);
      
    server.sin_addr.s_addr = inet_addr("13.124.75.20");
    server.sin_family = AF_INET;
    server.sin_port = htons( 1337 );
 
    //Connect to remote server
    connect(sock , (struct sockaddr *)&server , sizeof(server));
    
    recv(sock , server_reply , 50 , 0);    
    printf("%s",server_reply);


    for (n = 0; server_reply[n]; n++);   
 
    for (c = n - 1, d = 0; c >= 0 && d<=n-1; c--, d++)
        message[d] = server_reply[c];
 
    message[d] = 0x00;

    printf("%s",message);

    send(sock , message , n , 0);         
    
    
    recv(sock , server_reply , 2 , 0);
    server_reply[2] ='\0';
    printf("\n%s\n",server_reply);    
     
    close(sock);
    return 0;
}

