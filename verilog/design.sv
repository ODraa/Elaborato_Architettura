.module MorraCinese (
    input clk,

    // segnali di I/O già noti
    input INIZIA,
    input [1:0] PRIMO,
    input [1:0] SECONDO,
    output [1:0] MANCHE,
    output [1:0] PARTITA

    // segnali di controllo
    // input INIZIO_CONTO
    // input INIZIO_SETUP
    // segnali si elaborazione
    // input FINE_CONTO
);

// dichiarazione dei registri
reg [1:0] vincitore_manche_precedente;
reg [1:0] mossa_vincitrice;
reg [4:0] registro_pareggi;
reg [4:0] manche_vinte_primo;
reg [4:0] manche_vinte_secondo;
reg [4:0] numero_manche;
    
endmodule