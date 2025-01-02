// module taximeter0(
//     clk,clk1000
// );
//     input clk;
//     output reg clk1000;
//     reg [15:0] cnt;

//     initial
//     begin
//         cnt = 0;
//         clk1000 = clk;
//     end
    
//     always@(posedge clk)
//     begin
//         if(cnt < 16'd25000-1)
//             cnt <= cnt+1;
//         else
//         begin
//             cnt <= 0;
//             clk1000 <= ~clk1000;
//         end
//     end
// endmodule

module taximeter0 (
    clk,clk1000
);
    input clk;
    output clk1000;

    assign clk1000 = clk;
endmodule