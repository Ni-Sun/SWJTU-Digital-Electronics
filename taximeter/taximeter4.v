module taximeter4(
    clk,op,mil,timee,cost,seg,codeout,cnt
);
    input clk;
    input [1:0] op;
    input [7:0] mil;    // 0~99
    input [6:0] timee;  // 0~59
    input [10:0] cost;  // 0~999.0
    output reg [7:0] seg;
    output reg [7:0] codeout;
    output reg [2:0] cnt;

    wire [7:0] copy_seg[2:0];
    wire [7:0] copy_codeout[2:0];

    initial
    begin
        cnt = 0;
        seg = 8'b0000_0000;
        codeout = 8'b0000_0000;
    end

    always @(posedge clk)
    begin
        if(cnt < 3'd3)
            cnt <= cnt+1;
        else
            cnt <= 0;
    end

    taximeter4_0 i4_0(clk,cnt,mil,  copy_seg[0],  copy_codeout[0]);
    taximeter4_1 i4_1(clk,cnt,timee,copy_seg[1],  copy_codeout[1]);
    taximeter4_2 i4_2(clk,cnt,cost, copy_seg[2],  copy_codeout[2]);

    always @(posedge clk)
    begin
        case (op)
            2'b00:
            begin
                seg <= copy_seg[0];
                codeout <= copy_codeout[0];
            end
            2'b01:
            begin
                seg <= copy_seg[1];
                codeout <= copy_codeout[1];
            end
            2'b10:
            begin
                seg <= copy_seg[2];
                codeout <= copy_codeout[2];
            end
            default:
            begin
                seg <= seg;
                codeout <= codeout;
            end
        endcase
    end
endmodule

// mil 4位 0~99
module taximeter4_0 (
    clk,cnt,mil,seg,codeout
);
    input [2:0] cnt;
    input clk;
    input [7:0] mil;
    output reg [7:0] seg;
    output reg [7:0] codeout;
    wire [3:0] dig [3:0];
    wire [7:0] copy_codeout [3:0];

    assign dig[0] = mil%10;
    assign dig[1] = mil/10;
    assign dig[2] = 0;
    assign dig[3] = 0;

    taximeter5 i4_0_1(dig[0],copy_codeout[0]);
    taximeter5 i4_0_2(dig[1],copy_codeout[1]);
    taximeter5 i4_0_3(dig[2],copy_codeout[2]);
    taximeter5 i4_0_4(dig[3],copy_codeout[3]);

    always @(clk)
    begin
        case (cnt)
            3'd0:
            begin
                seg <= 8'b0000_0001;
                codeout <= copy_codeout[0];
            end
            3'd1:
            begin
                seg <= 8'b0000_0010;
                codeout <= copy_codeout[1];
            end
            3'd2:
            begin
                seg <= 8'b0000_0100;
                codeout <= copy_codeout[2];
            end
            3'd3:
            begin
                seg <= 8'b0000_1000;
                codeout <= copy_codeout[3];
            end
            default:
            begin
                seg <= 8'bx;
                codeout <= 8'bx;
            end
        endcase
    end
endmodule

// timee 2位
module taximeter4_1 (
    clk,cnt,timee,seg,codeout
);
    input [2:0] cnt;
    input clk;
    input [6:0] timee;
    output reg [7:0] seg;
    output reg [7:0] codeout;
    wire [3:0] dig [1:0];
    wire [7:0] copy_codeout[1:0];

    assign dig[0] = timee%10;
    assign dig[1] = timee/10;

    taximeter5 i4_1_1(dig[0],copy_codeout[0]);
    taximeter5 i4_1_2(dig[1],copy_codeout[1]);

    always@(clk)
    begin
        if(cnt == 3'd0 || cnt == 3'd2)
        begin
            seg <= 8'b0000_0001;
            codeout <= copy_codeout[0];
        end
        else if(cnt == 3'd1 || cnt == 3'd3)
        begin
            seg <= 8'b0000_0010;
            codeout <= copy_codeout[1];
        end
    end
endmodule

// cost 4位
module taximeter4_2 (
    clk,cnt,cost,seg,codeout
);
    input [2:0] cnt;
    input clk;
    input [10:0] cost;
    output reg [7:0] seg;
    output reg [7:0] codeout;
    wire [3:0] dig [3:0];
    wire [7:0] copy_codeout[3:0];
    
    assign dig[0] = 0;              // 小数位
    assign dig[1] = cost%10;        // 个位
    assign dig[2] = (cost%100)/10;  // 十位
    assign dig[3] = cost/100;       // 百位

    taximeter5 i4_2_1(dig[0],copy_codeout[0]);
    taximeter5 i4_2_2(dig[1],copy_codeout[1]);
    taximeter5 i4_2_3(dig[2],copy_codeout[2]);
    taximeter5 i4_2_4(dig[3],copy_codeout[3]);

    always @(clk)
    begin
        case (cnt)
            3'd0:   // 小数位
            begin
                seg <= 8'b0000_0001;
                codeout <= copy_codeout[0];
            end
            3'd1:   // 个位
            begin
                seg <= 8'b0000_0010;
                codeout <= copy_codeout[1];
                codeout[0] <= 1;             // 显示小数点
            end
            3'd2:   // 十位
            begin
                seg <= 8'b0000_0100;
                codeout <= copy_codeout[2];
            end
            3'd3:   // 百位
            begin
                seg <= 8'b0000_1000;
                codeout <= copy_codeout[3];
            end
            default:
            begin
                seg <= 8'bx;
                codeout <= 8'bx;
            end
        endcase
    end
endmodule
