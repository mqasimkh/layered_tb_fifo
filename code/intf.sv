interface intf #(DATA_WIDTH = 8)(input clk);
    logic rst_n;
    logic wr_en, rd_en;
    logic [DATA_WIDTH-1:0] data_in;
    logic [DATA_WIDTH-1:0] data_out;
    logic full, empty;
endinterface