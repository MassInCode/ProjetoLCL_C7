module temporizador (
    input wire tick,              // clock lento
    input wire start,             // pulso de início
    input wire pare,              // trava o tempo se ganhar
    output wire [6:0] seg_min_dz,
    output wire [6:0] seg_min_un,
    output wire [6:0] seg_sec_dz,
    output wire [6:0] seg_sec_un,
    output wire [6:0] seg_dec
);

    // Registradores do tempo
    reg [3:0] dec = 0;
    reg [5:0] sec = 0;
    reg [5:0] min = 0;

    reg ativo = 0;
    reg congelado = 0;

    // Sincronizadores para detectar borda de start (no domínio do tick)
    reg start_sync_0 = 0;
    reg start_sync_1 = 0;

    wire start_edge;

    assign start_edge = (start_sync_0 & ~start_sync_1);  // borda de subida

    always @(posedge tick) begin
        // Sincronização do start
        start_sync_0 <= start;
        start_sync_1 <= start_sync_0;

        // Se detectou borda de subida do start → reinicia
        if (start_edge) begin
            min <= 3;
            sec <= 0;
            dec <= 0;
            ativo <= 1;
            congelado <= 0;
        end
        else if (ativo && !congelado) begin
            if (dec == 0) begin
                dec <= 9;
                if (sec == 0) begin
                    if (min != 0) begin
                        min <= min - 1;
                        sec <= 59;
                    end else begin
                        ativo <= 0;
                        min <= 0;
                        sec <= 0;
                        dec <= 0;
                    end
                end else begin
                    sec <= sec - 1;
                end
            end else begin
                dec <= dec - 1;
            end
        end

        // Trava permanente caso acerte
        if (pare) congelado <= 1;
    end

    // Conversão para displays
    wire [3:0] min_dz = min / 10;
    wire [3:0] min_un = min % 10;
    wire [3:0] sec_dz = sec / 10;
    wire [3:0] sec_un = sec % 10;

    hex7seg h0 (.in(dec),     .out(seg_dec));
    hex7seg h1 (.in(sec_un),  .out(seg_sec_un));
    hex7seg h2 (.in(sec_dz),  .out(seg_sec_dz));
    hex7seg h3 (.in(min_un),  .out(seg_min_un));
    hex7seg h4 (.in(min_dz),  .out(seg_min_dz));

endmodule
