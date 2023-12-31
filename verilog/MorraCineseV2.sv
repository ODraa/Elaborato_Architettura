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

        // Registri per la memorizzazione delle vittorie
        output reg [4:0] nPartite = 5'b00000,
        output reg [4:0] winPrimo = 5'b00000,
        output reg [4:0] winSecondo = 5'b00000
    );      

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
    end

endmodule
