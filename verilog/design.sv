.module MorraCinese (
    input clk,

    // segnali di I/O già noti
    input INIZIA,
    input [1:0] PRIMO,
    input [1:0] SECONDO,
    output [1:0] MANCHE,
    output [1:0] PARTITA

    // segnali di controllo
    input INIZIO_CONTO
    input INIZIO_SETUP
    // segnali si elaborazione
    input FINE_CONTO
);

// dichiarazione dei registri
reg [1:0] vincitore_manche_precedente;
reg [1:0] mossa_vincitrice;
reg [4:0] registro_pareggi;
reg [4:0] manche_vinte_primo;
reg [4:0] manche_vinte_secondo;
reg [4:0] numero_manche;

////////////////// DATAPATH //////////////////


always @(posedge clk) begin

    //--- LOGICA DETERMINAZIONE VINCITORE DELLA MANCHE ---\\

    case ({SECONDO,PRIMO})

            // nel caso 0000 la scelta è ricadura su MANCHE <= 2'b00 dato il "rifiuto" di giocare
            4'b0000: MANCHE <= 2'b00; // MANCHE ANNULLATA
                
            4'b0001: MANCHE <= (((vincitore_manche_precedente == 2'b01 && mossa_giocatore_1 == mossa_vincitrice) || (vincitore_manche_precedente == 2'b10 && mossa_giocatore_2 == mossa_vincitrice)) && (INIZIO_SETUP == 1)) ? 2'b00 : 2'b01; // primo

            4'b0010: MANCHE <= (((vincitore_manche_precedente == 2'b01 && mossa_giocatore_1 == mossa_vincitrice) || (vincitore_manche_precedente == 2'b10 && mossa_giocatore_2 == mossa_vincitrice)) && (INIZIO_SETUP == 1)) ? 2'b00 : 2'b01; // primo

            4'b0011: MANCHE <= (((vincitore_manche_precedente == 2'b01 && mossa_giocatore_1 == mossa_vincitrice) || (vincitore_manche_precedente == 2'b10 && mossa_giocatore_2 == mossa_vincitrice)) && (INIZIO_SETUP == 1)) ? 2'b00 : 2'b01; // primo 

            4'b0100: MANCHE <= (((vincitore_manche_precedente == 2'b01 && mossa_giocatore_1 == mossa_vincitrice) || (vincitore_manche_precedente == 2'b10 && mossa_giocatore_2 == mossa_vincitrice)) && (INIZIO_SETUP == 1)) ? 2'b00 : 2'b10; // secondo

            4'b0101: MANCHE <= (((vincitore_manche_precedente == 2'b01 && mossa_giocatore_1 == mossa_vincitrice) || (vincitore_manche_precedente == 2'b10 && mossa_giocatore_2 == mossa_vincitrice)) && (INIZIO_SETUP == 1)) ? 2'b00 : 2'b11; // pareggio

            4'b0110: MANCHE <= (((vincitore_manche_precedente == 2'b01 && mossa_giocatore_1 == mossa_vincitrice) || (vincitore_manche_precedente == 2'b10 && mossa_giocatore_2 == mossa_vincitrice)) && (INIZIO_SETUP == 1)) ? 2'b00 : 2'b01; // primo

            4'b0111: MANCHE <= (((vincitore_manche_precedente == 2'b01 && mossa_giocatore_1 == mossa_vincitrice) || (vincitore_manche_precedente == 2'b10 && mossa_giocatore_2 == mossa_vincitrice)) && (INIZIO_SETUP == 1)) ? 2'b00 : 2'b10; // secondo

            4'b1000: MANCHE <= (((vincitore_manche_precedente == 2'b01 && mossa_giocatore_1 == mossa_vincitrice) || (vincitore_manche_precedente == 2'b10 && mossa_giocatore_2 == mossa_vincitrice)) && (INIZIO_SETUP == 1)) ? 2'b00 : 2'b010; // secondo

            4'b1001: MANCHE <= (((vincitore_manche_precedente == 2'b01 && mossa_giocatore_1 == mossa_vincitrice) || (vincitore_manche_precedente == 2'b10 && mossa_giocatore_2 == mossa_vincitrice)) && (INIZIO_SETUP == 1)) ? 2'b00 : 2'b010; // secondo

            4'b1010: MANCHE <= (((vincitore_manche_precedente == 2'b01 && mossa_giocatore_1 == mossa_vincitrice) || (vincitore_manche_precedente == 2'b10 && mossa_giocatore_2 == mossa_vincitrice)) && (INIZIO_SETUP == 1)) ? 2'b00 : 2'b11; // pareggio

            4'b1011: MANCHE <= (((vincitore_manche_precedente == 2'b01 && mossa_giocatore_1 == mossa_vincitrice) || (vincitore_manche_precedente == 2'b10 && mossa_giocatore_2 == mossa_vincitrice)) && (INIZIO_SETUP == 1)) ? 2'b00 : 2'b01; // primo

            4'b1100: MANCHE <= (((vincitore_manche_precedente == 2'b01 && mossa_giocatore_1 == mossa_vincitrice) || (vincitore_manche_precedente == 2'b10 && mossa_giocatore_2 == mossa_vincitrice)) && (INIZIO_SETUP == 1)) ? 2'b00 : 2'b10; // secondo

            4'b1101: MANCHE <= (((vincitore_manche_precedente == 2'b01 && mossa_giocatore_1 == mossa_vincitrice) || (vincitore_manche_precedente == 2'b10 && mossa_giocatore_2 == mossa_vincitrice)) && (INIZIO_SETUP == 1)) ? 2'b00 : 2'b01; // primo

            4'b1110: MANCHE <= (((vincitore_manche_precedente == 2'b01 && mossa_giocatore_1 == mossa_vincitrice) || (vincitore_manche_precedente == 2'b10 && mossa_giocatore_2 == mossa_vincitrice)) && (INIZIO_SETUP == 1)) ? 2'b00 : 2'b10; // secondo

            4'b1111: MANCHE <= (((vincitore_manche_precedente == 2'b01 && mossa_giocatore_1 == mossa_vincitrice) || (vincitore_manche_precedente == 2'b10 && mossa_giocatore_2 == mossa_vincitrice)) && (INIZIO_SETUP == 1)) ? 2'b00 : 2'b11; // pareggio

            default: MANCHE <=  2'b00;
        endcase
            

        //--- LOGICA DETERMINAZIONE VINCITORE DELLA MANCHE ---\\

        if (INIZIO_SETUP) begin
            numero_manche = {SECONDO,PRIMO} + 5'b00100;
        end 
        else begin
            numero_manche = numero_manche + 5'b00000;
        end

        //--- LOGICA PER L'INCREMENTO DEI REGISTRI A SECONDA DEL VINCITORE DELLA MANCHE ---\\


        case (MANCHE)

            2'b00: 

            2'b01: (INIZIO_CONTO == 1) ? manche_vinte_primo++ : manche_vinte_primo = 5'b00000;

            2'b10: (INIZIO_CONTO == 1) ? manche_vinte_secondo++ : manche_vinte_secondo = 5'b00000;

            2'b11: (INIZIO_CONTO == 1) ? registro_pareggi++ : registro_pareggi = 5'b00000;

            default: //

        endcase


        //--- LOGICA PER LA DETERMINAZIONE DI FINE CONTO ---\\

        if ((manche_vinte_primo + manche_vinte_secondo + registro_pareggi) == numero_manche) begin
            FINE_CONTO <= 1'b1
        end
        else if (manche_vinte_primo + manche_vinte_secondo + registro_pareggi >= 5'b00100) begin
                if ((manche_vinte_primo - manche_vinte_secondo >= 5'b00010)) begin
                    if ((manche_vinte_primo - manche_vinte_secondo < 5'b11100)) begin
                        FINE_CONTO <= 1'b1
                end
            end
        end
        else if (manche_vinte_primo + manche_vinte_secondo + registro_pareggi >= 5'b00100) begin
                if ((manche_vinte_secondo - manche_vinte_primo >= 5'b00010)) begin
                    if ((manche_vinte_secondo - manche_vinte_primo < 5'b11100)) begin
                        FINE_CONTO <= 1'b1
                end
            end
        end
        else FINE_CONTO <= 1'b0;


        //--- LOGICA PER LA DETERMINAZIONE DELLO STATO DELLA PARTITA ---\\

        case (FINE_CONTO)

            1'b0: PARTITA <= 2'b00;

            1'b1: 

            default: 

        endcase

    end
    
endmodule