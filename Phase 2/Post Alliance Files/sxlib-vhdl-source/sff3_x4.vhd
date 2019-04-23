ENTITY sff3_x4 IS
GENERIC (
  CONSTANT area 	 : NATURAL := 7000;
  CONSTANT cin_ck	 : NATURAL := 8;
  CONSTANT cin_cmd0	 : NATURAL := 15;
  CONSTANT cin_cmd1	 : NATURAL := 15;
  CONSTANT cin_i0	 : NATURAL := 9;
  CONSTANT cin_i1	 : NATURAL := 8;
  CONSTANT cin_i2	 : NATURAL := 8;
  CONSTANT rdown_ck_q	 : NATURAL := 890;
  CONSTANT rup_ck_q	 : NATURAL := 810;
  CONSTANT taf_ck_q	 : NATURAL := 600;
  CONSTANT tar_ck_q	 : NATURAL := 600;
  CONSTANT thf_ck_q	 : NATURAL := 0;
  CONSTANT thf_cmd0_ck	 : NATURAL := 0;
  CONSTANT thf_cmd1_ck	 : NATURAL := 0;
  CONSTANT thf_i0_ck	 : NATURAL := 0;
  CONSTANT thf_i1_ck	 : NATURAL := 0;
  CONSTANT thf_i2_ck	 : NATURAL := 0;
  CONSTANT thr_ck_q	 : NATURAL := 0;
  CONSTANT thr_cmd0_ck	 : NATURAL := 0;
  CONSTANT thr_cmd1_ck	 : NATURAL := 0;
  CONSTANT thr_i0_ck	 : NATURAL := 0;
  CONSTANT thr_i1_ck	 : NATURAL := 0;
  CONSTANT thr_i2_ck	 : NATURAL := 0;
  CONSTANT tsf_cmd0_ck	 : NATURAL := 1200;
  CONSTANT tsf_cmd1_ck	 : NATURAL := 1200;
  CONSTANT tsf_i0_ck	 : NATURAL := 1200;
  CONSTANT tsf_i1_ck	 : NATURAL := 1200;
  CONSTANT tsf_i2_ck	 : NATURAL := 1200;
  CONSTANT tsr_cmd0_ck	 : NATURAL := 1100;
  CONSTANT tsr_cmd1_ck	 : NATURAL := 1100;
  CONSTANT tsr_i0_ck	 : NATURAL := 850;
  CONSTANT tsr_i1_ck	 : NATURAL := 950;
  CONSTANT tsr_i2_ck	 : NATURAL := 950;
  CONSTANT transistors	 : NATURAL := 42
);
PORT (
  ck	 : in  BIT;
  cmd0	 : in  BIT;
  cmd1	 : in  BIT;
  i0	 : in  BIT;
  i1	 : in  BIT;
  i2	 : in  BIT;
  q	 : out BIT;
  vdd	 : in  BIT;
  vss	 : in  BIT
);
END sff3_x4;

ARCHITECTURE behaviour_data_flow OF sff3_x4 IS

BEGIN
  ASSERT ((vdd and not (vss)) = '1')
  REPORT "power supply is missing on sff3_x4"
  SEVERITY WARNING;

  PROCESS ( ck )
  BEGIN
    IF  ((ck = '1') AND ck'EVENT)
    THEN q <= ((NOT(cmd0) AND i0) OR (cmd0 AND ((cmd1 AND i1) OR (NOT(cmd1) AND i2)))) after 2400 ps;
    END IF;
  END PROCESS;

END;
