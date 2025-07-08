module temporizador (
    input tick,
    input reset,
    output [6:0] seg_min_dz,
    output [6:0] seg_min_un,
    output [6:0] seg_sec_dz,
    output [6:0] seg_sec_un,
    output [6:0] seg_dec
);

    reg [3:0] dec;
    reg [5:0] sec;
    reg [5:0] min;

    always @(posedge tick or posedge reset) begin
        if (reset) begin
            min <= 3;
            sec <= 0;
            dec <= 0;
        end else begin
            if (dec == 0) begin
                dec <= 9;
                if (sec == 0) begin
                    if (min != 0) begin
                        min <= min - 1;
                        sec <= 59;
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
