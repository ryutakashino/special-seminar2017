reg [3:0] LED_Display_Counter;
reg [31:0] LED_Interval_Counter;
reg slv_reg_wren_1d;

// slv_reg_wren_1d generate
always @(posedge S_AXI_ACLK) begin
    if (~S_AXI_ARESETN)
        slv_reg_wren_1d <= 1'b0;
    else
        slv_reg_wren_1d <= slv_reg_wren;
end

// LED_Interval_Counter
always @(posedge S_AXI_ACLK) begin :proc_LED_Interval_Counter
    if (~S_AXI_ARESETN) begin
        LED_Interval_Counter <= 32'd0;
    end else begin
        if (slv_reg0[0]) begin //Enable
            if (LED_Interval_Counter == 32'd0)
                LED_Interval_Counter<= slv_reg3;
            else
                LED_Interval_Counter<= LED_Interval_Counter - 32'd1;
        end else
            LED_Interval_Counter<= slv_reg3;
    end
end

// Contents
// LED_Display_Counter
always @(posedge S_AXI_ACLK) begin : proc_LED_Display_Counter
    if (~S_AXI_ARESETN) begin
        LED_Display_Counter <= 4'd0;
    end else begin
        if (slv_reg_wren_1d && axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]==2'h1) //Counter Load
            LED_Display_Counter <= slv_reg0[3:0]; //Error, slv_reg1[3:0]
        else if (slv_reg0[0]) begin //Enable
        if (LED_Interval_Counter == 32'd0)
            LED_Display_Counter <= LED_Display_Counter + 4'd1;
        end
    end
end
assign LED4bit = LED_Display_Counter;


