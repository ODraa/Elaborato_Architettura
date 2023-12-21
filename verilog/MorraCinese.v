module MorraCinese (
    input wire [1:0] PRIMO;
    input wire [1:0] SECONDO;
    input wire [0:0] INIZIA;

    output reg [1:0] MANCHE;
    output reg [1:0] PARTITA;
);

/*
PRIMO & SECONDO: 
00 ---> nessuna mossa
01 ---> sasso
10 ---> carta
11 ---> forbici

*/
    
endmodule