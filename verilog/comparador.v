module comparador_6bits (
    input wire clk,
    input wire enter_btn,             // botão ENTER pressionado
    input wire [5:0] A,               // senha digitada
    input wire [5:0] B,               // senha correta
    output reg senha_correta,
	 output reg senha_errada
);

    reg enter_ff;

    always @(posedge clk) begin
        enter_ff <= enter_btn;

        // Detecta borda de subida do ENTER
        if (~enter_ff && enter_btn) begin
            if (A == B) begin
                senha_correta <= 1;
                senha_errada  <= 0;
            end else begin
                senha_correta <= 0;
                senha_errada  <= 1;
            end
        end else begin
            senha_correta <= 0;
            senha_errada  <= 0;
        end
    end

endmodule
