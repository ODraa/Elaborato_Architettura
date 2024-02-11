module MorraCinese (

    input clk,

    // segnali di I/O già noti
    input INIZIO,
    input [1:0] PRIMO,
    input [1:0] SECONDO,
    output reg [1:0] MANCHE,
    output reg [1:0] PARTITA
);
        
    // segnali di controllo
    reg INIZIO_CONTO = 1'b0;
    reg INIZIO_SETUP = 1'b0;

    // segnali si elaborazione
    reg FINE_CONTO = 1'b0;

    reg [1:0] stato = 2'b00; 
    reg [1:0] stato_prossimo = 2'b00;

    // dichiarazione dei registri
    reg [1:0] vincitore_manche_precedente;
    reg [1:0] mossa_vincitrice;
    reg [4:0] registro_pareggi;
    reg [4:0] manche_vinte_primo;
    reg [4:0] manche_vinte_secondo;
    reg [4:0] numero_manche;

    reg [1:0] mossa_giocatore_1 = 2'b00;
    reg [1:0] mossa_giocatore_2 = 2'b00;

    reg [1:0] temp1;
    reg [1:0] temp2;

    always @(clk) begin : UPDATE
        stato = stato_prossimo;
    end

    //////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////

    always @(stato, INIZIO, FINE_CONTO) begin : FSM
        case (stato)

            2'b00:
            if (INIZIO) begin

                INIZIO_CONTO = 1'b0;
                INIZIO_SETUP = 1'b1;
                stato_prossimo = 2'b01;

            end else begin
                
                INIZIO_CONTO = 1'b0;
                INIZIO_SETUP = 1'b0;
                stato_prossimo = 2'b00;

            end

            2'b01:
            if (~INIZIO && ~FINE_CONTO) begin

                INIZIO_CONTO = 1'b1;
                INIZIO_SETUP = 1'b0;
                stato_prossimo = 2'b10;

            end else if (~INIZIO && FINE_CONTO) begin
                
                INIZIO_CONTO = 1'b0;
                INIZIO_SETUP = 1'b0;
                stato_prossimo = 2'b00;

            end else begin
                
                INIZIO_CONTO = 1'b0;
                INIZIO_SETUP = 1'b1;
                stato_prossimo = 2'b01;

            end

            2'b10:
            if (~INIZIO && ~FINE_CONTO) begin

                INIZIO_CONTO = 1'b1;
                INIZIO_SETUP = 1'b0;
                stato_prossimo = 2'b10;

            end else if (INIZIO) begin
                
                INIZIO_CONTO = 1'b0;
                INIZIO_SETUP = 1'b1;
                stato_prossimo = 2'b01;

            end else begin
                
                INIZIO_CONTO = 1'b0;
                INIZIO_SETUP = 1'b0;
                stato_prossimo = 2'b00;

            end
        endcase
    end
    
    //////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////

    always @(*) begin : DATAPATH

        //--- LOGICA DETERMINAZIONE VINCITORE DELLA MANCHE ---\\

        case ({SECONDO,PRIMO})

                // nel caso 0000 la scelta è ricadura su MANCHE <= 2'b00 dato il "rifiuto" di giocare
                4'b0000: MANCHE = 2'b00; // MANCHE ANNULLATA

                4'b0001: MANCHE = (((vincitore_manche_precedente == 2'b01 && mossa_giocatore_1 == mossa_vincitrice) || (vincitore_manche_precedente == 2'b10 && mossa_giocatore_2 == mossa_vincitrice)) && (INIZIO_SETUP == 1)) ? 2'b00 : 2'b01; // primo

                4'b0010: MANCHE = (((vincitore_manche_precedente == 2'b01 && mossa_giocatore_1 == mossa_vincitrice) || (vincitore_manche_precedente == 2'b10 && mossa_giocatore_2 == mossa_vincitrice)) && (INIZIO_SETUP == 1)) ? 2'b00 : 2'b01; // primo

                4'b0011: MANCHE = (((vincitore_manche_precedente == 2'b01 && mossa_giocatore_1 == mossa_vincitrice) || (vincitore_manche_precedente == 2'b10 && mossa_giocatore_2 == mossa_vincitrice)) && (INIZIO_SETUP == 1)) ? 2'b00 : 2'b01; // primo 

                4'b0100: MANCHE = (((vincitore_manche_precedente == 2'b01 && mossa_giocatore_1 == mossa_vincitrice) || (vincitore_manche_precedente == 2'b10 && mossa_giocatore_2 == mossa_vincitrice)) && (INIZIO_SETUP == 1)) ? 2'b00 : 2'b10; // secondo

                4'b0101: MANCHE = (((vincitore_manche_precedente == 2'b01 && mossa_giocatore_1 == mossa_vincitrice) || (vincitore_manche_precedente == 2'b10 && mossa_giocatore_2 == mossa_vincitrice)) && (INIZIO_SETUP == 1)) ? 2'b00 : 2'b11; // pareggio

                4'b0110: MANCHE = (((vincitore_manche_precedente == 2'b01 && mossa_giocatore_1 == mossa_vincitrice) || (vincitore_manche_precedente == 2'b10 && mossa_giocatore_2 == mossa_vincitrice)) && (INIZIO_SETUP == 1)) ? 2'b00 : 2'b01; // primo

                4'b0111: MANCHE = (((vincitore_manche_precedente == 2'b01 && mossa_giocatore_1 == mossa_vincitrice) || (vincitore_manche_precedente == 2'b10 && mossa_giocatore_2 == mossa_vincitrice)) && (INIZIO_SETUP == 1)) ? 2'b00 : 2'b10; // secondo

                4'b1000: MANCHE = (((vincitore_manche_precedente == 2'b01 && mossa_giocatore_1 == mossa_vincitrice) || (vincitore_manche_precedente == 2'b10 && mossa_giocatore_2 == mossa_vincitrice)) && (INIZIO_SETUP == 1)) ? 2'b00 : 2'b010; // secondo

                4'b1001: MANCHE = (((vincitore_manche_precedente == 2'b01 && mossa_giocatore_1 == mossa_vincitrice) || (vincitore_manche_precedente == 2'b10 && mossa_giocatore_2 == mossa_vincitrice)) && (INIZIO_SETUP == 1)) ? 2'b00 : 2'b010; // secondo

                4'b1010: MANCHE = (((vincitore_manche_precedente == 2'b01 && mossa_giocatore_1 == mossa_vincitrice) || (vincitore_manche_precedente == 2'b10 && mossa_giocatore_2 == mossa_vincitrice)) && (INIZIO_SETUP == 1)) ? 2'b00 : 2'b11; // pareggio

                4'b1011: MANCHE = (((vincitore_manche_precedente == 2'b01 && mossa_giocatore_1 == mossa_vincitrice) || (vincitore_manche_precedente == 2'b10 && mossa_giocatore_2 == mossa_vincitrice)) && (INIZIO_SETUP == 1)) ? 2'b00 : 2'b01; // primo

                4'b1100: MANCHE = (((vincitore_manche_precedente == 2'b01 && mossa_giocatore_1 == mossa_vincitrice) || (vincitore_manche_precedente == 2'b10 && mossa_giocatore_2 == mossa_vincitrice)) && (INIZIO_SETUP == 1)) ? 2'b00 : 2'b10; // secondo

                4'b1101: MANCHE = (((vincitore_manche_precedente == 2'b01 && mossa_giocatore_1 == mossa_vincitrice) || (vincitore_manche_precedente == 2'b10 && mossa_giocatore_2 == mossa_vincitrice)) && (INIZIO_SETUP == 1)) ? 2'b00 : 2'b01; // primo

                4'b1110: MANCHE = (((vincitore_manche_precedente == 2'b01 && mossa_giocatore_1 == mossa_vincitrice) || (vincitore_manche_precedente == 2'b10 && mossa_giocatore_2 == mossa_vincitrice)) && (INIZIO_SETUP == 1)) ? 2'b00 : 2'b10; // secondo

                4'b1111: MANCHE = (((vincitore_manche_precedente == 2'b01 && mossa_giocatore_1 == mossa_vincitrice) || (vincitore_manche_precedente == 2'b10 && mossa_giocatore_2 == mossa_vincitrice)) && (INIZIO_SETUP == 1)) ? 2'b00 : 2'b11; // pareggio

                default: MANCHE =  2'b00;
            endcase

            if (1) begin
                mossa_giocatore_1 = PRIMO;
                mossa_giocatore_2 = SECONDO;
            end


            //--- LOGICA DETERMINAZIONE VINCITORE DELLA MANCHE ---\\

            if (INIZIO_SETUP) begin
                numero_manche = {SECONDO,PRIMO} + 5'b00100;
            end 
            else begin
                numero_manche = numero_manche + 5'b00000;
            end

            //--- LOGICA PER L'INCREMENTO DEI REGISTRI A SECONDA DEL VINCITORE DELLA MANCHE ---\\

            // case (MANCHE)

            //     2'b01: manche_vinte_primo = (INIZIO_CONTO == 1'b1) ? manche_vinte_primo++ : manche_vinte_primo = 5'b00000;

            //     2'b10: manche_vinte_secondo = (INIZIO_CONTO == 1'b1) ? manche_vinte_secondo++ : manche_vinte_secondo = 5'b00000;

            //     2'b11: registro_pareggi = (INIZIO_CONTO == 1'b1) ? registro_pareggi++ : registro_pareggi = 5'b00000;

            // endcase

            case (MANCHE)

                2'b01: if (INIZIO_CONTO == 1'b1) begin
                            manche_vinte_primo = manche_vinte_primo++;
                        end else begin
                            manche_vinte_primo = 5'b00000;
                        end

                2'b10: if (INIZIO_CONTO == 1'b1) begin
                            manche_vinte_secondo = manche_vinte_secondo++;
                        end else begin
                            manche_vinte_secondo = 5'b00000;
                        end

                2'b11: if (INIZIO_CONTO == 1'b1) begin
                            registro_pareggi = registro_pareggi++;
                        end else begin
                            registro_pareggi = 5'b00000;
                        end
            endcase


            //--- LOGICA PER LA DETERMINAZIONE DI FINE CONTO ---\\

            if ((manche_vinte_primo + manche_vinte_secondo + registro_pareggi) == numero_manche) begin
                FINE_CONTO = 1'b1;
            end
            else if (manche_vinte_primo + manche_vinte_secondo + registro_pareggi >= 5'b00100) begin
                    if ((manche_vinte_primo - manche_vinte_secondo >= 5'b00010)) begin
                        if ((manche_vinte_primo - manche_vinte_secondo < 5'b11100)) begin
                            FINE_CONTO = 1'b1;
                    end
                end
            end
            else FINE_CONTO = 1'b0;

            if (FINE_CONTO == 0) begin
                temp1 = 2'b11;
            end else
            if (FINE_CONTO == 1) begin
                temp1 = 2'b01;
            end

            else if (manche_vinte_primo + manche_vinte_secondo + registro_pareggi >= 5'b00100) begin
                    if ((manche_vinte_secondo - manche_vinte_primo >= 5'b00010)) begin
                        if ((manche_vinte_secondo - manche_vinte_primo < 5'b11100)) begin
                            FINE_CONTO = 1'b1;
                    end
                end
            end
            else FINE_CONTO = 1'b0;

            if (FINE_CONTO == 0) begin
                temp2 = 2'b11;
            end else
            if (FINE_CONTO == 1) begin
                temp2 = 2'b10;
            end

            case (temp1)
                2'b00: PARTITA = 2'b00;
                2'b01: PARTITA = 2'b01;
                2'b10: PARTITA = temp1;
                2'b11: PARTITA = temp1;
            endcase

            // else FINE_CONTO = 1'b0;


            //--- LOGICA PER LA DETERMINAZIONE DELLO STATO DELLA PARTITA ---\\


            if (FINE_CONTO == 1'b1) begin
                if (PARTITA == 2'b11 && (manche_vinte_primo - manche_vinte_secondo == 5'b00001)) begin
                    case (MANCHE)
                        2'b00: PARTITA = 2'b00;
                        2'b01: PARTITA = 2'b01;
                        2'b10: PARTITA = 2'b10;
                        2'b11: PARTITA = 2'b00;
                    endcase
                end else 

                if (PARTITA == 2'b11 && (manche_vinte_secondo - manche_vinte_primo  == 5'b00001)) begin
                    case (MANCHE)
                        2'b00: PARTITA = 2'b00;
                        2'b01: PARTITA = 2'b01;
                        2'b10: PARTITA = 2'b10;
                        2'b11: PARTITA = 2'b00;
                    endcase
                end

                else begin
                    PARTITA = PARTITA;
                end
            end
            if (FINE_CONTO == 1'b0) begin
                PARTITA = 2'b00;
            end
        end  
endmodule
