module taximeter2(
    clk,rst,motor,timee,sec
);
    input clk;
    input rst;
    input motor;
    output reg [6:0] timee;
    output reg [6:0] sec;
    reg [16:0] cnt;
    reg [10:0] cnt2;
    wire pegde;
    wire nedge;
    wire change;
    reg [1:0] d;
    wire flag;
    parameter max_time = 17'd60000;  // 1min (1KHz)

    initial
    begin
        sec = 0;
        cnt = 0;
        cnt2 = 0;
        d = 2'b00;
        timee = 0;
    end

    always@(posedge clk)
    begin
        d <= {d[0],motor};
    end
    assign pegde = ~d[1] & d[0];
    assign nedge = d[1] & ~d[0];
    assign change = pegde | nedge;

    always@(posedge clk)
    begin
        if(change || !rst)
            cnt <= 0;
        else if(cnt <= max_time)
            cnt <= cnt+1;
    end
    assign flag = (cnt <= max_time);

    always @(posedge clk)
    begin
        if(!rst)
        begin
            cnt2 <= 0;
            sec <= 0;
            timee <= 0;
        end
        else
        begin
            if(flag)
            begin
                if(cnt2 < 11'd100 - 1)  // 1s
                    cnt2 <= cnt2+1;
                else
                begin
                    cnt2 <= 0;
                    if(sec < 7'd59)
                        sec <= sec+1;
                    else
                    begin
                        sec <= 0;
                        if(timee < 7'd59)
                            timee <= timee+1;
                    end
                end
            end
        end
    end
endmodule