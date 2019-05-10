sdetm_p.ap_ocp : sdet.ioc sdetm_b_l_scan.vst
	MBK_IN_LO=vst; export MBK_IN_LO; \
	MBK_OUT_PH=ap; export MBK_OUT_PH; \
	ocp -v -ring -ioc sdet sdetm_b_l_scan sdet_p > ocp.out

sdetm_b_l_scan.ap_nero : sdet_p.ap sdetm_b_l_scan.vst
	nero -V -p sdet_p sdetm_b_l_scan sdetm_b_l_scan > nero.out

%.al_cougar_lvx : %.ap
	MBK_OUT_LO=al; export MBK_OUT_LO; \
	RDS_TECHNO_NAME=./techno/techno-035.rds; \
	export RDS_TECHNO_NAME; \
	cougar -v $* > cougar_$*.out
	lvx vst al $* $* -f > lvx_$*.out

druc_core : sdetm_b_l_scan.ap
	RDS_TECHNO_NAME=./techno/techno-symb.rds; \
	export RDS_TECHNO_NAME; \
	druc sdetm_b_l_scan > druc_core.out

sdet_chip.cif : sdetm_b_l_scan.ap
	RDS_TECHNO_NAME=./techno/techno-035.rds; \
	export RDS_TECHNO_NAME; \
	RDS_OUT=cif; export RDS_OUT; \
	s2r -v -r sdetm_b_l_scan > s2r.out

_dreal : sdetm_b_l_scan.cif
	RDS_TECHNO_NAME=./techno/techno-035.rds; \
	export RDS_TECHNO_NAME; \
	RDS_IN=cif; export RDS_IN; \
	dreal -l sdetm_b_l_scan
