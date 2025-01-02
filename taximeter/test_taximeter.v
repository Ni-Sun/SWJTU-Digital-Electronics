`timescale 1ms/1ms
module tset_taximeter();
reg clk;
reg rst;
reg motor;
reg [1:0] op;
// wires
wire [7:0]  codeout;
wire [10:0]  cost;
wire [7:0]  mil;
wire [17:0] dis;
wire [7:0]  seg;
wire [6:0]  timee;
wire [6:0] sec;
wire [2:0] cnt;

taximeter i1 (
	.clk(clk),
    .rst(rst),
	.codeout(codeout),
	.cost(cost),
	.mil(mil),
    .dis(dis),
	.motor(motor),
	.op(op),
	.seg(seg),
	.timee(timee),
    .sec(sec),
    .cnt(cnt)
);
reg [23:0] cnt1;
reg [26:0] cnt2;
// reg [8:0] cnt3;
// reg [6:0] sec;
reg [5:0] num;

initial
begin
    clk = 0;
    rst = 1;
    motor = 0;
    op = 0;
    cnt1 = 0;
    cnt2 = 0;
    // cnt3 = 0;
    // sec = 0;
    num = 6'd24;    // 60km/h
    #120000      // 2min
    num = 6'd20; // 72km/h
    #3120000
    rst = 0;
    #1000000
    rst = 1;
end


always # 5
begin
    clk <= ~clk;
    if(cnt1 < num-1)   // 60km/h
        cnt1 <= cnt1+1;
    else
    begin
        cnt1 <= 0;
        motor <= ~motor;
    end
    if(cnt2 < 27'd2000-1)   // 10s
        cnt2 <= cnt2+1;
    else
    begin
        cnt2 <= 0;
        if(op < 2)
            op <= op+1;
        else
            op <= 0;
    end
    // if(cnt3 < 9'd200 - 1)
    //     cnt3 <= cnt3+1;
    // else
    // begin
    //     cnt3 <= 0;
    //     if(sec < 7'd59)
    //         sec <= sec+1;
    //     else
    //         sec <= 0;
    // end
end
endmodule

