%let ora_un= B2463104_MERCK_VACC_SCHE1;
%let ora_pw= B2463104; 
%let dbase = PAA;
libname odata oledb init_string="Provider=OraOLEDB.Oracle;Data Source=&dbase.;USER ID=&ora_un;PASSWORD=&ora_pw.;PORT=1521" 
schema="&ora_un.";


%MACRO export_data(mkt=, mkt_long=);

data switch_new_report_&mkt.; 
	set odata.switch_new_report_&mkt.;
run; 

PROC EXPORT DATA= switch_new_report_&mkt.
     OUTFILE= "L:\Shua\Project\Merck Pediatric Vaccine\switch_new_rpt.xlsx" 
     DBMS=excel replace;
	 sheet="&mkt_long.";
RUN;

%mend;


%MACRO export_loop;
%let mkt_list=HEPA|HEPB|HIB|ROTA;
%let mkt_long_list=HEP A|HEP B|HIB|ROTAVIRUS;

%do k=1 %to 4;
	%export_data(mkt=%scan(&mkt_list,&k,%str(|)), mkt_long=%scan(&mkt_long_list,&k,%str(|)));
%end;
%mend;
%export_loop;
