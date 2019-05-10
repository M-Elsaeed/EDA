sdetm_p.ap: sdet.ioc sdetm_b_l_scan.vst
	MBK_IN_LO=vst; export MBK_IN_LO; \
	MBK_OUT_PH=ap; export MBK_OUT_PH; \
	ocp -v -ring -ioc sdet sdetm_b_l_scan sdet_p > ocp.out

sdetm_b_l_scan.ap: sdet_p.ap sdetm_b_l_scan.vst
	nero -V -p sdet_p sdetm_b_l_scan sdetm_b_l_scan > nero.out

%.al : %.ap
	MBK_OUT_LO=al; export MBK_OUT_LO; \
	RDS_TECHNO_NAME=./techno/techno-035.rds; \
	export RDS_TECHNO_NAME; \
	cougar -v $* > cougar_$*.out
	lvx vst al $* $* -f > lvx_$*.out