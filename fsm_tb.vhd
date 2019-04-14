entity dac_tb is
end dac_tb;

architecture dac_tb_behav of dac_tb is
	component dac is
		port (
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
	signal reset        : bit;
	signal day_time     : bit;
	signal code         : bit_vector(3 downto 0);
	signal door         : bit;
	signal alarm        : bit;
	signal clk          : bit;
	signal vdd          : bit := '1';
	signal vss          : bit := '0';

	for all             : dac use entity work.dac(dac_behav);

	constant clk_period : time                         := 20 ns;
	constant a          : bit_vector(3 downto 0) := "1010";
	constant b          : bit_vector(3 downto 0) := "1011";
	constant o          : bit_vector(3 downto 0) := "1101";
begin

	dut : dac port map(reset, day_time, code, door, alarm, clk, vdd, vss);
	process begin

		wait for clk_period;

		-- 1
		reset <= '1';
		-- day_time<='0';
		-- code <= x"";
		wait for clk_period;
		assert door = '0' and alarm = '0'
		report "Setting reset = 1 should reset the circuit to its initial state"
			severity error;

		-- 2
		reset    <= '0';
		day_time <= '0';
		code     <= x"5";
		wait for clk_period;
		assert door = '0' and alarm = '1'
		report "Entering a wrong code, should trigger the alarm"
			severity error;

		-- 3
		wait for clk_period;
		assert door = '0' and alarm = '0'
		report "Waiting for a clock cycle, should reset both door and alarm, to zero"
			severity error;

		-- 4
		reset    <= '0';
		day_time <= '1';
		code     <= x"5";
		wait for clk_period;
		assert door = '0' and alarm = '1'
		report "Entering a wrong code, even during daytime should trigger the alarm"
			severity error;

		-- 5
		wait for clk_period;
		assert door = '0' and alarm = '0'
		report "Waiting for a clock cycle, should reset both door and alarm, to zero"
			severity error;

		-- 6
		reset    <= '0';
		day_time <= '0';
		code     <= o;
		wait for clk_period;
		assert door = '0' and alarm = '1'
		report "Entering 'O' during night time should trigger the alarm"
			severity error;

		-- 7
		wait for clk_period;
		assert door = '0' and alarm = '0'
		report "Waiting for a clock cycle, should reset both door and alarm, to zero"
			severity error;

		-- 8
		reset    <= '0';
		day_time <= '1';
		code     <= o;
		wait for clk_period;
		assert door = '1' and alarm = '0'
		report "Entering 'O' during daytime should open the door"
			severity error;

		-- 9
		wait for clk_period;
		assert door = '0' and alarm = '0'
		report "Waiting for a clock cycle, should reset both door and alarm, to zero"
			severity error;

		-- 10
		reset    <= '0';
		day_time <= '0';
		code     <= x"2";
		wait for clk_period;
		assert door = '0' and alarm = '0'
		report "Entering 2 neither opens the door, nor triggers the alarm"
			severity error;

		-- 11
		reset    <= '0';
		day_time <= '0';
		code     <= x"6";
		wait for clk_period;
		assert door = '0' and alarm = '0'
		report "Entering 2, 6 neither opens the door, nor triggers the alarm"
			severity error;

		-- 12
		reset    <= '0';
		day_time <= '1';
		code     <= a;
		wait for clk_period;
		assert door = '0' and alarm = '0'
		report "Entering 2, 6, A neither opens the door, nor triggers the alarm, switching daytime to 1 and not pressing 'O' , will not open the door nor trigger the alarm"
			severity error;

		-- 13
		reset    <= '0';
		day_time <= '0';
		code     <= x"0";
		wait for clk_period;
		assert door = '0' and alarm = '0'
		report "Entering 2, 6, A, 0 neither opens the door, nor triggers the alarm"
			severity error;

		-- 14
		reset    <= '0';
		day_time <= '0';
		code     <= x"5";
		wait for clk_period;
		assert door = '1' and alarm = '0'
		report "Entering 2, 6, A, 0, 5 opens the door, but doesn't trigger the alarm"
			severity error;

		-- 15
		wait for clk_period;
		assert door = '0' and alarm = '0'
		report "Waiting for a clock cycle, should reset both door and alarm, to zero"
			severity error;
		wait;
	end process;

	process begin
		clk <= '1', '0' after (clk_period/2);
		wait for clk_period;
	end process;

end architecture dac_tb_behav;