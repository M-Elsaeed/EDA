-- 0 to 9 binary encoded
-- A => 1010
-- B => 1011
-- O => 1101
library ieee;
use ieee.std_logic_1164.all;
entity dac is
	port
	(
		reset    : in std_logic;
		day_time : in std_logic;
		code     : in std_logic_vector(3 downto 0);
		door     : out std_logic;
		alarm    : out std_logic;
		clk      : in std_logic;
		vdd      : in std_logic;
		vss      : in std_logic;
	);
end dac;
architecture dac_behav of dac is
	type state is (start, rec_2, rec_6, rec_a, rec_0, rec_5);
	signal current_state, next_state               : state;
	constant a := "1010", b := "1011", o := "1101" : std_logic_vector;
begin
	process (clk)
	begin
		if rising_edge (clk) then
			current_state <= next_state;
		end if;
	end process;
	process (current_state, reset, day_time, code)
	begin
		if reset = '1'then
			next_state <= start;
		elsif
			case current_state is
				when => start
					if d = '1' and code = o then
						door       <= '0';
						alarm      <= '0';
						next_state <= rec_5;
					elsif code = x"2"
						door       <= '0';
						alarm      <= '0';
						next_state <= rec_2;
					else
						door       <= '0';
						alarm      <= '1';
						next_state <= start;
					end if;
				when => rec_2
					if d = '1' and code = o then
						door       <= '0';
						alarm      <= '0';
						next_state <= rec_5;
					elsif code = x"6"
						door       <= '0';
						alarm      <= '0';
						next_state <= rec_6;
					else
						door       <= '0';
						alarm      <= '1';
						next_state <= start;
					end if;
				when => rec_6
					if d = '1' and code = o then
						door       <= '0';
						alarm      <= '0';
						next_state <= rec_5;
					elsif code = a
						door       <= '0';
						alarm      <= '0';
						next_state <= rec_a;
					else
						door       <= '0';
						alarm      <= '1';
						next_state <= start;
					end if;
				when => rec_a
					if d = '1' and code = o then
						door       <= '0';
						alarm      <= '0';
						next_state <= rec_5;
					elsif code = x"0"
						door       <= '0';
						alarm      <= '0';
						next_state <= rec_0;
					else
						door       <= '0';
						alarm      <= '1';
						next_state <= start;
					end if;
				when => rec_0
					if d = '1' and code = o then
						door       <= '0';
						alarm      <= '0';
						next_state <= rec_5;
					elsif code = x"5"
						door       <= '0';
						alarm      <= '0';
						next_state <= rec_5;
					else
						door       <= '0';
						alarm      <= '1';
						next_state <= start;
					end if;
				when => rec_5
					door <= '1';
					alarm = '0';
					next_state <= start;
				when => others
					assert false
					report 'invalid state'
						severity failure;
			end case;
		end if;
	end process;
end dac_behav;