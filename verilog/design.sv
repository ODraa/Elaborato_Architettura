module MorraCinese (

    input clk,

    // segnali di I/O già noti
    input wire INIZIO,
    input wire [1:0] PRIMO,
    input wire [1:0] SECONDO,
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

    reg tempA = 1'b0;
    reg tempB = 1'b0;
    reg tempX = 1'b0;
    reg [1:0] tempC = 2'b00;
    reg [1:0] tempD = 2'b00;
    reg [1:0] tempE = 2'b00;
    reg [1:0] tempM = 2'b00;

    //////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////

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

    always @(posedge clk) begin : DATAPATH
     
        // Reset delle variabili temporanee alla fine del ciclo di clock
        tempA <= 1'b0;
        tempB <= 1'b0;
        tempX <= 1'b0;
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

        case ({SECONDO, PRIMO})
                4'b0000: tempM = 2'b00;
                4'b0001: tempM = 2'b01;
                4'b0010: tempM = 2'b01;
                4'b0011: tempM = 2'b01;
                4'b0100: tempM = 2'b10;
                4'b0101: tempM = 2'b11;
                4'b0110: tempM = 2'b01;
                4'b0111: tempM = 2'b10;
                4'b1000: tempM = 2'b10;
                4'b1001: tempM = 2'b10;
                4'b1010: tempM = 2'b11;
                4'b1011: tempM = 2'b01;
                4'b1100: tempM = 2'b10;
                4'b1101: tempM = 2'b01;
                4'b1110: tempM = 2'b10;
                4'b1111: tempM = 2'b11;
        endcase

        if (vincitore_manche_precedente == 2'b01 && mossa_vincitrice == PRIMO || INIZIO_SETUP == 1) begin
            MANCHE = 2'b00;
        end
        else if (vincitore_manche_precedente == 2'b10 && mossa_vincitrice == SECONDO || INIZIO_SETUP == 1) begin
            MANCHE = 2'b00;
        end
        else begin
            MANCHE = tempM;
        end

        vincitore_manche_precedente = MANCHE;

        case (MANCHE)

            2'b00: mossa_vincitrice = 2'b00;
            2'b01: mossa_vincitrice = PRIMO;
            2'b10: mossa_vincitrice = SECONDO;
            2'b11: mossa_vincitrice = 2'b00;

        endcase

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

        if ((manche_vinte_primo + manche_vinte_secondo + registro_pareggi >= 5'b00100)) begin
            if (((manche_vinte_primo - manche_vinte_secondo) >= 5'b00010) && ((manche_vinte_primo - manche_vinte_secondo) < 5'b11100)) begin
                // FINE_CONTO = 1'b1;
                tempA = 1'b1;
            end
        end else begin
            // FINE_CONTO = 1'b0;
            tempA = 1'b0;
        end

        if ((manche_vinte_primo + manche_vinte_secondo + registro_pareggi >= 5'b00100)) begin
            if (((manche_vinte_secondo - manche_vinte_primo) >= 5'b00010) && ((manche_vinte_secondo - manche_vinte_primo) < 5'b11100)) begin
                // FINE_CONTO = 1'b1;
                tempB = 1'b1;
            end
        end else begin
            // FINE_CONTO = 1'b0;
            tempB = 1'b0;
        end

        if ((manche_vinte_primo + manche_vinte_secondo + registro_pareggi) == numero_manche) begin
            // FINE_CONTO = 1'b1;
            tempX = 1'b1;
        end else begin
            // FINE_CONTO = 1'b0;
            tempX = 1'b0;
        end

        if ((tempA == 1'b1) || (tempB == 1'b1) || (tempX == 1'b1)) begin
            FINE_CONTO = 1'b1;
        end else begin
            FINE_CONTO = 1'b0;
        end

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

        if (((tempE == 2'b11) && (manche_vinte_primo - manche_vinte_secondo == 5'b00001)) || ((tempE == 2'b11) && (manche_vinte_secondo - manche_vinte_primo == 5'b00001))) begin
            if (MANCHE == 2'b11) begin
                if (FINE_CONTO == 1) begin
                    PARTITA = 2'b00;
                end else begin
                    PARTITA = 2'b00;
                end
            end else
            if (MANCHE == 2'b10) begin
                if (FINE_CONTO == 1) begin
                    PARTITA = 2'b10;
                end else begin
                    PARTITA = 2'b00;
                end
            end else
            if (MANCHE == 2'b01) begin
                if (FINE_CONTO == 1) begin
                    PARTITA = 2'b01;
                end else begin
                    PARTITA = 2'b00;
                end
            end else
            if (MANCHE == 2'b00) begin
                if (FINE_CONTO == 1) begin
                    PARTITA = 2'b00;
                end else begin
                    PARTITA = 2'b00;
                end
            end
        end
        else begin
            // PARTITA = tempE;
            if (FINE_CONTO == 1'b1) begin
                PARTITA = tempE;
            end
            else begin
                PARTITA = 2'b00;
            end
            end
        end  
endmodule
