module mux_ledr (
    input wire [17:0] leds_vitoria,
    input wire [17:0] leds_derrota,
    input wire [17:0] leds_dica,
    input wire senha_correta,
    input wire derrota,
    output reg [17:0] LEDR
);

    always @(*) begin
        if (senha_correta)
            LEDR = leds_vitoria;
        else if (derrota)
            LEDR = leds_derrota;
        else
            LEDR = leds_dica;
    end

endmodule
