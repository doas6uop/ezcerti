  
  -----------------------------------------------------------------------------
  --
  -- * 본 문서는 스마트 출결 프로젝트의 src/main/etc 폴더에 존재하며
  --   공통문서 및 학교별 학기 생성정보 수정 시 수정된 내용을 같이 svn에 반영해야함(최신화)
  --   (따라서 sql툴에서 문서 수정 시 이클립스 workspace문서를 바로 사용하기를 권함
  -- 
  -- 00. 스마트 출결 학기정보 생성 절차
  --    - 학기정보 세팅을 위해서는 학교마다 학사력 관련 정보를 확인해야함
  --      일반적인 요청 정보(신규학기정보 학교요청 메일)는 NAS 참조
  --      (NAS : 00.유지보수 > 출결관리 > 00. 신규 학기 생성 관련
  --
  --    - 학교측 학사력 정보를 토대로 NAS의 연도별 학기자료처리 엑셀을 생성하여
  --      1번, 3번 시트에 내용을 기재하여 사용 (3번시트에 학기생성 쿼리 존재)
  --
  -- 01. 새 학기 정보 생성
  --
  --    1. 학기정보 등록 (엑셀을 토대로 이전 학기 마감 처리 후 새 학기 생성)
  --
  --    2. CHUL_TB_CLASSDAY 생성 (일자생성)
  --
  --    3. 동기화페이지 접속하여 웹상에서 동기화 처리 (프로시저 수행)
  --       
  --	   * 단일DB의 경우는 학교측에서 제공된 VIEW를 통해 데이터를 확인하고 동기화 처리
  --         이기종DB의 경우는 원래의DB(학교)의 VIEW 데이터를 확인 후 동기화 처리
  --       * 뷰 특성에 따라 학교마다 조회 방법이 다를 수 있고 뷰의 갯수도 다를수 있음
  --
  --       * 학교에서 새 학기 데이터를 제공했을 시 (VW..)
  --        1) 기본학교URL/comm/log_list 접속 후 > '동기화' 페이지 클릭
  --        2) 기초자료동기화 > 전체 실행
  --        3) 출결자료동기화 > 전체 실행
  --        % 현재 개별동기화 기능은 오라클 > MSSQL로 이관하는 이기종 DB만 가능 하고
  --          이 기종DB가 아닌 경우는 전체만 실행 가능
  --
  --       메뉴 설명
  --       '기초자료 동기화' : 학교측뷰 > 동기화 테이블 데이터 이관 (UNIV_TB..)
  --       '출결자료 동기화' : 동기화 테이블 > 실 사용테이블 (CHUL_TB..)
  --       '기타 동기화' : 기타 학교마다 특성에 따른 정보들 동기화 (성적이관.. 등등)
  --       
  --       * 기본적으로 동기화 작업은 학기정보와 CHUL_TB_CLASSDAY의 데이터가 생성되면
  --         다음날 자동으로 동기화 처리가 되지만 수동으로 데이터 생성시에는 해당 페이지에
  --         접속하여 수동으로 처리 가능
  --         '기초자료 동기화' 부분은 동기화 처리 하여도 문제가 없으나 '출결자료 동기화'의 경우는
  --         현재 사용되고 있는 데이터를 변경 하는 것이므로 주의가 필요
  --         (단 학교 오픈전이나 사용량이 적을 경우만 사용 '출결자료 동기화' 주의 필요!!)
  --
  --    4. 생성 데이터 확인 (UNIV_TB.., CHUL_TB..)
  --       4.1 기타 동기화 작업 (학교별 기능에 따른 동기화 작업)
  --           학교측에서 자료를 view 형태로 제공해주면 자동동기화 처리
  --           그렇지 않으면 수동 동기화 처리 (처음 제공된 자료가 불변하면 자동동기화 처리 가능)
  --
  --    5. 교수정보 마감해제 (새학기 등록 시)
  --
  --    6. 기타 체크(주말(토/일) 강의 체크)
  --      - 주말강의가 존재할 경우 '학기마김일', '보강종료일'도 주말이 고려되야함
  --        일강동기화 학교의 경우는 거의 해당사항이 없지만 출결프로그램을 통해 동기화
  --        하는 경우는 주차에 따라 강의를 생성하기 때문에 주말이 포함이 안되어 있으면
  --        주말강의들은 15주차로 강의가 떨어지지 않을 수 있음
  --    
  --    7. 이상 강의 체크 
  --      - 집중강의를 제외하고 일반적으로 강의생성 시 강의수는 15개
  --        15개가 아닌 강의는 주차 및 보강일자에 따라 강의가 잘못 생성된 것일 수 있음
  --        * 차의과대는 보강주가 따로 없고 강의가 16개 생성됨
  -----------------------------------------------------------------------------
  
  -- ##########################################################################
  -----------------------------------------------------------------------------
  -- * 추가 사항 (스마트 출결 이전 버전)
  --
  -- !!!!! 스마트출결 이전 버전의 경우 동기화 처리를 하지 않는 경우가 있음
  -- 최신 버전의 경우 학교뷰 > UNIV_TB로 동기화 처리후 해당 테이블을 뷰로 사용하는데
  -- 이전버전의 경우 학교 뷰를 다이렉트로 사용하는 경우가 대다수임
  -- 따라서 동기화 과정이 빠지고 CHUL_TB 데이터를 학교 뷰를 통해 바로 생성
  -- 뷰의 명칭도 V_UNIV_VW를 사용하지 않고 VW_를 사용
  -- 
  -- !!!!! 출결자료 생성에 따른 프로시저 호출 방법도 학교별로 상이 할 수 있음
  -- 이전버전 스마트 출결 프로시저 수행
  -- 이전 버전의 경우 동기화 기능이 없는 경우도 존재하여 학교 뷰를 다이렉트로 사용하여
  -- 출결 관련 데이터를 생성하는 경우도 있음
  --
  -----------------------------------------------------------------------------  
  -- ##########################################################################
  
  -----------------------------------------------------------------------------
  -- 1. 학기정보 등록
  -----------------------------------------------------------------------------
  
	-- 학교정보 조회문장	
	SELECT * 
    FROM CHUL_TB_UNIV	
	 ORDER BY YEAR DESC
          , TERM_START_DATE DESC
          ;	

	-- 학기 코드 정보 조회	
	SELECT * 
    FROM CHUL_TB_CODEMASTER	
	 WHERE CODE_GRP_CD = 'G002'	
	 ORDER BY CODE	
	 ;

  -- 기존학기 마감 처리
  -- UPDATE CHUL_TB_UNIV
     SET UNIV_STS_CD = 'G004C002'
     ;
