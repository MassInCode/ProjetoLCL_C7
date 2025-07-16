module controle_senha (
    input wire clk,
    input wire rst,
    input wire start_btn,
    input wire enter_btn,
    input wire [5:0] ENTRADAS,
    output reg [5:0] SENHA,
    output reg start_timer
);

    reg senha_gravada = 0;
    reg bloqueado = 0;

    reg start_btn_old = 0;
    reg enter_btn_old = 0;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            SENHA <= 6'b000000;
            senha_gravada <= 0;
            bloqueado <= 0;
            start_timer <= 0;
            start_btn_old <= 0;
            enter_btn_old <= 0;
        end else begin
            // Detecta bordas de subida
            start_btn_old <= start_btn;
            enter_btn_old <= enter_btn;

            // START: grava senha e desbloqueia ENTER
            if (start_btn && !start_btn_old) begin
                SENHA <= ENTRADAS;
                senha_gravada <= 1;
                bloqueado <= 0;          // ← libera o ENTER
            end

            // ENTER: inicia temporizador se liberado
            if (enter_btn && !enter_btn_old && senha_gravada && !bloqueado) begin
                start_timer <= 1;
                bloqueado <= 1;          // ← trava novamente após uso
            end else begin
                start_timer <= 0;
            end
        end
    end
endmodule
