SET SERVEROUTPUT ON;

BEGIN
  FOR t IN (
    SELECT table_name 
    FROM user_tables 
    WHERE table_name LIKE 'H\_%' ESCAPE '\'
  ) LOOP
    DECLARE
      v_count NUMBER;
      v_sql   VARCHAR2(1000);
    BEGIN
      v_sql := 'SELECT COUNT(*) FROM ' || t.table_name;
      EXECUTE IMMEDIATE v_sql INTO v_count;

      IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('PUSTA TABELA: ' || t.table_name);
      END IF;
    END;
  END LOOP;
END;
/
