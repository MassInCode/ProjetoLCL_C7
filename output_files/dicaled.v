module DicaLEDR (
    input clk,
    input start,                     // KEY[0] define senha
    input enter,                     // KEY[3] registra tentativa
    input [17:12] sw_senha,          // SW[17:12]
    input [5:0] sw_tentativa,        // SW[5:0]
    output reg [17:0] LEDR           // LEDR[17:0] agora
);

    reg [5:0] senha_reg = 6'b0;
    reg [5:0] tentativa_reg = 6'b0;
    reg [5:0] comparacao = 6'b0;

    always @(posedge clk) begin
        if (start)
            senha_reg <= sw_senha;
    end

    always @(posedge clk) begin
        if (enter) begin
            tentativa_reg <= sw_tentativa;
            comparacao <= (senha_reg ~^ sw_tentativa);  // bits iguais
        end
    end

    always @(*) begin
        LEDR[5:0]   = comparacao;    // bits 0 a 5 mostram dica
        LEDR[17:6]  = 12'b0;         // bits 6 a 17 sempre apagados
    end

endmodule
