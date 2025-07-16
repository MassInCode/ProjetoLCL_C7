module leds_derrota (
    input wire derrota,             // sinal de derrota
    output reg [17:0] led_out       // saída para ser conectada ao LEDR no top-level
);

    always @(*) begin
        if (derrota)
            led_out = 18'b111111111111111111;  // todos acesos
        else
            led_out = 18'b000000000000000000;  // todos apagados
    end

endmodule
