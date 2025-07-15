module DisplayTentativa (
    input clk,                  // clock do sistema
    input enter,                // botão ENTER (KEY[3])
    input [5:0] sw_tentativa,   // chaves SW[5:0]
    output reg [6:0] HEX4       // saída para o display HEX4
);

    reg [5:0] tentativa_atual;

    always @(posedge clk) begin
        if (enter) begin
            tentativa_atual <= sw_tentativa;
        end
    end

    // Atribuir os bits da tentativa diretamente aos segmentos do display
    always @(*) begin
        HEX4[0] = ~tentativa_atual[0]; // segmento 0
        HEX4[1] = ~tentativa_atual[1]; // segmento 1
        HEX4[2] = ~tentativa_atual[2]; // segmento 2
        HEX4[3] = ~tentativa_atual[3]; // segmento 3
        HEX4[4] = ~tentativa_atual[4]; // segmento 4
        HEX4[5] = ~tentativa_atual[5]; // segmento 5
        HEX4[6] = ~1'b0;               // segmento 6 desligado
    end

endmodule
