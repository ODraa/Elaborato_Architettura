module MorraCinese (

    input wire clk,

    input wire [1:0] PRIMO;
    input wire [1:0] SECONDO,
    input wire [0:0] INIZIA = 1'b0,

    output wire [1:0] MANCHE,
    output wire [1:0] PARTITA,

    output reg winPrimo [4:0],
    output reg winSecondo [4:0]
);

always @(posedge clock) begin
    case ({PRIMO, SECONDO})

        4'b00 00:

        4'b00 01:

        4'b00 10:

        4'b00 11:

        /////////////////////////////////////////

        4'b01 00:

        4'b01 01: MANCHE = 2'b11;

        4'b01 10: MANCHE = 2'b10;

        4'b01 11:

        /////////////////////////////////////////

        4'b10 00:

        4'b10 01:

        4'b10 10: MANCHE = 2'b11;

        4'b10 11:

        /////////////////////////////////////////

        4'b11 00:

        4'b11 01:

        4'b11 10:

        4'b11 11: MANCHE = 2'b11;

        /////////////////////////////////////////

        default: 
    endcase
end

endmodule