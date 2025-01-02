module taximeter5(
    indec,codeout
);
    input[3:0] indec;
    output reg [7:0] codeout;

    always @(indec) begin
        case(indec)
            4'd0: codeout = 8'b1111_1100;
            4'd1: codeout = 8'b0110_0000;
            4'd2: codeout = 8'b1101_1010;
            4'd3: codeout = 8'b1111_0010;
            4'd4: codeout = 8'b0110_0110;
            4'd5: codeout = 8'b1011_0110;
            4'd6: codeout = 8'b1011_1110;
            4'd7: codeout = 8'b1110_0000;
            4'd8: codeout = 8'b1111_1110;
            4'd9: codeout = 8'b1111_0110;
            default:    codeout = 8'bx;
        endcase
    end
endmodule