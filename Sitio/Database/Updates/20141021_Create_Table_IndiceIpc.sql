/*drop table indiceipc;

CREATE TABLE indiceipc (
   Periodo VARCHAR(6) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
   Indice DECIMAL(20,4) NOT NULL,
  PRIMARY KEY (Periodo)
) ENGINE = InnoDB ROW_FORMAT = DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci;

insert into indiceipc values('200701', 11837814275);
insert into indiceipc values('200702', 11975958083);
insert into indiceipc values('200703', 11984565420);
insert into indiceipc values('200704', 12299866365);
insert into indiceipc values('200705', 12500288183);
insert into indiceipc values('200706', 12924432024);
insert into indiceipc values('200707', 13339755981);
insert into indiceipc values('200708', 13952512492);
insert into indiceipc values('200709', 14321832251);
insert into indiceipc values('200710', 14746663224);
insert into indiceipc values('200711', 14875847592);
insert into indiceipc values('200712', 15067298211);
insert into indiceipc values('200801', 15232285548);
insert into indiceipc values('200802', 15798840948);
insert into indiceipc values('200803', 16131528868);
insert into indiceipc values('200804', 16466329607);
insert into indiceipc values('200805', 16898083313);
insert into indiceipc values('200806', 17301484057);
insert into indiceipc values('200807', 17514020660);
insert into indiceipc values('200808', 17811007217);
insert into indiceipc values('200809', 18034875541);
insert into indiceipc values('200810', 18224285412);
insert into indiceipc values('200811', 18328051912);
insert into indiceipc values('200812', 18384667186);
insert into indiceipc values('200901', 18423241482);
insert into indiceipc values('200902', 18633501700);
insert into indiceipc values('200903', 18883179669);
insert into indiceipc values('200904', 19134925282);
insert into indiceipc values('200905', 19252373375);
insert into indiceipc values('200906', 19377381445);
insert into indiceipc values('200907', 19872205050);
insert into indiceipc values('200908', 20343584897);
insert into indiceipc values('200909', 20493056499);
insert into indiceipc values('200910', 20794855937);
insert into indiceipc values('200911', 21012060973);
insert into indiceipc values('200912', 21396106725);
insert into indiceipc values('201001', 21748227798);
insert into indiceipc values('201002', 22316160107);
insert into indiceipc values('201003', 23020101397);
insert into indiceipc values('201004', 23563739783);
insert into indiceipc values('201005', 24008653867);
insert into indiceipc values('201006', 24512095092);
insert into indiceipc values('201007', 25096968281);
insert into indiceipc values('201008', 25646483069);
insert into indiceipc values('201009', 25703559156);
insert into indiceipc values('201010', 26366337766);
insert into indiceipc values('201011', 26777167037);
insert into indiceipc values('201012', 27102289643);
insert into indiceipc values('201101', 27923922129);
insert into indiceipc values('201102', 28171601687);
insert into indiceipc values('201103', 29007269276);
insert into indiceipc values('201104', 29754465759);
insert into indiceipc values('201105', 30502855297);
insert into indiceipc values('201106', 30976795289);
insert into indiceipc values('201107', 31934202005);
insert into indiceipc values('201108', 32624464943);
insert into indiceipc values('201109', 33335416901);
insert into indiceipc values('201110', 33682274061);
insert into indiceipc values('201111', 34323360749);
insert into indiceipc values('201112', 34886327223.5);
insert into indiceipc values('201201', 35564362969.49);
insert into indiceipc values('201202', 35844109122.31);
insert into indiceipc values('201203', 36852826823.08);
insert into indiceipc values('201204', 37970756174.12);
insert into indiceipc values('201205', 38655761048.65);
insert into indiceipc values('201206', 39788893309.06);
insert into indiceipc values('201207', 41058615692.11);
insert into indiceipc values('201208', 41642517082.9);
insert into indiceipc values('201209', 42577778267);
insert into indiceipc values('201210', 43143239961);
insert into indiceipc values('201211', 43545449540);
insert into indiceipc values('201212', 44202440680.13);
insert into indiceipc values('201301', 44946954000.45);
insert into indiceipc values('201302', 45579306140.03);
insert into indiceipc values('201303', 45762321755.35);
insert into indiceipc values('201304', 46232140429.66);
insert into indiceipc values('201305', 47227629524.84);
insert into indiceipc values('201306', 48505205247.93);
insert into indiceipc values('201307', 50058670819.74);
insert into indiceipc values('201308', 51112939083.47);
insert into indiceipc values('201309', 51489078937.17);
insert into indiceipc values('201310', 53437512199.04);
insert into indiceipc values('201311', 55031426332.08);
insert into indiceipc values('201312', 56711971234.46);
insert into indiceipc values('201401', 59169863530.1);
insert into indiceipc values('201402', 62697716815.07);
insert into indiceipc values('201403', 63845551556.5);
insert into indiceipc values('201404', 66194896097.74);
insert into indiceipc values('201405', 67886750505.22);
insert into indiceipc values('201406', 68774043571.09);
insert into indiceipc values('201407', 70457109915.13);
insert into indiceipc values('201408', 71959880072.85);*/

DROP FUNCTION IF EXISTS fnActualizarMonto;
CREATE FUNCTION fnActualizarMonto(pMonto DECIMAL, pPeriodoMonto VARCHAR(6), pPeriodoActualiz VARCHAR(6)) RETURNS DECIMAL(14,2)
BEGIN
  /*DECLARE vIndice DECIMAL(20,15) DEFAULT 0;
  DECLARE vReturn DECIMAL(14,2) DEFAULT 0;
  DECLARE vDone INT DEFAULT 0;  
  DECLARE vCur CURSOR FOR select Indice from indiceipc where Periodo > pPeriodoMonto and Periodo <= pPeriodoActualiz order by Periodo asc;
  DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET vDone = 1;
  
  SET vDone = 0;
  SET vReturn = pMonto;
  OPEN vCur;
  
  REPEAT
    FETCH vCur INTO vIndice;
    
    IF NOT vDone THEN
      SET vReturn = vReturn + (vReturn*vIndice)/100;
    END IF;
  
  UNTIL vDone END REPEAT;*/
  declare vIpcBase decimal(20,4);
  declare vIpcActual decimal(20,4);
  
  select Indice into vIpcBase from indiceipc where Periodo=pPeriodoMonto;
  select Indice into vIpcActual from indiceipc where Periodo<=pPeriodoActualiz order by Periodo desc limit 1;

  return (pMonto * vIpcActual) / vIpcBase;
END;
