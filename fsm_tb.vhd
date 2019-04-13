library ieee;
use ieee.std_logic_1164.all;
entity dac_tb is
end dac_tb;

architecture dac_tb_behav of dac_tb is
	component dac is
		port (
			reset    : in std_logic;
			day_time : in std_logic;
			code     : in std_logic_vector(3 downto 0);
			door     : out std_logic;
			alarm    : out std_logic;
			clk      : in std_logic;
			vdd      : in std_logic;
			vss      : in std_logic
		);
	end component dac;
	signal reset        : std_logic;
	signal day_time     : std_logic;
	signal code         : std_logic_vector(3 downto 0);
	signal door         : std_logic;
	signal alarm        : std_logic;
	signal clk          : std_logic;
	signal vdd          : std_logic := '1';
	signal vss          : std_logic := '0';

	for all             : dac use entity work.dac(dac_behav);

	constant clk_period : time                         := 20 ns;
	constant a          : std_logic_vector(3 downto 0) := "1010";
	constant b          : std_logic_vector(3 downto 0) := "1011";
	constant o          : std_logic_vector(3 downto 0) := "1101";
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
		-- wait for clk_period;
		-- assert door = '0' and alarm = '0'
		-- report "Waiting for a clock cycle, should NOT both door nor alarm to zero"
		-- 	severity error;

		-- 13
		reset    <= '0';
		day_time <= '1';
		code     <= a;
		wait for clk_period;
		assert door = '0' and alarm = '0'
		report "Entering 2, 6, A neither opens the door, nor triggers the alarm, switching daytime to 1 and not pressing 'O' , will not open the door nor trigger the alarm"
			severity error;

		-- 14
		reset    <= '0';
		day_time <= '0';
		code     <= x"0";
		wait for clk_period;
		assert door = '0' and alarm = '0'
		report "Entering 2, 6, A, 0 neither opens the door, nor triggers the alarm"
			severity error;

		-- 15
		reset    <= '0';
		day_time <= '0';
		code     <= x"5";
		wait for clk_period;
		assert door = '1' and alarm = '0'
		report "Entering 2, 6, A, 0, 5 opens the door, but doesn't trigger the alarm"
			severity error;

		-- 16
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