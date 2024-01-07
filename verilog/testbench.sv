module testbench;

    // parametri di simulazione
    parameter clk_period = 10; // periodo del clk in unita di tempo

    // segnali di ingresso
    reg clk;
    reg [1:0] PRIMO;
    reg [1:0] SECONDO;
    reg INIZIA;

    //segnali di uscita
    wire [1:0] MANCHE;
    wire [1:0] PARTITA;

    // connessione del modulo
    moduleName uut (
        .clk(clk),
        .PRIMO(PRIMO),
        .SECONDO(SECONDO),
        .INIZIA(INIZIA),
        .MANCHE(MANCHE),
        .PARTITA(PARTITA)
    );

    // stimoli di test
    initial begin
        PRIMO = 2'b00;
        SECONDO = 2'b00;
        INIZIA = 1'b1;

        // prima manche
        #50 PRIMO = 2'b01;
        #50 SECONDO = 2'b10;
        #50 INIZIA = 1'b0;

        // seconda manche
        #100 PRIMO = 2'b01;
        #100 SECONDO = 2'b10;
        #100 INIZIA = 1'b0;

        // terza manche
        #150 PRIMO = 2'b01;
        #150 SECONDO = 2'b11;
        #150 INIZIA = 1'b0;

        // terza manche
        #200 PRIMO = 2'b10;
        #200 SECONDO = 2'b10;
        #200 INIZIA = 1'b0;

        #250 $finish; // termina la simulazione dopo 100 unita di tempo
    end

    // Monitoraggio delle uscite
    always @(posedge clk) begin
        $$display("Time = %0t PRIMO = %b SECONDO = %b INIZIA = %b MANCHE = %b PARTITA = %b",
        $time, PRIMO, SECONDO, INIZIA, MANCHE, PARTITA);
    end
endmodule