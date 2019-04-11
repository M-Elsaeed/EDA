-- library ieee;
-- use ieee.bit_1164.all;
entity dac_tb is
end dac_tb;

architecture dac_tb_behav of dac_tb is
    component  dac is
        port
        (
            reset    : in bit;
            day_time : in bit;
            code     : in bit_vector(3 downto 0);
            door     : out bit;
            alarm    : out bit;
            clk      : in bit;
            vdd      : in bit;
            vss      : in bit
        );
    end component dac;


    signal reset : bit;
    signal day_time : bit;
    signal code : bit_vector(3 downto 0);
    signal door : bit;
    signal alarm : bit;
    signal clk : bit;
    signal vdd : bit := '1';
    signal vss : bit := '0';
    
    for all : dac use entity work.dac(dac_behav);

    constant clk_period : time := 20 ns;
    constant a          : bit_vector(3 downto 0) := "1010";
	constant b          : bit_vector(3 downto 0) := "1011";
	constant o          : bit_vector(3 downto 0) := "1101";
begin
    
    dut : dac port map(reset, day_time, code, door, alarm, clk, vdd, vss);
    process begin
        wait for clk_period;
        reset<='1';
        wait for clk_period;
        assert door='0' and alarm = '0'
        report "#1 reset isn't working"
        severity error;

        reset<='0';
        code<=x"5";
        wait for clk_period;
        assert door='0' and alarm = '1'
        report "#2 error isn't working"
        severity error;

        
        wait for clk_period;
        assert door='0' and alarm = '0'
        report "#3 State that allows resetting of alarm isn't working"
        severity error;

        reset<='0';
        day_time<='0';
        code <= x"2";
        wait for clk_period;
        assert door='0' and alarm = '0'
        report "#4 Door = 1 or alarm = 1 when only 2 is entered."
        severity error;

        reset<='0';
        day_time<='0';
        code <= x"6";
        wait for clk_period;
        assert door='0' and alarm = '0'
        report "#5 Door = 6 or alarm = 6 when only 2 is entered."
        severity error;

        reset<='0';
        day_time<='1';
        code <= a;
        wait for clk_period;
        assert door='0' and alarm = '0'
        report "#6 Door = 1 or alarm = 1 when day_time is changed to 1 during password entry."
        severity error;

        reset<='0';
        day_time<='0';
        code <= x"0";
        wait for clk_period;
        assert door='0' and alarm = '0'
        report "#7 reset isn't working"
        severity error;

        reset<='0';
        day_time<='0';
        code <= x"5";
        wait for clk_period;
        assert door='1' and alarm = '0'
        report "#8 Door doesn't open if code is entered correctly"
        severity error;

        wait for clk_period;
        assert door='0' and alarm = '0'
        report "#9 State that allows resetting of alarm isn't working"
        severity error;

        reset<='0';
        day_time<='0';
        code <= x"2";
        wait for clk_period;
        assert door='0' and alarm = '0'
        report "#9 Door = 1 or alarm = 1 when only 2 is entered."
        severity error;


        reset<='0';
        day_time<='1';
        code <= o;
        wait for clk_period;
        assert door='1' and alarm = '0'
        report "#10 Door != 1 or alarm != 0 when day_time = 1 and code is O ."
        severity error;



        wait;
    end process;

    process begin
        clk <='1','0' after (clk_period/2);
        wait for clk_period;
    end process;
    
end architecture dac_tb_behav;


