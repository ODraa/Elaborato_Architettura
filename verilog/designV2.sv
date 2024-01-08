module MorraCinese (
    input wire clk;
    input wire [1:0] PRIMO,
    input wire [1:0] SECONDO,
    input wire INIZIA,
    output reg [1:0] MANCHE,
    output reg [1:0] PARTITA
);
    
    // reg [1:0] vincitore_manche; // per memorizzare il giocatore vincente dell'ultima manche

    // reg [1:0] mosse_giocatore1;
    // reg [1:0] mosse_giocatore2;

    reg [1:0] mossa_vincitrice;
    
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
            partite_vinte_primo <= 0;
            partite_vinte_secondo <= 0;
            mosse_giocatore1 <= 0;
            mosse_giocatore2 <= 0;
        end
    end

    always @(posedge INZIA or posedge PRIMO or posedge SECONDO) begin
        if (INIZIA == 0) begin
            // if (contatore_manche >= 4 && contatore_manche <= 19) begin
                // if () begin
                //     MANCHE <= 2'b00;
                // end else begin
                    // determinazione del vincitore della manche corrente
                    case ({PRIMO, SECONDO})

                        4'b0000: MANCHE <= 2'b00;

                        4'b0001: MANCHE <= (mossa_vincitrice != 2'b01) ? 2'b10 : 2'b00; // secondo

                        4'b0010: MANCHE <= (mossa_vincitrice != 2'b10) ? 2'b10 : 2'b00; // secondo
 
                        4'b0011: MANCHE <= (mossa_vincitrice != 2'b11) ? 2'b10 : 2'b00; // secondo 
 
                        4'b0100: MANCHE <= // primo
 
                        4'b0101: MANCHE <= // pareggio
 
                        4'b0110: MANCHE <= (mossa_vincitrice != 2'b10) ? 2'b10 : 2'b00; // secondo
 
                        4'b0111: MANCHE <= // primo
 
                        4'b1000: MANCHE <= // primo
 
                        4'b1001: MANCHE <= // primo
 
                        4'b1010: MANCHE <= // pareggio
 
                        4'b1011: MANCHE <= (mossa_vincitrice != 2'b11) ? 2'b10 : 2'b00; // secondo
 
                        4'b1100: MANCHE <= // primo
 
                        4'b1101: MANCHE <= (mossa_vincitrice != 2'b01) ? 2'b10 : 2'b00; // secondo
 
                        4'b1110: MANCHE <= // primo
 
                        4'b1111: MANCHE <= // pareggio
 
                        default: MANCHE <=  
                    endcase

                    // registro le mosse fatte da entrambi i giocatori
                    // mosse_giocatore1 <= PRIMO;
                    // mosse_giocatore2 <= SECONDO;
          

                    if (MANCHE == 2'b01) begin
                        contatore_manche = contatore_manche + 1;
                        manche_vinte_primo = manche_vinte_primo + 1;
                        // vincitore_manche = 2'b01;
                        mossa_vincitrice <= PRIMO;
                    end
                    if (MANCHE == 2'b10) begin
                        contatore_manche = contatore_manche + 1;
                        manche_vinte_secondo = manche_vinte_secondo + 1;
                        // vincitore_manche = 2'b10;
                        mossa_vincitrice <= SECONDO;
                    end
                // end
            // end
        end
    end
endmodule