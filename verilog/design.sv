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

                4'b00 01: 

                    contatoreManche += 5'b00001;
                    winSecondo += 5'b00001;
                    mossaVincitore = {SECONDO};

                4'b00 10:

                    contatoreManche += 5'b00001;
                    winSecondo += 5'b00001;
                    mossaVincitore = {SECONDO};

                4'b00 11:

                    contatoreManche += 5'b00001;
                    winSecondo += 5'b00001;
                    mossaVincitore = {SECONDO};

                /////////////////////////////////////////

                4'b01 00:

                    contatoreManche += 5'b00001;
                    winPrimo += 5'b00001;
                    mossaVincitore = {PRIMO};

                4'b01 01: 

                    contatoreManche += 5'b00001;
                    // controlla eventuali errori per quanto riguarda la mossa del vincitore

                4'b01 10: 

                    contatoreManche += 5'B00001;
                    winSecondo += 5'b00001;
                    mossaVincitore = {SECONDO};

                4'b01 11:

                    contatoreManche += 5'B00001;
                    winPrimo += 5'b00001;
                    mossaVincitore = {P};

                /////////////////////////////////////////

                4'b10 00:
                
                    contatoreManche += 5'b00001;
                    winPrimo += 5'b00001;
                    mossaVincitore = {PRIMO};

                4'b10 01:

                    contatoreManche += 5'B00001;
                    winPrimo += 5'b00001;
                    mossaVincitore = {PRIMO};

                4'b10 10: 

                contatoreManche += 5'b00001;
                    // controlla eventuali errori per quanto riguarda la mossa del vincitore

                4'b10 11:

                    contatoreManche += 5'B00001;
                    winSecondo += 5'b00001;
                    mossaVincitore = {SECONDO};

                /////////////////////////////////////////

                4'b11 00:

                contatoreManche += 5'b00001;
                    winPrimo += 5'b00001;
                    mossaVincitore = {PRIMO};

                4'b11 01:

                    contatoreManche += 5'B00001;
                    winSecondo += 5'b00001;
                    mossaVincitore = {SECONDO};

                4'b11 10:
                
                    contatoreManche += 5'B00001;
                    winPrimo += 5'b00001;
                    mossaVincitore = {PRIMO};

                4'b11 11:

                    contatoreManche += 5'b00001;
                    // controlla eventuali errori per quanto riguarda la mossa del vincitore
                /////////////////////////////////////////

                default: 
            endcase
        end
    end

endmodule
