entity all_tb is
    end all_tb;
    
    architecture all_tb_behav of all_tb is
        component dac is
            port (
                reset    : in      bit;
                day_time : in      bit;
                code     : in      bit_vector(3 downto 0);
                door     : out     bit;
                alarm    : out     bit;
                clk      : in      bit;
                vdd      : in      bit;
                vss      : in      bit
            );
        end component dac;
        component dac_loon is
            port (
                reset    : in      bit;
                day_time : in      bit;
                code     : in      bit_vector(3 downto 0);
                door     : out     bit;
                alarm    : out     bit;
                clk      : in      bit;
                vdd      : in      bit;
                vss      : in      bit
            );
        end component dac_loon;
        component dac_scan is
            port (
                reset    : in      bit;
                day_time : in      bit;
                code     : in      bit_vector(3 downto 0);
                door     : out     bit;
                alarm    : out     bit;
                clk      : in      bit;
                vdd      : in      bit;
                vss      : in      bit;
                scanin   : in      bit;
                test     : in      bit;
                scanout  : out     bit
            );
        end component dac_scan;


        signal reset        : bit;
        signal day_time     : bit;
        signal code         : bit_vector(3 downto 0);
        signal door         : bit;
        signal alarm        : bit;
        signal door_loon    : bit;
        signal alarm_loon   : bit;
        signal door_scan    : bit;
        signal alarm_scan   : bit;
        signal clk          : bit;
        signal vdd          : bit := '1';
        signal vss          : bit := '0';
        signal scanin       : bit := '0';
        signal test         : bit := '0';
        signal scanout      : bit := '0';
    
        for all             : dac      use entity work.dac(dac_behav);
        for all             : dac_loon use entity work.sdetm_b_l(structural);
        for all             : dac_scan use entity work.sdetm_b_l_scan(structural);

        constant clk_period : time                   :=  20 ns;
        constant a          : bit_vector(3 downto 0) := "1010";
        constant b          : bit_vector(3 downto 0) := "1011";
        constant o          : bit_vector(3 downto 0) := "1101";
        constant scantest   : bit_vector             := "01000101011010000110000101100010";
    begin
    
        dut      : dac      port map(reset, day_time, code, door, alarm, clk, vdd, vss);
        dut_loon : dac_loon port map(reset, day_time, code, door_loon, alarm_loon, clk, vdd, vss);
        dut_scan : dac_scan port map(reset, day_time, code, door_scan, alarm_scan, clk, vdd, vss, scanin, test, scanout);

        process begin

            test <= '1';
            for i In 0 to scantest'length-1 loop
                scanin <= scantest(i);
                wait for clk_period;
                if i>=2 then
                    Assert scanout=scantest(i-2)
                    Report "scanout does not follow scan in"
                    Severity error;
                end if;
            end loop;
            
            test<= '0';
            wait for clk_period;
    
            -- 1
            reset <= '1';
            -- day_time<='0';
            -- code <= x"";
            wait for clk_period;
            assert door = door_loon and alarm = alarm_loon
            report "door_loon != door OR alarm_loon != alarm. Setting reset = 1 should reset the circuit to its initial state"
                severity failure;
    
            assert door = door_scan and alarm = alarm_scan
            report "door_scan != door OR alarm_scan != alarm. Setting reset = 1 should reset the circuit to its initial state"
                severity failure;

            -- 2
            reset    <= '0';
            day_time <= '0';
            code     <= x"5";
            wait for clk_period;
            assert door = door_loon and alarm = alarm_loon
            report "door_loon != door OR alarm_loon != alarm. Entering a wrong code, should trigger the alarm"
                severity failure;
    
            assert door = door_scan and alarm = alarm_scan
            report "door_scan != door OR alarm_scan != alarm. Entering a wrong code, should trigger the alarm"
                severity failure;

            -- 3
            wait for clk_period;
            assert door = door_loon and alarm = alarm_loon
            report "door_loon != door OR alarm_loon != alarm. Waiting for a clock cycle, should reset both door and alarm, to zero"
                severity failure;
    
            assert door = door_scan and alarm = alarm_scan
            report "door_scan != door OR alarm_scan != alarm. Waiting for a clock cycle, should reset both door and alarm, to zero"
                severity failure;

            -- 4
            reset    <= '0';
            day_time <= '1';
            code     <= x"5";
            wait for clk_period;
            assert door = door_loon and alarm = alarm_loon
            report "door_loon != door OR alarm_loon != alarm. Entering a wrong code, even during daytime should trigger the alarm"
                severity failure;
    
            assert door = door_scan and alarm = alarm_scan
            report "door_scan != door OR alarm_scan != alarm. Entering a wrong code, even during daytime should trigger the alarm"
                severity failure;

            -- 5
            wait for clk_period;
            assert door = door_loon and alarm = alarm_loon
            report "door_loon != door OR alarm_loon != alarm. Waiting for a clock cycle, should reset both door and alarm, to zero"
                severity failure;
    
            assert door = door_scan and alarm = alarm_scan
            report "door_scan != door OR alarm_scan != alarm. Waiting for a clock cycle, should reset both door and alarm, to zero"
                severity failure;

            -- 6
            reset    <= '0';
            day_time <= '0';
            code     <= o;
            wait for clk_period;
            assert door = door_loon and alarm = alarm_loon
            report "door_loon != door OR alarm_loon != alarm. Entering 'O' during night time should trigger the alarm"
                severity failure;
    
            assert door = door_scan and alarm = alarm_scan
            report "door_scan != door OR alarm_scan != alarm. Entering 'O' during night time should trigger the alarm"
                severity failure;

            -- 7
            wait for clk_period;
            assert door = door_loon and alarm = alarm_loon
            report "door_loon != door OR alarm_loon != alarm. Waiting for a clock cycle, should reset both door and alarm, to zero"
                severity failure;
    
            assert door = door_scan and alarm = alarm_scan
            report "door_scan != door OR alarm_scan != alarm. Waiting for a clock cycle, should reset both door and alarm, to zero"
                severity failure;

            -- 8
            reset    <= '0';
            day_time <= '1';
            code     <= o;
            wait for clk_period;
            assert door = door_loon and alarm = alarm_loon
            report "door_loon != door OR alarm_loon != alarm. Entering 'O' during daytime should open the door"
                severity failure;
    
            assert door = door_scan and alarm = alarm_scan
            report "door_scan != door OR alarm_scan != alarm. Entering 'O' during daytime should open the door"
                severity failure;

            -- 9
            wait for clk_period;
            assert door = door_loon and alarm = alarm_loon
            report "door_loon != door OR alarm_loon != alarm. Waiting for a clock cycle, should reset both door and alarm, to zero"
                severity failure;
    
            assert door = door_scan and alarm = alarm_scan
            report "door_scan != door OR alarm_scan != alarm. Waiting for a clock cycle, should reset both door and alarm, to zero"
                severity failure;

            -- 10
            reset    <= '0';
            day_time <= '0';
            code     <= x"2";
            wait for clk_period;
            assert door = door_loon and alarm = alarm_loon
            report "door_loon != door OR alarm_loon != alarm. Entering 2 neither opens the door, nor triggers the alarm"
                severity failure;
    
            assert door = door_scan and alarm = alarm_scan
            report "door_scan != door OR alarm_scan != alarm. Entering 2 neither opens the door, nor triggers the alarm"
                severity failure;

            -- 11
            reset    <= '0';
            day_time <= '0';
            code     <= x"6";
            wait for clk_period;
            assert door = door_loon and alarm = alarm_loon
            report "door_loon != door OR alarm_loon != alarm. Entering 2, 6 neither opens the door, nor triggers the alarm"
                severity failure;
    
            assert door = door_scan and alarm = alarm_scan
            report "door_scan != door OR alarm_scan != alarm. Entering 2, 6 neither opens the door, nor triggers the alarm"
                severity failure;

            -- 12
            reset    <= '0';
            day_time <= '1';
            code     <= a;
            wait for clk_period;
            assert door = door_loon and alarm = alarm_loon
            report "door_loon != door OR alarm_loon != alarm. Entering 2, 6, A neither opens the door, nor triggers the alarm, switching daytime to 1 and not pressing 'O' , will not open the door nor trigger the alarm"
                severity failure;
    
            assert door = door_scan and alarm = alarm_scan
            report "door_scan != door OR alarm_scan != alarm. Entering 2, 6, A neither opens the door, nor triggers the alarm, switching daytime to 1 and not pressing 'O' , will not open the door nor trigger the alarm"
                severity failure;

            -- 13
            reset    <= '0';
            day_time <= '0';
            code     <= x"0";
            wait for clk_period;
            assert door = door_loon and alarm = alarm_loon
            report "door_loon != door OR alarm_loon != alarm. Entering 2, 6, A, 0 neither opens the door, nor triggers the alarm"
                severity failure;
    
            assert door = door_scan and alarm = alarm_scan
            report "door_scan != door OR alarm_scan != alarm. Entering 2, 6, A, 0 neither opens the door, nor triggers the alarm"
                severity failure;

            -- 14
            reset    <= '0';
            day_time <= '0';
            code     <= x"5";
            wait for clk_period;
            assert door = door_loon and alarm = alarm_loon
            report "door_loon != door OR alarm_loon != alarm. Entering 2, 6, A, 0, 5 opens the door, but doesn't trigger the alarm"
                severity failure;
    
            assert door = door_scan and alarm = alarm_scan
            report "door_scan != door OR alarm_scan != alarm. Entering 2, 6, A, 0, 5 opens the door, but doesn't trigger the alarm"
                severity failure;

            -- 15		
            wait for clk_period;
            assert door = door_loon and alarm = alarm_loon
            report "door_loon != door OR alarm_loon != alarm. Waiting for a clock cycle, should reset both door and alarm, to zero"
                severity failure;
    
            assert door = door_scan and alarm = alarm_scan
            report "door_scan != door OR alarm_scan != alarm. Waiting for a clock cycle, should reset both door and alarm, to zero"
                severity failure;

    
            assert false
            report "FSM PASSED ALL TEST SUCCESSFULLY."
                severity error;
            wait;
        end process;
    
        process begin
            clk <= '1', '0' after (clk_period/2);
            wait for clk_period;
        end process;
    
    end architecture all_tb_behav;