module taximeter3(
    mil,timee,cost
);
    input [7:0] mil;
    input [6:0] timee;
    output reg [10:0] cost;

    initial
        cost = 11'd8;

    always @(mil,timee)
    begin
        if(mil > 8'd3 && timee > 7'd3)
            cost <= 2*mil + timee - 1;
        else if(timee > 7'd3)
            cost <= 5 + timee;
        else if(mil > 8'd3)
            cost <= 2*mil + 2;
        else
            cost <= 11'd8;
    end
endmodule