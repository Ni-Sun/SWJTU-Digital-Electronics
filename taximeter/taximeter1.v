module taximeter1 (
    clk,rst,motor,mil,dis
);
    input clk;
    input rst;
    input motor;
    output [7:0] mil;
    output reg [17:0] dis;
    parameter per = 2;

    wire pedge;
    wire nedge;
    wire change;
    reg [1:0] d;
    
    initial
    begin
        dis = 0;
        d = 2'b00;
    end

    always@(posedge clk)
    begin
        d <= {d[0],motor};
    end
    assign pedge = ~d[1] & d[0];
    assign nedge = d[1] & ~d[0];
    assign change = pedge | nedge;

    always@(posedge clk, negedge rst)
    begin
        if(!rst)
            dis <= 0;
        else
            if(change)
                if(dis <= 18'd99_997)
                    dis <= dis + per;
        
    end
    assign mil = dis/1000;
endmodule