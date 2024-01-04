module moduleName (
    
        // Segnale di clock
        input wire clk,

        // Ingressi del Circuito
        input wire [1:0] PRIMO;
        input wire [1:0] SECONDO,
        input wire [0:0] INIZIA = 1'b1,  // Impostato a 1 di default

        // Uscite del Circuito
        output wire [1:0] MANCHE,
        output wire [1:0] PARTITA,
    );      

    // Registri per la memorizzazione delle vittorie
    
    reg [4:0] winPrimo = 5'b00000;
    reg [4:0] winSecondo = 5'b00000;
    reg [1:0] mossaVincitore;
    reg [4:0] contatoreManche = 5'b00000;
    reg [4:0] nPartite = 5'b00000;
    reg [4:0] partiteVintePrimo;
    reg [4:0] partiteVinteSecondo;

    reg [0:0] vincitore; // valore a 1bit che oscilla tra 0 e 1 a seconda del vincitore tra PRIMO e SECONDA

    // se il valore di INIZIA = 1 allora entra nelle casistiche assegnando il valore a nPartite
    // appena verifica una delle casistiche, imposta il valore di INIZIA = 0 cosi da non eseguire piu il blocco
    always @(posedge clk) begin
        if (INIZIA == 1'b1) begin
            case ({PRIMO, SECONDO}) //concatenazione di PRIMO e SECONDO
                4'b00??: nPartite <= {PRIMO, SECONDO};
                4'b01??: nPartite <= {PRIMO, SECONDO};
                4'b10??: nPartite <= {PRIMO, SECONDO};
                4'b11??: nPartite <= {PRIMO, SECONDO};
            endcase;
            INIZIA <= 1'b0;
        end
        else if (INIZIA == 1'b0) begin

            

            case ({PRIMO, SECONDO})

                4'b00 00: // manche non valida

                4'b00 01: // considerata vittoria a tavolino

                    if (vincitore == 1'b1 && mossaVincitore == {SECONDO}) begin
                        MANCHE = 1'b00;
                    end
                    else if (vincitore == 1'b0 && mossaVincitore == {PRIMO}) begin
                        MANCHE = 1'b00;
                    end
                    else begin
                        contatoreManche += 5'b00001;
                        winSecondo += 5'b00001;
                        // mossaVincitore = {SECONDO};
                        vincitore = 1;
                    end

                4'b00 10:

                    if (vincitore == 1'b1 && mossaVincitore == {SECONDO}) begin
                        MANCHE = 1'b00;
                    end
                    else if (vincitore == 1'b0 && mossaVincitore == {PRIMO}) begin
                        MANCHE = 1'b00;
                    end
                    else begin
                        contatoreManche += 5'b00001;
                        winSecondo += 5'b00001;
                        // mossaVincitore = {SECONDO};
                    end

                4'b00 11:

                    if (vincitore == 1'b1 && mossaVincitore == {SECONDO}) begin
                        MANCHE = 1'b00;
                    end
                    else if (vincitore == 1'b0 && mossaVincitore == {PRIMO}) begin
                        MANCHE = 1'b00;
                    end
                    else begin
                        contatoreManche += 5'b00001;
                        winSecondo += 5'b00001;
                        // mossaVincitore = {SECONDO};
                    end

                /////////////////////////////////////////

                4'b01 00:
                    if (vincitore == 1'b1 && mossaVincitore == {SECONDO}) begin
                        MANCHE = 1'b00;
                    end
                    else if (vincitore == 1'b0 && mossaVincitore == {PRIMO}) begin
                        MANCHE = 1'b00;
                    end
                    else begin
                        contatoreManche += 5'b00001;
                        winPrimo += 5'b00001;
                        // mossaVincitore = {PRIMO}; visto che la mossa è non giocata non segno la mossa vincitrice senno si va in un loop di pareggi
                    end

                4'b01 01: 

                    if (vincitore == 1'b1 && mossaVincitore == {SECONDO}) begin
                        MANCHE = 1'b00;
                    end
                    else if (vincitore == 1'b0 && mossaVincitore == {PRIMO}) begin
                        MANCHE = 1'b00;
                    end
                    else begin
                        contatoreManche += 5'b00001;
                    end
                    
                    // controlla eventuali errori per quanto riguarda la mossa del vincitore

                4'b01 10: 

                    if (vincitore == 1'b1 && mossaVincitore == {SECONDO}) begin
                        MANCHE = 1'b00;
                    end
                    else if (vincitore == 1'b0 && mossaVincitore == {PRIMO}) begin
                        MANCHE = 1'b00;
                    end
                    else begin
                        contatoreManche += 5'B00001;
                        winSecondo += 5'b00001;
                        mossaVincitore = {SECONDO};
                    end

                4'b01 11:

                    if (vincitore == 1'b1 && mossaVincitore == {SECONDO}) begin
                        MANCHE = 1'b00;
                    end
                    else if (vincitore == 1'b0 && mossaVincitore == {PRIMO}) begin
                        MANCHE = 1'b00;
                    end
                    else begin
                        contatoreManche += 5'B00001;
                        winPrimo += 5'b00001;
                        mossaVincitore = {PRIMO};
                    end

                /////////////////////////////////////////

                4'b10 00:

                    if (vincitore == 1'b1 && mossaVincitore == {SECONDO}) begin
                        MANCHE = 1'b00;
                    end
                    else if (vincitore == 1'b0 && mossaVincitore == {PRIMO}) begin
                        MANCHE = 1'b00;
                    end
                    else begin
                        contatoreManche += 5'b00001;
                        winPrimo += 5'b00001;
                        // mossaVincitore = {PRIMO};
                    end  

                4'b10 01:

                    if (vincitore == 1'b1 && mossaVincitore == {SECONDO}) begin
                        MANCHE = 1'b00;
                    end
                    else if (vincitore == 1'b0 && mossaVincitore == {PRIMO}) begin
                        MANCHE = 1'b00;
                    end
                    else begin
                        contatoreManche += 5'B00001;
                        winPrimo += 5'b00001;
                        mossaVincitore = {PRIMO};
                    end

                4'b10 10: 

                    if (vincitore == 1'b1 && mossaVincitore == {SECONDO}) begin
                        MANCHE = 1'b00;
                    end
                    else if (vincitore == 1'b0 && mossaVincitore == {PRIMO}) begin
                        MANCHE = 1'b00;
                    end
                    else begin
                        contatoreManche += 5'b00001;
                        // controlla eventuali errori per quanto riguarda la mossa del vincitore
                    end

                4'b10 11:

                    if (vincitore == 1'b1 && mossaVincitore == {SECONDO}) begin
                        MANCHE = 1'b00;
                    end
                    else if (vincitore == 1'b0 && mossaVincitore == {PRIMO}) begin
                        MANCHE = 1'b00;
                    end
                    else begin
                        contatoreManche += 5'B00001;
                        winSecondo += 5'b00001;
                        mossaVincitore = {SECONDO};
                    end

                /////////////////////////////////////////

                4'b11 00:

                    if (vincitore == 1'b1 && mossaVincitore == {SECONDO}) begin
                        MANCHE = 1'b00;
                    end
                    else if (vincitore == 1'b0 && mossaVincitore == {PRIMO}) begin
                        MANCHE = 1'b00;
                    end
                    else begin
                        contatoreManche += 5'b00001;
                        winPrimo += 5'b00001;
                        // mossaVincitore = {PRIMO};
                    end

                4'b11 01:

                    if (vincitore == 1'b1 && mossaVincitore == {SECONDO}) begin
                        MANCHE = 1'b00;
                    end
                    else if (vincitore == 1'b0 && mossaVincitore == {PRIMO}) begin
                        MANCHE = 1'b00;
                    end
                    else begin
                        contatoreManche += 5'B00001;
                        winSecondo += 5'b00001;
                        mossaVincitore = {SECONDO};
                    end

                4'b11 10:

                    if (vincitore == 1'b1 && mossaVincitore == {SECONDO}) begin
                        MANCHE = 1'b00;
                    end
                    else if (vincitore == 1'b0 && mossaVincitore == {PRIMO}) begin
                        MANCHE = 1'b00;
                    end
                    else begin
                        contatoreManche += 5'B00001;
                        winPrimo += 5'b00001;
                        mossaVincitore = {PRIMO};
                    end

                4'b11 11:

                    if (vincitore == 1'b1 && mossaVincitore == {SECONDO}) begin
                        MANCHE = 1'b00;
                    end
                    else if (vincitore == 1'b0 && mossaVincitore == {PRIMO}) begin
                        MANCHE = 1'b00;
                    end
                    else begin
                        contatoreManche += 5'b00001;
                        // controlla eventuali errori per quanto riguarda la mossa del vincitore
                    end
                    
                /////////////////////////////////////////

                default: ///////////////////////////
            endcase
        end
    end
endmodule