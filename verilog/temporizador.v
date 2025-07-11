module temporizador (
    input wire tick,              // clock lento (ex: 100ms)
    input wire start,             // pulso de start (vindo de start_timer)
    output wire [6:0] seg_min_dz,
    output wire [6:0] seg_min_un,
    output wire [6:0] seg_sec_dz,
    output wire [6:0] seg_sec_un,
    output wire [6:0] seg_dec
);

    reg [3:0] dec;
    reg [5:0] sec;
    reg [5:0] min;

    reg ativo = 0;
    reg start_ff = 0;
	 
    always @(posedge tick) begin
        start_ff <= start;

        if (~start_ff && start) begin
            min <= 3;
            sec <= 0;
            dec <= 0;
            ativo <= 1;
        end else if (ativo) begin
            if (dec == 0) begin
                dec <= 9;
                if (sec == 0) begin
                    if (min != 0) begin
                        min <= min - 1;
                        sec <= 59;
                    end else begin
                        // tempo chegou a 00:00:00
                        ativo <= 0;
                        dec <= 0;
                        sec <= 0;
                        min <= 0;
                    end
                end else begin
                    sec <= sec - 1;
                end
            end else begin
                dec <= dec - 1;
            end
        end
    end
	 
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
