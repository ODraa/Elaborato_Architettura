
/*
NOTA 1: SETTA COME POEDGE IL CLK
NOTA 2: CONTROLLA LE CONDIZIONE DELL'ALWAYS
NOTA 3: QUANDO INIZIA = 1 CONFIGURAZIONE DEL NUMERO DI PARTITE
*/

module MorraCinese (
    input wire clk;
    input wire [1:0] PRIMO,
    input wire [1:0] SECONDO,
    input wire INIZIA,
    output reg [1:0] MANCHE,
    output reg [1:0] PARTITA
);
    
    // reg [1:0] vincitore_manche; // per memorizzare il giocatore vincente dell'ultima manche

    reg [1:0] mossa_giocatore_1;
    reg [1:0] mossa_giocatore_2;

    // reg [1:0] mossa_vincitrice;
    
    reg [4:0] contatore_manche; // conta il numero di manche giocate

    reg [4:0] manche_vinte_primo; // conta il numero di manche vinte dal giocatore 1
    reg [4:0] manche_vinte_secondo; // conta il numero di manche vinte dal giocatore 2

    reg [4:0] partite_vinte_primo; // conta il numero di partite vinte dal giocatore 1
    reg [4:0] partite_vinte_secondo; // conta il numero di partite vinte dal giocatore 2

    always @(posedge INIZIA) begin
        // Inizializzazione del sistema
        if (INIZIA == 1) begin
            MANCHE <= 2'b00;
            PARTITA <= 2'b00;

            contatore_manche <= 0;

            manche_vinte_primo <= 0;
            manche_vinte_secondo <= 0;

            partite_vinte_primo <= 0;
            partite_vinte_secondo <= 0;
            
            mossa_giocatore_1 <= 2'b00;
            mossa_giocatore_2 <= 2'b00;
        end
    end

    always @(posedge INZIA or posedge PRIMO or posedge SECONDO) begin
        if (INIZIA == 0) begin
            case ({PRIMO, SECONDO})

                // nel caso 0000 la scelta è ricadura su MANCHE <= 2'b00 dato il "rifiuto" di giocare
                4'b0000: MANCHE <= (mossa_giocatore_1 != 2'b00 && mossa_giocatore_2 != 2'b00) ? 2'b00 : 2'b00;// pareggio

                4'b0001: MANCHE <= (mossa_giocatore_2 != 2'b01) ? 2'b10 : 2'b00; // secondo

                4'b0010: MANCHE <= (mossa_giocatore_2 != 2'b10) ? 2'b10 : 2'b00; // secondo
 
                4'b0011: MANCHE <= (mossa_giocatore_2 != 2'b11) ? 2'b10 : 2'b00; // secondo 
 
                4'b0100: MANCHE <= (mossa_giocatore_1 != 2'b01) ? 2'b01 : 2'b00; // primo
 
                4'b0101: MANCHE <= (mossa_giocatore_1 != 2'b01 && mossa_giocatore_2 != 2'b01) ? 2'b11 : 2'b00; // pareggio
 
                4'b0110: MANCHE <= (mossa_giocatore_2 != 2'b10) ? 2'b10 : 2'b00; // secondo
 
                4'b0111: MANCHE <= (mossa_giocatore_1 != 2'b01) ? 2'b01 : 2'b00; // primo
 
                4'b1000: MANCHE <= (mossa_giocatore_1 != 2'b10) ? 2'b01 : 2'b00; // primo
 
                4'b1001: MANCHE <= (mossa_giocatore_1 != 2'b10) ? 2'b01 : 2'b00; // primo
 
                4'b1010: MANCHE <= (mossa_giocatore_1 != 2'b10 && mossa_giocatore_2 != 2'b10) ? 2'b11 : 2'b00; // pareggio
 
                4'b1011: MANCHE <= (mossa_giocatore_2 != 2'b11) ? 2'b10 : 2'b00; // secondo
 
                4'b1100: MANCHE <= (mossa_giocatore_1 != 2'b11) ? 2'b01 : 2'b00; // primo
 
                4'b1101: MANCHE <= (mossa_giocatore_2 != 2'b01) ? 2'b10 : 2'b00; // secondo
 
                4'b1110: MANCHE <= (mossa_giocatore_1 != 2'b11) ? 2'b01 : 2'b00; // primo
 
                4'b1111: MANCHE <= (mossa_giocatore_1 != 2'b11 && mossa_giocatore_2 != 2'b11) ? 2'b11 : 2'b00; // pareggio
 
                default: MANCHE <=  2'b00;
            endcase

            // registro le mosse fatte da entrambi i giocatori
            // mosse_giocatore1 <= PRIMO;
            // mosse_giocatore2 <= SECONDO;
          

            if (MANCHE == 2'b01) begin
                contatore_manche = contatore_manche + 1;
                manche_vinte_primo = manche_vinte_primo + 1;
                mossa_giocatore_1 <= PRIMO; // setto la mossa vincente di giocatore1

                // dato che SECONDO ha perso sblocco la sua mossa vincente di prima
                mossa_giocatore_2 <= 2'b00;
            end
            if (MANCHE == 2'b10) begin
                contatore_manche = contatore_manche + 1;
                manche_vinte_secondo = manche_vinte_secondo + 1;
                mossa_giocatore_2 <= SECONDO; // setto la mossa vincente di giocatore2

                // dato che PRIMO ha perso sblocco la sua mossa vincente di prima
                mossa_giocatore_1 <= 2'b00;
            end
            if (MANCHE == 2'b11) begin
                contatore_manche = contatore_manche + 1;

                // causa pareggio tutte le mosse sono sbloccate
                mossa_giocatore_1 <= 2'b00;
                mossa_giocatore_2 <= 2'b00;
            end

            if (contatore_manche >= 4 && contatore_manche <= 19) begin
                if (manche_vinte_primo - manche_vinte_secondo == 2) begin
                    partite_vinte_primo = partite_vinte_primo + 1;
                    PARTITA <= 2'b01; //vittoria del giocatore 1
                end else if (manche_vinte_secondo - manche_vinte_primo == 2) begin
                    partite_vinte_secondo = partite_vinte_secondo + 1;
                    PARTITA <= 2'b10; //vittoria del giocatore 2
                end
            end
        end
    end
endmodule