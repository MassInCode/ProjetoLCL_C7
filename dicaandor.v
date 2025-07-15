module Dicas(
    input clk,
    input start,                 // KEY[0] - grava a senha
    input enter,                 // KEY[3] - tenta a senha
    input [17:12] sw_senha,      // SW[17:12] - senha
    input [5:0] sw_tentativa,    // SW[5:0] - tentativa
    output reg [6:0] HEX6,       // Display OR
    output reg [6:0] HEX7        // Display AND
);

    reg [5:0] senha_reg = 0;
    reg [5:0] tentativa_reg = 0;

    reg [5:0] and_result = 0;
    reg [5:0] or_result  = 0;

    // Grava a senha uma vez
    always @(posedge clk) begin
        if (start)
            senha_reg <= sw_senha;
    end

    // Quando ENTER é pressionado, armazena tentativa e calcula dicas
    always @(posedge clk) begin
        if (enter) begin
            tentativa_reg <= sw_tentativa;
            and_result <= senha_reg & sw_tentativa;
            or_result  <= senha_reg | sw_tentativa;
        end
    end

    // Atualiza os displays de forma contínua com base no valor armazenado
    always @(*) begin
        // HEX7 - AND
        HEX7 = ~{
            1'b0,             // centro desligado
            and_result[5],    // haste 5
            and_result[4],    // haste 4
            and_result[3],    // haste 3
            and_result[2],    // haste 2
            and_result[1],    // haste 1
            and_result[0]     // haste 0
        };

        // HEX6 - OR
        HEX6 = ~{
            1'b0,
            or_result[5],
            or_result[4],
            or_result[3],
            or_result[2],
            or_result[1],
            or_result[0]
        };
    end

endmodule