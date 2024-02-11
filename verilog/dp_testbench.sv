// Code your testbench here
// or browse Examples
`timescale 1ns / 1ps

module tb_datapath();

  	// File descriptors.
  	integer tbf, outf;
      
    // Inputs
    reg clk;
    reg INIZIO_CONTO;
    reg INIZIO_SETUP;
    reg [1:0] PRIMO;
    reg [1:0] SECONDO;
    reg FINE_CONTO;

    // Outputs
    wire [1:0] MANCHE;
    wire [1:0] PARTITA;
    
    datapath sem(
      	.clk(clk), 
        .INIZIO_CONTO(INIZIO_CONTO),
        .INIZIO_SETUP(INIZIO_SETUP),
        .FINE_CONTO(FINE_CONTO)
        .PRIMO(PRIMO),
        .SECONDO(SECONDO),
        .MANCHE(MANCHE),
        .PARTITA(PARTITA)
    );
    
    always #10 clk = ~clk;

    initial begin
      $dumpfile("dump.vcd");
      $dumpvars(1);
      tbf = $fopen("testbench.script", "w");
      outf = $fopen("output_verilog.txt", "w");
      $fdisplay(tbf, "read_blif FSMD.blif");
      
      clk = 1'b0;
      //----------------------------------------------------------------------
      SECONDO = 2'b00;
      PRIMO = 2'b00;
      INIZIO_CONTO = 2'b0;
      INIZIO_SETUP = 2'b1;
      $fdisplay(tbf, "simulate %b %b %b %b", INIZIO_SETUP, INIZIO_CONTO, SECONDO, PRIMO);
      #20
      $fdisplay(outf, "Outputs: %b %b", MANCHE, PARTITA);
      //----------------------------------------------------------------------
      SECONDO = 2'b01;
      PRIMO = 2'b10;
      INIZIO_CONTO = 2'b1;
      INIZIO_SETUP = 2'b0;
      $fdisplay(tbf, "simulate %b %b %b %b", INIZIO_SETUP, INIZIO_CONTO, SECONDO, PRIMO);
      #20
      $fdisplay(outf, "Outputs: %b %b", MANCHE, PARTITA);
      //----------------------------------------------------------------------
      SECONDO = 2'b11;
      PRIMO = 2'b10;
      INIZIO_CONTO = 2'b1;
      INIZIO_SETUP = 2'b0;
      $fdisplay(tbf, "simulate %b %b %b %b", INIZIO_SETUP, INIZIO_CONTO, SECONDO, PRIMO);
      #20
      $fdisplay(outf, "Outputs: %b %b", MANCHE, PARTITA);
      //----------------------------------------------------------------------
      SECONDO = 2'b00;
      PRIMO = 2'b01;
      INIZIO_CONTO = 2'b1;
      INIZIO_SETUP = 2'b0;
      $fdisplay(tbf, "simulate %b %b %b %b", INIZIO_SETUP, INIZIO_CONTO, SECONDO, PRIMO);
      #20
      $fdisplay(outf, "Outputs: %b %b", MANCHE, PARTITA);
      //----------------------------------------------------------------------
      SECONDO = 2'b00;
      PRIMO = 2'b11;
      INIZIO_CONTO = 2'b1;
      INIZIO_SETUP = 2'b0;
      $fdisplay(tbf, "simulate %b %b %b %b", INIZIO_SETUP, INIZIO_CONTO, SECONDO, PRIMO);
      #20
      $fdisplay(outf, "Outputs: %b %b", MANCHE, PARTITA);
      //----------------------------------------------------------------------
      SECONDO = 2'b00;
      PRIMO = 2'b10;
      INIZIO_CONTO = 2'b1;
      INIZIO_SETUP = 2'b0;
      $fdisplay(tbf, "simulate %b %b %b %b", INIZIO_SETUP, INIZIO_CONTO, SECONDO, PRIMO);
      #20
      $fdisplay(outf, "Outputs: %b %b", MANCHE, PARTITA);
      //----------------------------------------------------------------------



      SECONDO = 2'b00;
      PRIMO = 2'b00;
      INIZIO_CONTO = 2'b0;
      INIZIO_SETUP = 2'b1;
      $fdisplay(tbf, "simulate %b %b %b %b", INIZIO_SETUP, INIZIO_CONTO, SECONDO, PRIMO);
      #20
      $fdisplay(outf, "Outputs: %b %b", MANCHE, PARTITA);
      //----------------------------------------------------------------------
      SECONDO = 2'b11;
      PRIMO = 2'b10;
      INIZIO_CONTO = 2'b1;
      INIZIO_SETUP = 2'b0;
      $fdisplay(tbf, "simulate %b %b %b %b", INIZIO_SETUP, INIZIO_CONTO, SECONDO, PRIMO);
      #20
      $fdisplay(outf, "Outputs: %b %b", MANCHE, PARTITA);
      //----------------------------------------------------------------------
      SECONDO = 2'b00;
      PRIMO = 2'b10;
      INIZIO_CONTO = 2'b1;
      INIZIO_SETUP = 2'b0;
      $fdisplay(tbf, "simulate %b %b %b %b", INIZIO_SETUP, INIZIO_CONTO, SECONDO, PRIMO);
      #20
      $fdisplay(outf, "Outputs: %b %b", MANCHE, PARTITA);
      //----------------------------------------------------------------------
      SECONDO = 2'b01;
      PRIMO = 2'b11;
      INIZIO_CONTO = 2'b1;
      INIZIO_SETUP = 2'b0;
      $fdisplay(tbf, "simulate %b %b %b %b", INIZIO_SETUP, INIZIO_CONTO, SECONDO, PRIMO);
      #20
      $fdisplay(outf, "Outputs: %b %b", MANCHE, PARTITA);
      //----------------------------------------------------------------------
      SECONDO = 2'b00;
      PRIMO = 2'b10;
      INIZIO_CONTO = 2'b1;
      INIZIO_SETUP = 2'b0;
      $fdisplay(tbf, "simulate %b %b %b %b", INIZIO_SETUP, INIZIO_CONTO, SECONDO, PRIMO);
      #20
      $fdisplay(outf, "Outputs: %b %b", MANCHE, PARTITA);
      //----------------------------------------------------------------------




      SECONDO = 2'b00;
      PRIMO = 2'b01;
      INIZIO_CONTO = 2'b0;
      INIZIO_SETUP = 2'b1;
      $fdisplay(tbf, "simulate %b %b %b %b", INIZIO_SETUP, INIZIO_CONTO, SECONDO, PRIMO);
      #20
      $fdisplay(outf, "Outputs: %b %b", MANCHE, PARTITA);
      //----------------------------------------------------------------------
      SECONDO = 2'b11;
      PRIMO = 2'b10;
      INIZIO_CONTO = 2'b1;
      INIZIO_SETUP = 2'b0;
      $fdisplay(tbf, "simulate %b %b %b %b", INIZIO_SETUP, INIZIO_CONTO, SECONDO, PRIMO);
      #20
      $fdisplay(outf, "Outputs: %b %b", MANCHE, PARTITA);
      //----------------------------------------------------------------------
      SECONDO = 2'b11;
      PRIMO = 2'b10;
      INIZIO_CONTO = 2'b1;
      INIZIO_SETUP = 2'b0;
      $fdisplay(tbf, "simulate %b %b %b %b", INIZIO_SETUP, INIZIO_CONTO, SECONDO, PRIMO);
      #20
      $fdisplay(outf, "Outputs: %b %b", MANCHE, PARTITA);
      //----------------------------------------------------------------------
      SECONDO = 2'b01;
      PRIMO = 2'b00;
      INIZIO_CONTO = 2'b1;
      INIZIO_SETUP = 2'b0;
      $fdisplay(tbf, "simulate %b %b %b %b", INIZIO_SETUP, INIZIO_CONTO, SECONDO, PRIMO);
      #20
      $fdisplay(outf, "Outputs: %b %b", MANCHE, PARTITA);
      //----------------------------------------------------------------------
      SECONDO = 2'b00;
      PRIMO = 2'b10;
      INIZIO_CONTO = 2'b1;
      INIZIO_SETUP = 2'b0;
      $fdisplay(tbf, "simulate %b %b %b %b", INIZIO_SETUP, INIZIO_CONTO, SECONDO, PRIMO);
      #20
      $fdisplay(outf, "Outputs: %b %b", MANCHE, PARTITA);
      //----------------------------------------------------------------------
      SECONDO = 2'b00;
      PRIMO = 2'b10;
      INIZIO_CONTO = 2'b1;
      INIZIO_SETUP = 2'b0;
      $fdisplay(tbf, "simulate %b %b %b %b", INIZIO_SETUP, INIZIO_CONTO, SECONDO, PRIMO);
      #20
      $fdisplay(outf, "Outputs: %b %b", MANCHE, PARTITA);
      //----------------------------------------------------------------------
      SECONDO = 2'b11;
      PRIMO = 2'b10;
      INIZIO_CONTO = 2'b1;
      INIZIO_SETUP = 2'b0;
      $fdisplay(tbf, "simulate %b %b %b %b", INIZIO_SETUP, INIZIO_CONTO, SECONDO, PRIMO);
      #20
      $fdisplay(outf, "Outputs: %b %b", MANCHE, PARTITA);
      //----------------------------------------------------------------------
      $fdisplay(tbf, "quit");
      $fclose(tbf);
      $fclose(outf);
      $finish;
    end
endmodule