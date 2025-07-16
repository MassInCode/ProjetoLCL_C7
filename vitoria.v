module leds_vitoria (
    input wire clk,
    input wire senha_correta,       // sinal gerado pelo comparador
    output reg [17:0] LEDR
);

    reg [23:0] contador = 0;
    reg pisca = 0;
    reg ativo = 0;                  // trava o estado após a vitória

    // Gera pulso lento (~0.5s de período com clock 50MHz)
    always @(posedge clk) begin
        if (senha_correta) begin
            ativo <= 1;             // trava o estado como "vitória"
        end

        if (ativo) begin
            contador <= contador + 1;

            if (contador == 24'd12_500_000) begin
                contador <= 0;
                pisca <= ~pisca;
            end

            LEDR <= (pisca) ? 18'b111111111111111111 : 18'b000000000000000000;
        end else begin
            LEDR <= 18'b0;
        end
    end

endmodule
