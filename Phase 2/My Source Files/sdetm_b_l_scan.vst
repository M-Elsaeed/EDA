entity sdetm_b_l_scan is
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
end sdetm_b_l_scan;

architecture structural of sdetm_b_l_scan is
Component nao2o22_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      i2  : in      bit;
      i3  : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component nxr2_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component inv_x4
   port (
      i   : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component na4_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      i2  : in      bit;
      i3  : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component ao22_x2
   port (
      i0  : in      bit;
      i1  : in      bit;
      i2  : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component oa22_x2
   port (
      i0  : in      bit;
      i1  : in      bit;
      i2  : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component inv_x2
   port (
      i   : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component no3_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      i2  : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component o3_x2
   port (
      i0  : in      bit;
      i1  : in      bit;
      i2  : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component o2_x2
   port (
      i0  : in      bit;
      i1  : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component na2_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component na3_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      i2  : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component a2_x2
   port (
      i0  : in      bit;
      i1  : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component noa22_x1
   port (
      i1  : in      bit;
      i0  : in      bit;
      i2  : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component nao22_x1
   port (
      i1  : in      bit;
      i0  : in      bit;
      i2  : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component o4_x2
   port (
      i0  : in      bit;
      i1  : in      bit;
      i2  : in      bit;
      i3  : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component no2_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component sff2_x4
   port (
      ck  : in      bit;
      cmd : in      bit;
      i0  : in      bit;
      i1  : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component buf_x2
   port (
      i   : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

signal dac_current_state     : bit_vector( 2 downto 0);
signal not_code              : bit_vector( 3 downto 0);
signal not_dac_current_state : bit_vector( 2 downto 1);
signal oa22_x2_sig           : bit;
signal o4_x2_sig             : bit;
signal o4_x2_2_sig           : bit;
signal o3_x2_sig             : bit;
signal o3_x2_2_sig           : bit;
signal o2_x2_sig             : bit;
signal o2_x2_4_sig           : bit;
signal o2_x2_3_sig           : bit;
signal o2_x2_2_sig           : bit;
signal not_aux9              : bit;
signal not_aux8              : bit;
signal not_aux3              : bit;
signal not_aux2              : bit;
signal not_aux11             : bit;
signal not_aux10             : bit;
signal not_aux1              : bit;
signal not_aux0              : bit;
signal noa22_x1_sig          : bit;
signal noa22_x1_2_sig        : bit;
signal no3_x1_sig            : bit;
signal no3_x1_2_sig          : bit;
signal no2_x1_sig            : bit;
signal no2_x1_2_sig          : bit;
signal nao22_x1_sig          : bit;
signal nao22_x1_3_sig        : bit;
signal nao22_x1_2_sig        : bit;
signal na4_x1_sig            : bit;
signal na3_x1_sig            : bit;
signal na3_x1_3_sig          : bit;
signal na3_x1_2_sig          : bit;
signal na2_x1_sig            : bit;
signal na2_x1_2_sig          : bit;
signal inv_x2_sig            : bit;
signal aux7                  : bit;
signal ao22_x2_sig           : bit;
signal a2_x2_sig             : bit;
signal a2_x2_2_sig           : bit;

begin

not_aux9_ins : o2_x2
   port map (
      i0  => reset,
      i1  => not_code(0),
      q   => not_aux9,
      vdd => vdd,
      vss => vss
   );

no2_x1_ins : no2_x1
   port map (
      i0  => not_dac_current_state(1),
      i1  => not_dac_current_state(2),
      nq  => no2_x1_sig,
      vdd => vdd,
      vss => vss
   );

not_aux11_ins : nao2o22_x1
   port map (
      i0  => code(3),
      i1  => no2_x1_sig,
      i2  => day_time,
      i3  => not_code(3),
      nq  => not_aux11,
      vdd => vdd,
      vss => vss
   );

not_aux3_ins : a2_x2
   port map (
      i0  => not_aux2,
      i1  => not_dac_current_state(2),
      q   => not_aux3,
      vdd => vdd,
      vss => vss
   );

not_aux2_ins : a2_x2
   port map (
      i0  => dac_current_state(1),
      i1  => dac_current_state(0),
      q   => not_aux2,
      vdd => vdd,
      vss => vss
   );

not_aux8_ins : o2_x2
   port map (
      i0  => code(2),
      i1  => not_dac_current_state(1),
      q   => not_aux8,
      vdd => vdd,
      vss => vss
   );

not_aux10_ins : o2_x2
   port map (
      i0  => code(3),
      i1  => not_code(1),
      q   => not_aux10,
      vdd => vdd,
      vss => vss
   );

not_dac_current_state_2_ins : inv_x2
   port map (
      i   => dac_current_state(2),
      nq  => not_dac_current_state(2),
      vdd => vdd,
      vss => vss
   );

not_aux1_ins : nxr2_x1
   port map (
      i0  => dac_current_state(0),
      i1  => code(2),
      nq  => not_aux1,
      vdd => vdd,
      vss => vss
   );

not_aux0_ins : a2_x2
   port map (
      i0  => not_code(2),
      i1  => not_dac_current_state(1),
      q   => not_aux0,
      vdd => vdd,
      vss => vss
   );

not_dac_current_state_1_ins : inv_x4
   port map (
      i   => dac_current_state(1),
      nq  => not_dac_current_state(1),
      vdd => vdd,
      vss => vss
   );

not_code_3_ins : inv_x2
   port map (
      i   => code(3),
      nq  => not_code(3),
      vdd => vdd,
      vss => vss
   );

not_code_2_ins : inv_x2
   port map (
      i   => code(2),
      nq  => not_code(2),
      vdd => vdd,
      vss => vss
   );

not_code_1_ins : inv_x2
   port map (
      i   => code(1),
      nq  => not_code(1),
      vdd => vdd,
      vss => vss
   );

not_code_0_ins : inv_x2
   port map (
      i   => code(0),
      nq  => not_code(0),
      vdd => vdd,
      vss => vss
   );

aux7_ins : no2_x1
   port map (
      i0  => reset,
      i1  => not_aux3,
      nq  => aux7,
      vdd => vdd,
      vss => vss
   );

o2_x2_ins : o2_x2
   port map (
      i0  => code(2),
      i1  => not_aux10,
      q   => o2_x2_sig,
      vdd => vdd,
      vss => vss
   );

noa22_x1_ins : noa22_x1
   port map (
      i1  => not_aux8,
      i0  => not_code(1),
      i2  => code(0),
      nq  => noa22_x1_sig,
      vdd => vdd,
      vss => vss
   );

o2_x2_2_ins : o2_x2
   port map (
      i0  => not_code(3),
      i1  => not_aux0,
      q   => o2_x2_2_sig,
      vdd => vdd,
      vss => vss
   );

na4_x1_ins : na4_x1
   port map (
      i0  => not_aux1,
      i1  => o2_x2_2_sig,
      i2  => noa22_x1_sig,
      i3  => o2_x2_sig,
      nq  => na4_x1_sig,
      vdd => vdd,
      vss => vss
   );

ao22_x2_ins : ao22_x2
   port map (
      i0  => na4_x1_sig,
      i1  => dac_current_state(2),
      i2  => aux7,
      q   => ao22_x2_sig,
      vdd => vdd,
      vss => vss
   );

oa22_x2_ins : oa22_x2
   port map (
      i0  => dac_current_state(0),
      i1  => code(2),
      i2  => dac_current_state(2),
      q   => oa22_x2_sig,
      vdd => vdd,
      vss => vss
   );

inv_x2_ins : inv_x2
   port map (
      i   => not_aux0,
      nq  => inv_x2_sig,
      vdd => vdd,
      vss => vss
   );

nao22_x1_ins : nao22_x1
   port map (
      i1  => dac_current_state(0),
      i0  => inv_x2_sig,
      i2  => dac_current_state(2),
      nq  => nao22_x1_sig,
      vdd => vdd,
      vss => vss
   );

no3_x1_ins : no3_x1
   port map (
      i0  => code(0),
      i1  => not_code(1),
      i2  => code(3),
      nq  => no3_x1_sig,
      vdd => vdd,
      vss => vss
   );

na3_x1_ins : na3_x1
   port map (
      i0  => no3_x1_sig,
      i1  => nao22_x1_sig,
      i2  => oa22_x2_sig,
      nq  => na3_x1_sig,
      vdd => vdd,
      vss => vss
   );

a2_x2_ins : a2_x2
   port map (
      i0  => na3_x1_sig,
      i1  => aux7,
      q   => a2_x2_sig,
      vdd => vdd,
      vss => vss
   );

na3_x1_2_ins : na3_x1
   port map (
      i0  => not_code(0),
      i1  => not_code(3),
      i2  => not_code(1),
      nq  => na3_x1_2_sig,
      vdd => vdd,
      vss => vss
   );

o4_x2_ins : o4_x2
   port map (
      i0  => not_aux8,
      i1  => na3_x1_2_sig,
      i2  => dac_current_state(0),
      i3  => dac_current_state(2),
      q   => o4_x2_sig,
      vdd => vdd,
      vss => vss
   );

no2_x1_2_ins : no2_x1
   port map (
      i0  => reset,
      i1  => not_aux2,
      nq  => no2_x1_2_sig,
      vdd => vdd,
      vss => vss
   );

na2_x1_ins : na2_x1
   port map (
      i0  => no2_x1_2_sig,
      i1  => o4_x2_sig,
      nq  => na2_x1_sig,
      vdd => vdd,
      vss => vss
   );

no3_x1_2_ins : no3_x1
   port map (
      i0  => not_code(2),
      i1  => not_aux11,
      i2  => code(1),
      nq  => no3_x1_2_sig,
      vdd => vdd,
      vss => vss
   );

o3_x2_ins : o3_x2
   port map (
      i0  => not_aux9,
      i1  => not_aux3,
      i2  => no3_x1_2_sig,
      q   => o3_x2_sig,
      vdd => vdd,
      vss => vss
   );

o2_x2_3_ins : o2_x2
   port map (
      i0  => code(0),
      i1  => reset,
      q   => o2_x2_3_sig,
      vdd => vdd,
      vss => vss
   );

o3_x2_2_ins : o3_x2
   port map (
      i0  => dac_current_state(0),
      i1  => not_aux10,
      i2  => dac_current_state(2),
      q   => o3_x2_2_sig,
      vdd => vdd,
      vss => vss
   );

nao22_x1_2_ins : nao22_x1
   port map (
      i1  => code(1),
      i0  => dac_current_state(1),
      i2  => o3_x2_2_sig,
      nq  => nao22_x1_2_sig,
      vdd => vdd,
      vss => vss
   );

o2_x2_4_ins : o2_x2
   port map (
      i0  => not_aux0,
      i1  => dac_current_state(0),
      q   => o2_x2_4_sig,
      vdd => vdd,
      vss => vss
   );

na2_x1_2_ins : na2_x1
   port map (
      i0  => dac_current_state(0),
      i1  => not_dac_current_state(1),
      nq  => na2_x1_2_sig,
      vdd => vdd,
      vss => vss
   );

na3_x1_3_ins : na3_x1
   port map (
      i0  => not_dac_current_state(2),
      i1  => na2_x1_2_sig,
      i2  => o2_x2_4_sig,
      nq  => na3_x1_3_sig,
      vdd => vdd,
      vss => vss
   );

a2_x2_2_ins : a2_x2
   port map (
      i0  => not_code(3),
      i1  => not_aux1,
      q   => a2_x2_2_sig,
      vdd => vdd,
      vss => vss
   );

nao22_x1_3_ins : nao22_x1
   port map (
      i1  => not_dac_current_state(2),
      i0  => not_aux0,
      i2  => a2_x2_2_sig,
      nq  => nao22_x1_3_sig,
      vdd => vdd,
      vss => vss
   );

noa22_x1_2_ins : noa22_x1
   port map (
      i1  => nao22_x1_3_sig,
      i0  => na3_x1_3_sig,
      i2  => nao22_x1_2_sig,
      nq  => noa22_x1_2_sig,
      vdd => vdd,
      vss => vss
   );

alarm_ins : nao22_x1
   port map (
      i1  => noa22_x1_2_sig,
      i0  => o2_x2_3_sig,
      i2  => o3_x2_sig,
      nq  => alarm,
      vdd => vdd,
      vss => vss
   );

o4_x2_2_ins : o4_x2
   port map (
      i0  => code(1),
      i1  => not_code(2),
      i2  => not_aux9,
      i3  => not_aux3,
      q   => o4_x2_2_sig,
      vdd => vdd,
      vss => vss
   );

door_ins : no2_x1
   port map (
      i0  => not_aux11,
      i1  => o4_x2_2_sig,
      nq  => door,
      vdd => vdd,
      vss => vss
   );

dac_current_state_0_ins_scan_0 : sff2_x4
   port map (
      ck  => clk,
      cmd => test,
      i0  => ao22_x2_sig,
      i1  => scanin,
      q   => dac_current_state(0),
      vdd => vdd,
      vss => vss
   );

dac_current_state_1_ins_scan_1 : sff2_x4
   port map (
      ck  => clk,
      cmd => test,
      i0  => a2_x2_sig,
      i1  => dac_current_state(0),
      q   => dac_current_state(1),
      vdd => vdd,
      vss => vss
   );

dac_current_state_2_ins_scan_2 : sff2_x4
   port map (
      ck  => clk,
      cmd => test,
      i0  => na2_x1_sig,
      i1  => dac_current_state(1),
      q   => dac_current_state(2),
      vdd => vdd,
      vss => vss
   );

buf_scan_3 : buf_x2
   port map (
      i   => dac_current_state(2),
      q   => scanout,
      vdd => vdd,
      vss => vss
   );


end structural;
