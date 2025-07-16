module tick_generator (
    input wire clkin,          // CLOCK_50
    output reg clkout = 0      // pulso de 1 ciclo a cada 100ms
);

    reg [22:0] contador = 0;

    always @(posedge clkin) begin
        if (contador == 5_000_000 - 1) begin
            contador <= 0;
            clkout <= 1;
        end else begin
            contador <= contador + 1;
            clkout <= 0;
        end
    end
endmodule