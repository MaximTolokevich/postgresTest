\set ON_ERROR_STOP off

-- Временная таблица для сбора логов
DROP TABLE IF EXISTS test_results;
CREATE TEMP TABLE test_results(line text);

DO $$
DECLARE
failures integer := 0;
    actual_count integer;
    calc_result integer;
BEGIN
    -- ТЕСТ 1: Проверка количества записей
BEGIN
SELECT count(*) INTO actual_count FROM operations;
IF actual_count = 3 THEN
            INSERT INTO test_results(line) VALUES ('TEST: Row count check: PASS - 3/3');
ELSE
            failures := failures + 1;
INSERT INTO test_results(line) VALUES ('TEST: Row count check: FAIL - expected=3 got=' || actual_count);
END IF;
EXCEPTION WHEN undefined_table THEN
        failures := failures + 1;
INSERT INTO test_results(line) VALUES ('TEST: Row count check: FAIL - table operations does not exist');
END;

    -- ТЕСТ 2: Проверка логики сложения (add)
SELECT result INTO calc_result FROM operations WHERE name = 'add';
IF calc_result = 15 THEN
        INSERT INTO test_results(line) VALUES ('TEST: Addition logic: PASS');
ELSE
        failures := failures + 1;
INSERT INTO test_results(line) VALUES ('TEST: Addition logic: FAIL - expected=15 got=' || calc_result);
END IF;

    -- ТЕСТ 3: Намеренный провал (как в примере ментора)
    failures := failures + 1;
INSERT INTO test_results(line) VALUES ('TEST: Forced failure: FAIL - intentional failing test for sandbox');

-- ИТОГОВЫЙ СТАТУС (RESULT и ERROR)
IF failures = 0 THEN
        INSERT INTO test_results(line) VALUES ('RESULT: PASS');
ELSE
        INSERT INTO test_results(line) VALUES ('RESULT: FAIL - failures=' || failures);
INSERT INTO test_results(line) VALUES ('ERROR: Tests failed. failures=' || failures);
END IF;
END $$;

SELECT line FROM test_results;