COMMIT;

  -- 신규학기 추가
  -- INSERT INTO CHUL_TB_UNIV (
                                    UNIV_CD
                                  , YEAR
                                  , TERM_CD
                                  , UNIV_NAME
                                  , TERM_NAME
                                  , TERM_START_DATE
                                  , TERM_END_DATE
                                  , UNIV_STS_CD
                                  , REG_DATE
                                  , BOGANG_START
                                  , BOGANG_END
                                  , NOCLASS_START
                                  , NOCLASS_END
                                  , LSSN_ADMT_DT
                               )
                        VALUES (
									'KDU00001'
								  , '2019'
								  , 'G002C001'
								  , '경동대학교'
								  , '2019년 1학기'
								  , TO_DATE('2019-03-04')
								  , TO_DATE('2019-06-22')
								  , 'G004C001'
								  , SYSDATE
								  , TO_DATE('2019-06-10')
								  , TO_DATE('2019-06-15')
								  , TO_DATE('2019-06-10')
								  , TO_DATE('2019-06-15')
								  , '20190407'
                               )
                               ;
                               
  -----------------------------------------------------------------------------
  -- 2. CHUL_TB_CLASSDAY 생성 (일자생성)
  -----------------------------------------------------------------------------
  
  -- 프로시저 수행 (현재 활성화 학기로 학기기간의 CLASSDAY를 생성한다)
  -- EXECUTE CHUL_CREATE_CLASSDAY;			    -- MSSQL
  -- EXECUTE CHUL_CREATE_CLASSDAY();	  	    -- ORACLE/ALTIBASE
  
  SELECT *
    FROM CHUL_TB_CLASSDAY 
   WHERE (YEAR, TERM_CD) IN (
                                SELECT YEAR, TERM_CD 
                                  FROM CHUL_TB_UNIV 
                                 WHERE UNIV_STS_CD = 'G004C001'
                            )
   ORDER BY CLASSDAY ASC
   ;
                 
  -----------------------------------------------------------------------------
  -- 3. 동기화페이지 접속하여 웹상에서 동기화 처리 (프로시저 수행)
  -----------------------------------------------------------------------------
  
  -- 학교뷰 데이터 확인 (생성될 학기의 정보가 있어야 동기화가 가능함)
  --
  -- * 이기종 DB이므로 ORACLE에서 데이터를 확인해야함
  -- * 뷰 특성에 따라 학교마다 조회 방법이 다를 수 있고 뷰의 갯수도 다를수 있음
  
  -- #################################################################################
  -- !!!!! 스마트출결 이전 버전의 경우 동기화 처리를 하지 않는 경우가 있음
  -- 최신 버전의 경우 학교뷰 > UNIV_TB로 동기화 처리후 해당 테이블을 뷰로 사용하는데
  -- 이전버전의 경우 학교 뷰를 다이렉트로 사용하는 경우가 대다수임
  -- 따라서 동기화 과정이 빠지고 CHUL_TB 데이터를 학교 뷰를 통해 바로 생성
  -- 뷰의 명칭도 V_UNIV_VW를 사용하지 않고 VW_를 사용
  -- #################################################################################
  
  -----------------------------------------------------------------------------------------------------------------
  -- 필수뷰 (MSSQL OR ORACLE/ALTIBASE) 데이터 조회 (...)

  SELECT 'V_UNIV_VW_ATTENDEE' AS TBL, COUNT(*) AS CNT FROM VW_ATTENDEE WHERE YEAR = '2019' AND TERM_CD = '1' UNION
  -- SELECT * FROM VW_ATTENDEE WHERE YEAR = '2019' AND TERM_CD = '1'
  SELECT 'V_UNIV_VW_CLASS' AS TBL, COUNT(*) AS CNT FROM VW_CLASS WHERE YEAR = '2019' AND TERM_CD = '1' UNION
  -- SELECT * FROM VW_CLASS WHERE YEAR = '2019' AND TERM_CD = '1'
   
  SELECT 'V_UNIV_VW_CLASSHOUR' AS TBL, COUNT(*) AS CNT FROM VW_CLASSHOUR WHERE YEAR = '2019' AND TERM_CD = '1' UNION
  -- SELECT * FROM VW_CLASSHOUR WHERE YEAR = '2019' AND TERM_CD = '1'
  -- SELECT 'V_UNIV_VW_CLASSROOM' AS TBL, COUNT(*) AS CNT FROM VW_CLASSROOM UNION
  -- SELECT * FROM VW_CLASSROOM 
  SELECT 'V_UNIV_VW_COLL' AS TBL, COUNT(*) AS CNT FROM VW_COLL WHERE YEAR = '2019' AND TERM_CD = '1' UNION
  -- SELECT * FROM VW_COLL WHERE YEAR = '2019' AND TERM_CD = '1' UNION
  SELECT 'V_UNIV_VW_DEPT' AS TBL, COUNT(*) AS CNT FROM VW_DEPT WHERE YEAR = '2019' AND TERM_CD = '1' UNION
  -- SELECT * FROM VW_DEPT WHERE YEAR = '2019' AND TERM_CD = '1' UNION

  /*
  SELECT 'V_UNIV_VW_CLASSHOUR' AS TBL, COUNT(*) AS CNT FROM VW_CLASSHOUR WHERE YEAR = '2019' AND TERM_CD = 'G002C001' UNION
  -- SELECT * FROM VW_CLASSHOUR WHERE YEAR = '2019' AND TERM_CD = 'G002C001'
  SELECT 'V_UNIV_VW_CLASSROOM' AS TBL, COUNT(*) AS CNT FROM VW_CLASSROOM WHERE YEAR = '2019' AND TERM_CD = 'G002C001' UNION
  -- SELECT * FROM VW_CLASSROOM WHERE YEAR = '2019' AND TERM_CD = 'G002C001'
  SELECT 'V_UNIV_VW_COLL' AS TBL, COUNT(*) AS CNT FROM VW_COLL WHERE YEAR = '2019' AND TERM_CD = 'G002C001' UNION
  -- SELECT * FROM VW_COLL WHERE YEAR = '2019' AND TERM_CD = 'G002C001'
  SELECT 'V_UNIV_VW_DEPT' AS TBL, COUNT(*) AS CNT FROM VW_DEPT WHERE YEAR = '2019' AND TERM_CD = 'G002C001' UNION
  -- SELECT * FROM VW_DEPT WHERE YEAR = '2019' AND TERM_CD = 'G002C001'
  */

  SELECT 'V_UNIV_VW_PROF' AS TBL, COUNT(*) AS CNT FROM VW_PROF UNION
  -- SELECT * FROM VW_PROF
  
  SELECT 'V_UNIV_VW_STUDENT' AS TBL, COUNT(*) AS CNT FROM VW_STUDENT UNION
  -- SELECT * FROM VW_STUDENT

  SELECT 'V_UNIV_VW_SUBJECT' AS TBL, COUNT(*) AS CNT FROM VW_SUBJECT  WHERE YEAR = '2019' AND TERM_CD = '1';
  -- SELECT * FROM VW_SUBJECT  WHERE YEAR = '2019' AND TERM_CD = '1'


  ----------------------------------------------------------------
  -- 이전버전 스마트 출결 프로시저 수행
  -- 이전 버전의 경우 동기화 기능이 없는 경우도 존재하여 학교 뷰를 다이렉트로 사용하여
  -- 출결 관련 데이터를 생성하는 경우도 있음
  ----------------------------------------------------------------
  
  -------------------------------------------------------------------------
  -- 학교별 프로시저 수행 (이전 버전)
  -------------------------------------------------------------------------
  
  -- 03. 경동대 
  /* 기준정보 동기화 처리 */
  -- EXECUTE CHUL_SYNC_INITDATA_PROC
  /* 사용자정보 동기화 처리 */
  -- EXECUTE CHUL_SYNC_USER_PROC
  /* 강의정보 동기화 처리 */
  -- EXECUTE CHUL_SYNC_CLASS_PROC
  /* 휴,보강 정보 동기화 처리 */
  -- EXECUTE CHUL_SYNC_HYUBOGANG_PROC

  -----------------------------------------------------------------------------
  -- 4. 생성 데이터 확인 (UNIV_TB.., CHUL_TB..)
  -----------------------------------------------------------------------------

  -- 생성자료(ORACLE/ALTIBASE) 조회 (V_CHUL_VW_...)
  SELECT 'V_CHUL_VW_ATTENDEE' AS TBL, COUNT(*) AS CNT FROM V_CHUL_VW_ATTENDEE WHERE (YEAR, TERM_CD) IN (SELECT YEAR, TERM_CD FROM CHUL_TB_UNIV WHERE UNIV_STS_CD = 'G004C001') UNION
  SELECT 'V_CHUL_VW_CLASS' AS TBL, COUNT(*) AS CNT FROM V_CHUL_VW_CLASS WHERE (YEAR, TERM_CD) IN (SELECT YEAR, TERM_CD FROM CHUL_TB_UNIV WHERE UNIV_STS_CD = 'G004C001') UNION
  SELECT 'V_CHUL_VW_CLASSHOUR' AS TBL, COUNT(*) AS CNT FROM V_CHUL_VW_CLASSHOUR WHERE (YEAR, TERM_CD) IN (SELECT YEAR, TERM_CD FROM CHUL_TB_UNIV WHERE UNIV_STS_CD = 'G004C001') UNION
  SELECT 'V_CHUL_VW_CLASSROOM' AS TBL, COUNT(*) AS CNT FROM V_CHUL_VW_CLASSROOM WHERE (YEAR, TERM_CD) IN (SELECT YEAR, TERM_CD FROM CHUL_TB_UNIV WHERE UNIV_STS_CD = 'G004C001') UNION
  SELECT 'V_CHUL_VW_COLL' AS TBL, COUNT(*) AS CNT FROM V_CHUL_VW_COLL WHERE (YEAR, TERM_CD) IN (SELECT YEAR, TERM_CD FROM CHUL_TB_UNIV WHERE UNIV_STS_CD = 'G004C001') UNION
  SELECT 'V_CHUL_VW_DEPT' AS TBL, COUNT(*) AS CNT FROM V_CHUL_VW_DEPT WHERE (YEAR, TERM_CD) IN (SELECT YEAR, TERM_CD FROM CHUL_TB_UNIV WHERE UNIV_STS_CD = 'G004C001') UNION
  SELECT 'V_CHUL_VW_PROF' AS TBL, COUNT(*) AS CNT FROM V_CHUL_VW_PROF UNION
  SELECT 'V_CHUL_VW_STUDENT' AS TBL, COUNT(*) AS CNT FROM V_CHUL_VW_STUDENT UNION
  SELECT 'V_CHUL_VW_SUBJECT' AS TBL, COUNT(*) AS CNT FROM V_CHUL_VW_SUBJECT WHERE (YEAR, TERM_CD) IN (SELECT YEAR, TERM_CD FROM CHUL_TB_UNIV WHERE UNIV_STS_CD = 'G004C001');
  
  -- 생성자료(ORACLE/ALTIBASE) 조회 (CHUL_TB_...)
  SELECT 'CHUL_TB_CLASSDAY' AS TBL, COUNT(*) AS CNT FROM CHUL_TB_CLASSDAY WHERE (YEAR, TERM_CD) IN (SELECT YEAR, TERM_CD FROM CHUL_TB_UNIV WHERE UNIV_STS_CD = 'G004C001') UNION
  SELECT 'CHUL_TB_ATTENDMASTER_ADDINFO' AS TBL, COUNT(*) AS CNT FROM CHUL_TB_ATTENDMASTER_ADDINFO WHERE (YEAR, TERM_CD) IN (SELECT YEAR, TERM_CD FROM CHUL_TB_UNIV WHERE UNIV_STS_CD = 'G004C001') UNION
  SELECT 'CHUL_TB_ATTENDDETHIST' AS TBL, COUNT(*) AS CNT FROM CHUL_TB_ATTENDDETHIST WHERE (YEAR, TERM_CD) IN (SELECT YEAR, TERM_CD FROM CHUL_TB_UNIV WHERE UNIV_STS_CD = 'G004C001') UNION
  SELECT 'CHUL_TB_ATTEND_APPINFO' AS TBL, COUNT(*) AS CNT FROM CHUL_TB_ATTEND_APPINFO WHERE (YEAR, TERM_CD) IN (SELECT YEAR, TERM_CD FROM CHUL_TB_UNIV WHERE UNIV_STS_CD = 'G004C001') UNION
  SELECT 'CHUL_TB_CLASSOFFMANAGE' AS TBL, COUNT(*) AS CNT FROM CHUL_TB_CLASSOFFMANAGE WHERE (YEAR, TERM_CD) IN (SELECT YEAR, TERM_CD FROM CHUL_TB_UNIV WHERE UNIV_STS_CD = 'G004C001') UNION
  SELECT 'CHUL_TB_CLASSOFF_REQUEST' AS TBL, COUNT(*) AS CNT FROM CHUL_TB_CLASSOFF_REQUEST WHERE (YEAR, TERM_CD) IN (SELECT YEAR, TERM_CD FROM CHUL_TB_UNIV WHERE UNIV_STS_CD = 'G004C001') UNION
  SELECT 'CHUL_TB_CLASSROOM_RESERVE' AS TBL, COUNT(*) AS CNT FROM CHUL_TB_CLASSROOM_RESERVE WHERE (YEAR, TERM_CD) IN (SELECT YEAR, TERM_CD FROM CHUL_TB_UNIV WHERE UNIV_STS_CD = 'G004C001') UNION
  SELECT 'CHUL_TB_GONGGYUL' AS TBL, COUNT(*) AS CNT FROM CHUL_TB_GONGGYUL WHERE (YEAR, TERM_CD) IN (SELECT YEAR, TERM_CD FROM CHUL_TB_UNIV WHERE UNIV_STS_CD = 'G004C001') UNION
  SELECT 'CHUL_TB_IMPROVE' AS TBL, COUNT(*) AS CNT FROM CHUL_TB_IMPROVE WHERE (YEAR, TERM_CD) IN (SELECT YEAR, TERM_CD FROM CHUL_TB_UNIV WHERE UNIV_STS_CD = 'G004C001') UNION
  SELECT 'CHUL_TB_USERINFO' AS TBL, COUNT(*) AS CNT FROM CHUL_TB_USERINFO;
  
  -----------------------------------------------------------------------------
  --       4.1 기타 동기화 작업 (학교별 기능에 따른 동기화 작업)
  --           학교측에서 자료를 view 형태로 제공해주면 자동동기화 처리
  --           그렇지 않으면 수동 동기화 처리 (처음 제공된 자료가 불변하면 자동동기화 처리 가능)
  -----------------------------------------------------------------------------
  
  -- 03. 경동대
  -- 기타 동기화 없음
  
  -----------------------------------------------------------------------------
  -- 5. 교수정보 마감해제 (새학기 등록 시)
  -----------------------------------------------------------------------------
  
  -- 이전학기 강의정보 마감처리
  -- UPDATE CHUL_TB_ATTENDMASTER_ADDINFO
     SET CLASS_ADM_CD = 'G027C002'
  -- SELECT * FROM CHUL_TB_ATTENDMASTER_ADDINFO
   WHERE YEAR = '2019'
     AND TERM_CD = 'G002C001'
     AND CLASS_ADM_CD = 'G027C001'
     ;
     
  -- 교수정보 마감
  -- UPDATE CHUL_TB_USERINFO 
     SET ADM_CD = 'G026C002' 
  -- SELECT * FROM CHUL_TB_USERINFO
   WHERE ADM_CD = 'G026C001'
     AND AUTHORITY = 'ROLE_PROF'
     ;

  -- 교수정보 마감 해제
  -- UPDATE CHUL_TB_USERINFO 
     SET ADM_CD = 'G026C001' 
  -- SELECT * FROM CHUL_TB_USERINFO
   WHERE ADM_CD = 'G026C002'
     AND AUTHORITY = 'ROLE_PROF'
     ;

  -----------------------------------------------------------------------------
  -- 6. 기타 체크(주말(토/일) 강의 체크)
  -----------------------------------------------------------------------------
  
  -- 주말(토/일) 강의 체크	
  SELECT *	
  	FROM V_CHUL_VW_CLASS	
   WHERE YEAR = '2019'
	   AND TERM_CD = 'G002C001'
	   AND CLASSDAY_NAME IN ('토', '일')
	 ;
  
  -- 주말(토/일) 강의 갯수 확인
  SELECT CLASS_CD
       , COUNT(*)
    FROM CHUL_TB_ATTENDMASTER_ADDINFO
   WHERE YEAR = '2019'
     AND TERM_CD = 'G002C001'
     AND CLASSDAY_NAME IN ('토', '일')
   GROUP BY CLASS_CD
   ;

  -----------------------------------------------------------------------------
  -- 7. 이상 강의 체크 
  --   - 집중강의를 제외하고 일반적으로 강의생성 시 강의수는 15개
  --     15개가 아닌 강의는 주차 및 보강일자에 따라 강의가 잘못 생성된 것일 수 있음
  --     * 차의과대는 보강주가 따로 없고 강의가 16개 생성됨
  -----------------------------------------------------------------------------

  SELECT UNIV_CD
       , YEAR
	     , TERM_CD
	     , SUBJECT_CD
	     , SUBJECT_DIV_CD
	     , CLASS_CD
	     , PROF_NO
	     , COUNT(*) CNT
  -- SELECT  *
    FROM CHUL_TB_ATTENDMASTER_ADDINFO
   WHERE YEAR = '2019'
     AND TERM_CD = 'G002C001'
	   AND CLASS_TYPE_CD IN ('G019C001', 'G019C003')
   GROUP BY UNIV_CD
       , YEAR
	     , TERM_CD
	     , SUBJECT_CD
	     , SUBJECT_DIV_CD
	     , CLASS_CD
	     , PROF_NO
  HAVING COUNT(*) != 15
	   ;
