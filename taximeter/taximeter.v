module taximeter (
    clk,rst,motor,op,mil,dis,timee,sec,cost,seg,codeout,cnt
);
    input clk;
    input rst;
    input motor;
    input [1:0] op;
    output [7:0] mil;
    output [17:0] dis;
    output [6:0] timee;
    output [6:0] sec;
    output [10:0] cost;
    output [7:0] seg;
    output [7:0] codeout;
    output [2:0] cnt;
    // wire clk1000;

    // 还差一个rst，清零
    // taximeter0 i0(clk,clk1000);            // 分频
    taximeter1 i1(clk,rst,motor,mil,dis);              // 计算里程
    taximeter2 i2(clk,rst,motor,timee,sec);    // 计算时间
    taximeter3 i3(mil,timee,cost);         // 计算费用
    taximeter4 i4(clk,op,mil,timee,cost,seg,codeout,cnt);  // 选择显示哪个
endmodule