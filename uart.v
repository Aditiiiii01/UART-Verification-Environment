// uart
module uart(
    input  wire       clk,
    input  wire       rst_n,
    input  wire       tx_start,      // start transmitting
    input  wire [7:0] tx_data,       // data to transmit
    output reg        tx_serial,     // serial output
    output reg        tx_busy,       // transmitter busy
    input  wire       rx_serial,     // serial input
    output reg [7:0]  rx_data,       // received data
    output reg        rx_ready       // receiver ready flag
);

    parameter CLK_DIV = 868; // for baud rate (adjust as needed)

    // TX variables
    reg [9:0] tx_shift;
    reg [15:0] tx_cnt;
    reg       tx_active;

    // RX variables
    reg [9:0] rx_shift;
    reg [15:0] rx_cnt;
    reg       rx_active;

    // Transmitter
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            tx_serial <= 1'b1;
            tx_busy <= 1'b0;
            tx_active <= 1'b0;
            tx_cnt <= 0;
        end else if(tx_start && !tx_busy) begin
            tx_shift <= {1'b1, tx_data, 1'b0}; // stop bit + data + start bit
            tx_active <= 1'b1;
            tx_busy <= 1'b1;
            tx_cnt <= 0;
        end else if(tx_active) begin
            if(tx_cnt == CLK_DIV-1) begin
                tx_serial <= tx_shift[0];
                tx_shift <= {1'b1, tx_shift[9:1]};
                tx_cnt <= 0;
                if(tx_shift == 10'b1111111111) begin
                    tx_active <= 0;
                    tx_busy <= 0;
                end
            end else begin
                tx_cnt <= tx_cnt + 1;
            end
        end
    end

    // Receiver
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            rx_ready <= 0;
            rx_active <= 0;
            rx_cnt <= 0;
        end else begin
            if(!rx_active && !rx_serial) begin // start bit detected
                rx_active <= 1;
                rx_cnt <= 0;
            end else if(rx_active) begin
                if(rx_cnt == CLK_DIV-1) begin
                    rx_shift <= {rx_serial, rx_shift[9:1]};
                    rx_cnt <= 0;
                    if(rx_shift[0]) begin
                        rx_data <= rx_shift[8:1];
                        rx_ready <= 1;
                        rx_active <= 0;
                    end
                end else begin
                    rx_cnt <= rx_cnt + 1;
                end
            end else begin
                rx_ready <= 0;
            end
        end
    end

endmodule
