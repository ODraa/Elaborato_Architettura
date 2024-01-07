/*

NOTE DA CONTROLLARE

- nel controllo dove viene resettato il circuito verifica se serve un initial
- controlla bene il funzionamento degl input INIZIA e del loro cambio di valore

*/


module moduleName (

            // Segnale di clock
            input wire clk,
    
            // Ingressi del Circuito
            input wire [1:0] PRIMO,
            input wire [1:0] SECONDO,
            input wire [0:0] INIZIA = 1'b1,  // Impostato a 1 di default
    
            // Uscite del Circuito
            output wire [1:0] MANCHE,
            output wire [1:0] PARTITA
        );      

        // Registri per la memorizzazione delle vittorie

        reg [4:0] winPrimo = 5'b00000; // vittorie delle manche
        reg [4:0] winSecondo = 5'b00000; // vittorie delle manche
        reg [1:0] mossaVincitore = 2'b00; // inizializzato a "nessuna mossa"
        reg [4:0] contatoreManche = 5'b00000;
        reg [4:0] nPartite = 5'b00000;
        reg [4:0] partiteVintePrimo = 5'b00000;
        reg [4:0] partiteVinteSecondo = 5'b00000;
    

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
            if (contatoreManche >= 5'b00100 && contatoreManche <= 5'b10011) begin
                if (winPrimo - winSecondo == 5'b00010) begin
                    partiteVintePrimo++;

                    // RESET DELLE MANCHE IN CASO DI VITTORIA DELLA PARTITA DELLE VITTORIE DI PRIMO, SECONDO E CONTATORE MANCHE
                    winPrimo <= 5'b00000; // vittorie delle manche
                    winSecondo <= 5'b00000; // vittorie delle manche
                    contatoreManche <= 5'b00000;

                    // RESET TOTALE IN CASO DI RAGGIUNGIMENTO DEL NUMERO MASSIMO DI PARTITE
                    if (partiteVintePrimo + partiteVinteSecondo == nPartite) begin
                        INIZIA <= 1'b1;
                        winPrimo <= 5'b00000; 
                        winSecondo <= 5'b00000; 
                        mossaVincitore <= 2'b00;
                        contatoreManche <= 5'b00000;
                        nPartite <= 5'b00000;
                        partiteVintePrimo <= 5'b00000;
                        partiteVinteSecondo <= 5'b00000;
                    end
                end
                if (winSecondo - winPrimo == 5'b00010) begin
                    partiteVinteSecondo++;

                    // RESET IN CASO DI VITTORIA DELLA PARTITA DELLE VITTORIE DI PRIMO, SECONDO E CONTATORE MANCHE
                    winPrimo = 5'b00000; // vittorie delle manche
                    winSecondo = 5'b00000; // vittorie delle manche
                    contatoreManche = 5'b00000;

                    // RESET TOTALE IN CASO DI RAGGIUNGIMENTO DEL NUMERO MASSIMO DI PARTITE
                    if (partiteVintePrimo + partiteVinteSecondo == nPartite) begin
                        INIZIA <= 1'b1;
                        winPrimo <= 5'b00000; 
                        winSecondo <= 5'b00000; 
                        mossaVincitore <= 2'b00;
                        contatoreManche <= 5'b00000;
                        nPartite <= 5'b00000;
                        partiteVintePrimo <= 5'b00000;
                        partiteVinteSecondo <= 5'b00000;
                    end
                end
            end

            case ({PRIMO, SECONDO})

                4'b0000: begin // manche non valida
                    if (vincitore == 1'b1 && mossaVincitore == {SECONDO}) begin
                        MANCHE <= 1'b00;
                    end
                    else if (vincitore == 1'b0 && mossaVincitore == {PRIMO}) begin
                        MANCHE <= 1'b00;
                    end
                end
                4'b0001: begin // considerata vittoria a tavolino

                    if (vincitore == 1'b1 && mossaVincitore == {SECONDO}) begin
                        MANCHE <= 1'b00;
                    end
                    else if (vincitore == 1'b0 && mossaVincitore == {PRIMO}) begin
                        MANCHE <= 1'b00;
                    end
                    else begin
                        contatoreManche ++;
                        winSecondo ++;
                        // mossaVincitore = {SECONDO};
                        vincitore = 1'b1;
                    end
                end
                4'b0010: begin

                    if (vincitore == 1'b1 && mossaVincitore == {SECONDO}) begin
                        MANCHE <= 1'b00;
                    end
                    else if (vincitore == 1'b0 && mossaVincitore == {PRIMO}) begin
                        MANCHE <= 1'b00;
                    end
                    else begin
                        contatoreManche ++;
                        winSecondo ++;
                        // mossaVincitore = {SECONDO};
                        vincitore = 1'b1;
                    end
                end
                4'b0011: begin

                    if (vincitore == 1'b1 && mossaVincitore == {SECONDO}) begin
                        MANCHE <= 1'b00;
                    end
                    else if (vincitore == 1'b0 && mossaVincitore == {PRIMO}) begin
                        MANCHE <= 1'b00;
                    end
                    else begin
                        contatoreManche ++;
                        winSecondo ++;
                        // mossaVincitore = {SECONDO};
                        vincitore = 1'b1;
                    end
                end
                /////////////////////////////////////////

                4'b0100: begin
                    if (vincitore == 1'b1 && mossaVincitore == {SECONDO}) begin
                        MANCHE <= 1'b00;
                    end
                    else if (vincitore == 1'b0 && mossaVincitore == {PRIMO}) begin
                        MANCHE <= 1'b00;
                    end
                    else begin
                        contatoreManche ++;
                        winPrimo ++;
                        // mossaVincitore = {PRIMO}; visto che la mossa è non giocata non segno la mossa vincitrice senno si va in un loop di pareggi
                        vincitore = 1'b0;
                    end
                end
                4'b0101: begin

                    if (vincitore == 1'b1 && mossaVincitore == {SECONDO}) begin
                        MANCHE <= 1'b00;
                    end
                    else if (vincitore == 1'b0 && mossaVincitore == {PRIMO}) begin
                        MANCHE <= 1'b00;
                    end
                    else begin
                        contatoreManche ++;
                    end
                    
                    // controlla eventuali errori per quanto riguarda la mossa del vincitore
                end
                4'b0110: begin

                    if (vincitore == 1'b1 && mossaVincitore == {SECONDO}) begin
                        MANCHE <= 1'b00;
                    end
                    else if (vincitore == 1'b0 && mossaVincitore == {PRIMO}) begin
                        MANCHE <= 1'b00;
                    end
                    else begin
                        contatoreManche ++;
                        winSecondo ++;
                        mossaVincitore = {SECONDO};
                        vincitore = 1'b1;
                    end
                end
                4'b0111: begin

                    if (vincitore == 1'b1 && mossaVincitore == {SECONDO}) begin
                        MANCHE <= 1'b00;
                    end
                    else if (vincitore == 1'b0 && mossaVincitore == {PRIMO}) begin
                        MANCHE <= 1'b00;
                    end
                    else begin
                        contatoreManche ++;
                        winPrimo ++;
                        mossaVincitore = {PRIMO};
                        vincitore = 1'b0;
                    end
                end
                /////////////////////////////////////////

                4'b1000: begin

                    if (vincitore == 1'b1 && mossaVincitore == {SECONDO}) begin
                        MANCHE <= 1'b00;
                    end
                    else if (vincitore == 1'b0 && mossaVincitore == {PRIMO}) begin
                        MANCHE <= 1'b00;
                    end
                    else begin
                        contatoreManche ++;
                        winPrimo ++;
                        // mossaVincitore = {PRIMO};
                        vincitore = 1'b0;
                    end  
                end
                4'b1001: begin

                    if (vincitore == 1'b1 && mossaVincitore == {SECONDO}) begin
                        MANCHE <= 1'b00;
                    end
                    else if (vincitore == 1'b0 && mossaVincitore == {PRIMO}) begin
                        MANCHE <= 1'b00;
                    end
                    else begin
                        contatoreManche ++;
                        winPrimo ++;
                        mossaVincitore = {PRIMO};
                        vincitore = 1'b0;
                    end
                end
                4'b1010: begin

                    if (vincitore == 1'b1 && mossaVincitore == {SECONDO}) begin
                        MANCHE <= 1'b00;
                    end
                    else if (vincitore == 1'b0 && mossaVincitore == {PRIMO}) begin
                        MANCHE <= 1'b00;
                    end
                    else begin
                        contatoreManche ++;
                        // controlla eventuali errori per quanto riguarda la mossa del vincitore
                    end
                end
                4'b1011: begin

                    if (vincitore == 1'b1 && mossaVincitore == {SECONDO}) begin
                        MANCHE <= 1'b00;
                    end
                    else if (vincitore == 1'b0 && mossaVincitore == {PRIMO}) begin
                        MANCHE <= 1'b00;
                    end
                    else begin
                        contatoreManche ++;
                        winSecondo ++;
                        mossaVincitore = {SECONDO};
                        vincitore = 1'b1;
                    end
                end
                /////////////////////////////////////////

                4'b1100: begin

                    if (vincitore == 1'b1 && mossaVincitore == {SECONDO}) begin
                        MANCHE <= 1'b00;
                    end
                    else if (vincitore == 1'b0 && mossaVincitore == {PRIMO}) begin
                        MANCHE <= 1'b00;
                    end
                    else begin
                        contatoreManche ++;
                        winPrimo ++;
                        // mossaVincitore = {PRIMO};
                        vincitore = 1'b0;
                    end
                end
                4'b1101: begin

                    if (vincitore == 1'b1 && mossaVincitore == {SECONDO}) begin
                        MANCHE <= 1'b00;
                    end
                    else if (vincitore == 1'b0 && mossaVincitore == {PRIMO}) begin
                        MANCHE <= 1'b00;
                    end
                    else begin
                        contatoreManche ++;
                        winSecondo ++;
                        mossaVincitore = {SECONDO};
                        vincitore = 1'b1;
                    end
                end
                4'b1110: begin

                    if (vincitore == 1'b1 && mossaVincitore == {SECONDO}) begin
                        MANCHE <= 1'b00;
                    end
                    else if (vincitore == 1'b0 && mossaVincitore == {PRIMO}) begin
                        MANCHE <= 1'b00;
                    end
                    else begin
                        contatoreManche ++;
                        winPrimo ++;
                        mossaVincitore = {PRIMO};
                        vincitore = 1'b0;
                    end
                end
                4'b1111: begin

                    if (vincitore == 1'b1 && mossaVincitore == {SECONDO}) begin
                        MANCHE <= 1'b00;
                    end
                    else if (vincitore == 1'b0 && mossaVincitore == {PRIMO}) begin
                        MANCHE <= 1'b00;
                    end
                    else begin
                        contatoreManche ++;
                        // controlla eventuali errori per quanto riguarda la mossa del vincitore
                    end
                end
                /////////////////////////////////////////

                //default:
            endcase
        end
    end
endmodule