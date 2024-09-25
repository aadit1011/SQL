-- Using $$ as Delimiter
DELIMITER $$  
CREATE TRIGGER first_trigger BEFORE INSERT ON employee
    FOR EACH ROW
BEGIN
    INSERT INTO first_trigger VALUES ('Added employee'); -- Semicolon here does not end the trigger
END$$                -- This $$ ends the trigger creation
DELIMITER ;           -- Reset delimiter back to the default semicolon


-- Using @ as Delimiter
-- OR
DELIMITER @  

CREATE TRIGGER second_trigger BEFORE INSERT ON employee
    FOR EACH ROW
BEGIN
    INSERT INTO trigger_log VALUES ('Employee added');
END@

DELIMITER ;
