  
  -----------------------------------------------------------------------------
  --
  -- * �� ������ ����Ʈ ��� ������Ʈ�� src/main/etc ������ �����ϸ�
  --   ���빮�� �� �б��� �б� �������� ���� �� ������ ������ ���� svn�� �ݿ��ؾ���(�ֽ�ȭ)
  --   (���� sql������ ���� ���� �� ��Ŭ���� workspace������ �ٷ� ����ϱ⸦ ����
  -- 
  -- 00. ����Ʈ ��� �б����� ���� ����
  --    - �б����� ������ ���ؼ��� �б����� �л�� ���� ������ Ȯ���ؾ���
  --      �Ϲ����� ��û ����(�ű��б����� �б���û ����)�� NAS ����
  --      (NAS : 00.�������� > ������ > 00. �ű� �б� ���� ����
  --
  --    - �б��� �л�� ������ ���� NAS�� ������ �б��ڷ�ó�� ������ �����Ͽ�
  --      1��, 3�� ��Ʈ�� ������ �����Ͽ� ��� (3����Ʈ�� �б���� ���� ����)
  --
  -- 01. �� �б� ���� ����
  --
  --    1. �б����� ��� (������ ���� ���� �б� ���� ó�� �� �� �б� ����)
  --
  --    2. CHUL_TB_CLASSDAY ���� (���ڻ���)
  --
  --    3. ����ȭ������ �����Ͽ� ���󿡼� ����ȭ ó�� (���ν��� ����)
  --       
  --	   * ����DB�� ���� �б������� ������ VIEW�� ���� �����͸� Ȯ���ϰ� ����ȭ ó��
  --         �̱���DB�� ���� ������DB(�б�)�� VIEW �����͸� Ȯ�� �� ����ȭ ó��
  --       * �� Ư���� ���� �б����� ��ȸ ����� �ٸ� �� �ְ� ���� ������ �ٸ��� ����
  --
  --       * �б����� �� �б� �����͸� �������� �� (VW..)
  --        1) �⺻�б�URL/comm/log_list ���� �� > '����ȭ' ������ Ŭ��
  --        2) �����ڷᵿ��ȭ > ��ü ����
  --        3) ����ڷᵿ��ȭ > ��ü ����
  --        % ���� ��������ȭ ����� ����Ŭ > MSSQL�� �̰��ϴ� �̱��� DB�� ���� �ϰ�
  --          �� ����DB�� �ƴ� ���� ��ü�� ���� ����
  --
  --       �޴� ����
  --       '�����ڷ� ����ȭ' : �б����� > ����ȭ ���̺� ������ �̰� (UNIV_TB..)
  --       '����ڷ� ����ȭ' : ����ȭ ���̺� > �� ������̺� (CHUL_TB..)
  --       '��Ÿ ����ȭ' : ��Ÿ �б����� Ư���� ���� ������ ����ȭ (�����̰�.. ���)
  --       
  --       * �⺻������ ����ȭ �۾��� �б������� CHUL_TB_CLASSDAY�� �����Ͱ� �����Ǹ�
  --         ������ �ڵ����� ����ȭ ó���� ������ �������� ������ �����ÿ��� �ش� ��������
  --         �����Ͽ� �������� ó�� ����
  --         '�����ڷ� ����ȭ' �κ��� ����ȭ ó�� �Ͽ��� ������ ������ '����ڷ� ����ȭ'�� ����
  --         ���� ���ǰ� �ִ� �����͸� ���� �ϴ� ���̹Ƿ� ���ǰ� �ʿ�
  --         (�� �б� �������̳� ��뷮�� ���� ��츸 ��� '����ڷ� ����ȭ' ���� �ʿ�!!)
  --
  --    4. ���� ������ Ȯ�� (UNIV_TB.., CHUL_TB..)
  --       4.1 ��Ÿ ����ȭ �۾� (�б��� ��ɿ� ���� ����ȭ �۾�)
  --           �б������� �ڷḦ view ���·� �������ָ� �ڵ�����ȭ ó��
  --           �׷��� ������ ���� ����ȭ ó�� (ó�� ������ �ڷᰡ �Һ��ϸ� �ڵ�����ȭ ó�� ����)
  --
  --    5. �������� �������� (���б� ��� ��)
  --
  --    6. ��Ÿ üũ(�ָ�(��/��) ���� üũ)
  --      - �ָ����ǰ� ������ ��� '�б⸶����', '����������'�� �ָ��� ����Ǿ���
  --        �ϰ�����ȭ �б��� ���� ���� �ش������ ������ ������α׷��� ���� ����ȭ
  --        �ϴ� ���� ������ ���� ���Ǹ� �����ϱ� ������ �ָ��� ������ �ȵǾ� ������
  --        �ָ����ǵ��� 15������ ���ǰ� �������� ���� �� ����
  --    
  --    7. �̻� ���� üũ 
  --      - ���߰��Ǹ� �����ϰ� �Ϲ������� ���ǻ��� �� ���Ǽ��� 15��
  --        15���� �ƴ� ���Ǵ� ���� �� �������ڿ� ���� ���ǰ� �߸� ������ ���� �� ����
  --        * ���ǰ���� �����ְ� ���� ���� ���ǰ� 16�� ������
  -----------------------------------------------------------------------------
  
  -- ##########################################################################
  -----------------------------------------------------------------------------
  -- * �߰� ���� (����Ʈ ��� ���� ����)
  --
  -- !!!!! ����Ʈ��� ���� ������ ��� ����ȭ ó���� ���� �ʴ� ��찡 ����
  -- �ֽ� ������ ��� �б��� > UNIV_TB�� ����ȭ ó���� �ش� ���̺��� ��� ����ϴµ�
  -- ���������� ��� �б� �並 ���̷�Ʈ�� ����ϴ� ��찡 ��ټ���
  -- ���� ����ȭ ������ ������ CHUL_TB �����͸� �б� �並 ���� �ٷ� ����
  -- ���� ��Ī�� V_UNIV_VW�� ������� �ʰ� VW_�� ���
  -- 
  -- !!!!! ����ڷ� ������ ���� ���ν��� ȣ�� ����� �б����� ���� �� �� ����
  -- �������� ����Ʈ ��� ���ν��� ����
  -- ���� ������ ��� ����ȭ ����� ���� ��쵵 �����Ͽ� �б� �並 ���̷�Ʈ�� ����Ͽ�
  -- ��� ���� �����͸� �����ϴ� ��쵵 ����
  --
  -----------------------------------------------------------------------------  
  -- ##########################################################################
  
  -----------------------------------------------------------------------------
  -- 1. �б����� ���
  -----------------------------------------------------------------------------
  
	-- �б����� ��ȸ����	
	SELECT * 
    FROM CHUL_TB_UNIV	
	 ORDER BY YEAR DESC
          , TERM_START_DATE DESC
          ;	

	-- �б� �ڵ� ���� ��ȸ	
	SELECT * 
    FROM CHUL_TB_CODEMASTER	
	 WHERE CODE_GRP_CD = 'G002'	
	 ORDER BY CODE	
	 ;

  -- �����б� ���� ó��
  -- UPDATE CHUL_TB_UNIV
     SET UNIV_STS_CD = 'G004C002'
     ;
