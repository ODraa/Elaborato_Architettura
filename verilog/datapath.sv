module datapath (

    input clk,

    // segnali di I/O già noti
    input INIZIO_SETUP,
    input INIZIO_CONTO,
    input wire [1:0] PRIMO,
    input wire [1:0] SECONDO,
    output reg [1:0] MANCHE,
    output reg [1:0] PARTITA,
    output reg FINE_CONTO
);


    // dichiarazione dei registri
    reg [1:0] vincitore_manche_precedente;
    reg [1:0] mossa_vincitrice;
    reg [4:0] registro_pareggi;
    reg [4:0] manche_vinte_primo;
    reg [4:0] manche_vinte_secondo;
    reg [4:0] numero_manche;

    reg [1:0] mossa_giocatore_1 = 2'b00;
    reg [1:0] mossa_giocatore_2 = 2'b00;

    reg tempA = 1'b0;
    reg tempB = 1'b0;
    reg [1:0] tempC = 2'b00;
    reg [1:0] tempD = 2'b00;
    reg [1:0] tempE = 2'b00;
    
    
    //////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////

    always @(posedge clk) begin : DATAPATH

     // Reset delle variabili temporanee alla fine del ciclo di clock
    tempA <= 1'b0;
    tempB <= 1'b0;
    tempC <= 2'b00;
    tempD <= 2'b00;
    tempE <= 2'b00;

        //--- LOGICA DI SETUP ---\\


        if (INIZIO_SETUP == 1) begin
            numero_manche = {SECONDO, PRIMO} + 5'b00100;
        end
        else begin
            numero_manche = numero_manche + 5'b00000;
        end



        //--- LOGICA DETERMINAZIONE VINCITORE DELLA MANCHE ---\\

        if (((vincitore_manche_precedente == 2'b01 && mossa_giocatore_1 == mossa_vincitrice) || (vincitore_manche_precedente == 2'b10 && mossa_giocatore_2 == mossa_vincitrice))) begin 
            MANCHE = 2'b00;
        end else begin
            case ({SECONDO, PRIMO})
                4'b0000: MANCHE = 2'b00;
                4'b0001: MANCHE = 2'b01;
                4'b0010: MANCHE = 2'b01;
                4'b0011: MANCHE = 2'b01;
                4'b0100: MANCHE = 2'b10;
                4'b0101: MANCHE = 2'b11;
                4'b0110: MANCHE = 2'b01;
                4'b0111: MANCHE = 2'b10;
                4'b1000: MANCHE = 2'b10;
                4'b1001: MANCHE = 2'b10;
                4'b1010: MANCHE = 2'b11;
                4'b1011: MANCHE = 2'b01;
                4'b1100: MANCHE = 2'b10;
                4'b1101: MANCHE = 2'b01;
                4'b1110: MANCHE = 2'b10;
                4'b1111: MANCHE = 2'b11;
            endcase

            // PROVA A METTERE ELSE IF O RIFAI IN ALTRO MODO O CAPISCI COME FARE

            // if (MANCHE == 2'b01) begin
            //     vincitore_manche_precedente = 2'b01;
            //     mossa_vincitrice = PRIMO;
            // end
            // if (MANCHE == 2'b10) begin
            //     vincitore_manche_precedente = 2'b10;
            //     mossa_vincitrice = SECONDO;
            // end
            // if (MANCHE == 2'b11) begin
            //     vincitore_manche_precedente = 2'b11;
            //     mossa_vincitrice = 2'b00;
            // end
            // if (MANCHE == 2'b00) begin
            //     vincitore_manche_precedente = 2'b00;
            //     mossa_vincitrice = 2'b00;
            // end
        end

                mossa_giocatore_1 = PRIMO;
                mossa_giocatore_2 = SECONDO;



            //--- LOGICA INCREMENTO REGISTRI ---\\

            if (INIZIO_CONTO) begin
                case (MANCHE)

                    2'b01: manche_vinte_primo = manche_vinte_primo + 1;

                    2'b10: manche_vinte_secondo = manche_vinte_secondo + 1;

                    2'b11: registro_pareggi = registro_pareggi + 1;
                endcase
            end 
            else begin
                manche_vinte_primo = 5'b00000;
                manche_vinte_secondo = 5'b00000;
                registro_pareggi = 5'b00000;
            end
            


            //--- LOGICA PER LA DETERMINAZIONE DI FINE CONTO ---\\

            if ((manche_vinte_primo + manche_vinte_secondo + registro_pareggi) == numero_manche) begin
                FINE_CONTO = 1'b1;
            end
            else if ((manche_vinte_primo + manche_vinte_secondo + registro_pareggi) >= 5'b00100) begin
                if (((manche_vinte_primo - manche_vinte_secondo) >= 5'b00010) && (manche_vinte_primo - manche_vinte_secondo) < 5'b11100) begin
                    FINE_CONTO = 1'b1;
                    tempA = 1'b1;
                end 
                else if (((manche_vinte_secondo - manche_vinte_primo) >= 5'b00010) && (manche_vinte_secondo - manche_vinte_primo) < 5'b11100) begin
                    FINE_CONTO = 1'b1;
                    tempB = 1'b1;
                end
            end
            else begin
                FINE_CONTO = 1'b0;
            end

            //--- LOGICA PER LA DETERMINAZIONE DI PARTITA ---\\
            
            case (tempA)
                1'b0: tempC = 2'b11;
                1'b1: tempC = 2'b01;
            endcase

            case (tempB)
                1'b0: tempD = 2'b11;
                1'b1: tempD = 2'b10;
            endcase

            case (tempC)
                2'b00: tempE = 2'b00;
                2'b01: tempE = 2'b01;
                2'b10: tempE = tempD;
                2'b11: tempE = tempD;
            endcase


            if (((tempE == 2'b11) && ((manche_vinte_primo - manche_vinte_secondo) == 5'b00001)) || ((tempE == 2'b11) && ((manche_vinte_secondo - manche_vinte_primo) == 5'b00001))) begin
                
                case (MANCHE)
                    2'b00: tempE = 2'b00;
                    2'b01: tempE = 2'b01;
                    2'b10: tempE = 2'b10;
                    2'b11: tempE = 2'b00;
                endcase
            end else begin
                tempE = tempE;
            end


            if (FINE_CONTO == 1) begin
                PARTITA = tempE;
            end else begin
                PARTITA = 2'b00;
            end
        end  
endmodule