COMMIT;

  -- �ű��б� �߰�
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
								  , '�浿���б�'
								  , '2019�� 1�б�'
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
  -- 2. CHUL_TB_CLASSDAY ���� (���ڻ���)
  -----------------------------------------------------------------------------
  
  -- ���ν��� ���� (���� Ȱ��ȭ �б�� �б�Ⱓ�� CLASSDAY�� �����Ѵ�)
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
  -- 3. ����ȭ������ �����Ͽ� ���󿡼� ����ȭ ó�� (���ν��� ����)
  -----------------------------------------------------------------------------
  
  -- �б��� ������ Ȯ�� (������ �б��� ������ �־�� ����ȭ�� ������)
  --
  -- * �̱��� DB�̹Ƿ� ORACLE���� �����͸� Ȯ���ؾ���
  -- * �� Ư���� ���� �б����� ��ȸ ����� �ٸ� �� �ְ� ���� ������ �ٸ��� ����
  
  -- #################################################################################
  -- !!!!! ����Ʈ��� ���� ������ ��� ����ȭ ó���� ���� �ʴ� ��찡 ����
  -- �ֽ� ������ ��� �б��� > UNIV_TB�� ����ȭ ó���� �ش� ���̺��� ��� ����ϴµ�
  -- ���������� ��� �б� �並 ���̷�Ʈ�� ����ϴ� ��찡 ��ټ���
  -- ���� ����ȭ ������ ������ CHUL_TB �����͸� �б� �並 ���� �ٷ� ����
  -- ���� ��Ī�� V_UNIV_VW�� ������� �ʰ� VW_�� ���
  -- #################################################################################
  
  -----------------------------------------------------------------------------------------------------------------
  -- �ʼ��� (MSSQL OR ORACLE/ALTIBASE) ������ ��ȸ (...)

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
  -- �������� ����Ʈ ��� ���ν��� ����
  -- ���� ������ ��� ����ȭ ����� ���� ��쵵 �����Ͽ� �б� �並 ���̷�Ʈ�� ����Ͽ�
  -- ��� ���� �����͸� �����ϴ� ��쵵 ����
  ----------------------------------------------------------------
  
  -------------------------------------------------------------------------
  -- �б��� ���ν��� ���� (���� ����)
  -------------------------------------------------------------------------
  
  -- 03. �浿�� 
  /* �������� ����ȭ ó�� */
  -- EXECUTE CHUL_SYNC_INITDATA_PROC
  /* ��������� ����ȭ ó�� */
  -- EXECUTE CHUL_SYNC_USER_PROC
  /* �������� ����ȭ ó�� */
  -- EXECUTE CHUL_SYNC_CLASS_PROC
  /* ��,���� ���� ����ȭ ó�� */
  -- EXECUTE CHUL_SYNC_HYUBOGANG_PROC

  -----------------------------------------------------------------------------
  -- 4. ���� ������ Ȯ�� (UNIV_TB.., CHUL_TB..)
  -----------------------------------------------------------------------------

  -- �����ڷ�(ORACLE/ALTIBASE) ��ȸ (V_CHUL_VW_...)
  SELECT 'V_CHUL_VW_ATTENDEE' AS TBL, COUNT(*) AS CNT FROM V_CHUL_VW_ATTENDEE WHERE (YEAR, TERM_CD) IN (SELECT YEAR, TERM_CD FROM CHUL_TB_UNIV WHERE UNIV_STS_CD = 'G004C001') UNION
  SELECT 'V_CHUL_VW_CLASS' AS TBL, COUNT(*) AS CNT FROM V_CHUL_VW_CLASS WHERE (YEAR, TERM_CD) IN (SELECT YEAR, TERM_CD FROM CHUL_TB_UNIV WHERE UNIV_STS_CD = 'G004C001') UNION
  SELECT 'V_CHUL_VW_CLASSHOUR' AS TBL, COUNT(*) AS CNT FROM V_CHUL_VW_CLASSHOUR WHERE (YEAR, TERM_CD) IN (SELECT YEAR, TERM_CD FROM CHUL_TB_UNIV WHERE UNIV_STS_CD = 'G004C001') UNION
  SELECT 'V_CHUL_VW_CLASSROOM' AS TBL, COUNT(*) AS CNT FROM V_CHUL_VW_CLASSROOM WHERE (YEAR, TERM_CD) IN (SELECT YEAR, TERM_CD FROM CHUL_TB_UNIV WHERE UNIV_STS_CD = 'G004C001') UNION
  SELECT 'V_CHUL_VW_COLL' AS TBL, COUNT(*) AS CNT FROM V_CHUL_VW_COLL WHERE (YEAR, TERM_CD) IN (SELECT YEAR, TERM_CD FROM CHUL_TB_UNIV WHERE UNIV_STS_CD = 'G004C001') UNION
  SELECT 'V_CHUL_VW_DEPT' AS TBL, COUNT(*) AS CNT FROM V_CHUL_VW_DEPT WHERE (YEAR, TERM_CD) IN (SELECT YEAR, TERM_CD FROM CHUL_TB_UNIV WHERE UNIV_STS_CD = 'G004C001') UNION
  SELECT 'V_CHUL_VW_PROF' AS TBL, COUNT(*) AS CNT FROM V_CHUL_VW_PROF UNION
  SELECT 'V_CHUL_VW_STUDENT' AS TBL, COUNT(*) AS CNT FROM V_CHUL_VW_STUDENT UNION
  SELECT 'V_CHUL_VW_SUBJECT' AS TBL, COUNT(*) AS CNT FROM V_CHUL_VW_SUBJECT WHERE (YEAR, TERM_CD) IN (SELECT YEAR, TERM_CD FROM CHUL_TB_UNIV WHERE UNIV_STS_CD = 'G004C001');
  
  -- �����ڷ�(ORACLE/ALTIBASE) ��ȸ (CHUL_TB_...)
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
  --       4.1 ��Ÿ ����ȭ �۾� (�б��� ��ɿ� ���� ����ȭ �۾�)
  --           �б������� �ڷḦ view ���·� �������ָ� �ڵ�����ȭ ó��
  --           �׷��� ������ ���� ����ȭ ó�� (ó�� ������ �ڷᰡ �Һ��ϸ� �ڵ�����ȭ ó�� ����)
  -----------------------------------------------------------------------------
  
  -- 03. �浿��
  -- ��Ÿ ����ȭ ����
  
  -----------------------------------------------------------------------------
  -- 5. �������� �������� (���б� ��� ��)
  -----------------------------------------------------------------------------
  
  -- �����б� �������� ����ó��
  -- UPDATE CHUL_TB_ATTENDMASTER_ADDINFO
     SET CLASS_ADM_CD = 'G027C002'
  -- SELECT * FROM CHUL_TB_ATTENDMASTER_ADDINFO
   WHERE YEAR = '2019'
     AND TERM_CD = 'G002C001'
     AND CLASS_ADM_CD = 'G027C001'
     ;
     
  -- �������� ����
  -- UPDATE CHUL_TB_USERINFO 
     SET ADM_CD = 'G026C002' 
  -- SELECT * FROM CHUL_TB_USERINFO
   WHERE ADM_CD = 'G026C001'
     AND AUTHORITY = 'ROLE_PROF'
     ;

  -- �������� ���� ����
  -- UPDATE CHUL_TB_USERINFO 
     SET ADM_CD = 'G026C001' 
  -- SELECT * FROM CHUL_TB_USERINFO
   WHERE ADM_CD = 'G026C002'
     AND AUTHORITY = 'ROLE_PROF'
     ;

  -----------------------------------------------------------------------------
  -- 6. ��Ÿ üũ(�ָ�(��/��) ���� üũ)
  -----------------------------------------------------------------------------
  
  -- �ָ�(��/��) ���� üũ	
  SELECT *	
  	FROM V_CHUL_VW_CLASS	
   WHERE YEAR = '2019'
	   AND TERM_CD = 'G002C001'
	   AND CLASSDAY_NAME IN ('��', '��')
	 ;
  
  -- �ָ�(��/��) ���� ���� Ȯ��
  SELECT CLASS_CD
       , COUNT(*)
    FROM CHUL_TB_ATTENDMASTER_ADDINFO
   WHERE YEAR = '2019'
     AND TERM_CD = 'G002C001'
     AND CLASSDAY_NAME IN ('��', '��')
   GROUP BY CLASS_CD
   ;

  -----------------------------------------------------------------------------
  -- 7. �̻� ���� üũ 
  --   - ���߰��Ǹ� �����ϰ� �Ϲ������� ���ǻ��� �� ���Ǽ��� 15��
  --     15���� �ƴ� ���Ǵ� ���� �� �������ڿ� ���� ���ǰ� �߸� ������ ���� �� ����
  --     * ���ǰ���� �����ְ� ���� ���� ���ǰ� 16�� ������
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
