-- FUNCION
USE `parqueadero`;
DROP function IF EXISTS `F_CALCULAR_VALOR`;

DELIMITER $$
USE `parqueadero`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `F_CALCULAR_VALOR`(
P_ID_TICKET INT) 
RETURNS FLOAT
DETERMINISTIC
BEGIN
	DECLARE HORA_INGRESO TIMESTAMP;
	DECLARE MINUTOS INT;
    DECLARE VALOR_TOTAL FLOAT;
    
    SELECT HORA_ING INTO HORA_INGRESO FROM TICKETS
    WHERE ID_TICKET = P_ID_TICKET;
    
    SET MINUTOS = TIMESTAMPDIFF(MINUTE, HORA_INGRESO, NOW());
    SET VALOR_TOTAL = MINUTOS * 2; -- dos dolares pro minuto
RETURN VALOR_TOTAL;
END$$

DELIMITER ;
;



-- PROCEDIMIENTO ALM
USE `parqueadero`;
DROP procedure IF EXISTS `P_FACTURA`;

DELIMITER $$
USE `parqueadero`$$
CREATE PROCEDURE `P_FACTURA` (
IN P_ID_TICKET INT,
IN P_ID_VEHICULO INT,
IN P_ID_ESTACIONAMIENTO INT)
BEGIN
	DECLARE VALOR_REAL FLOAT;
	SET VALOR_REAL = F_CALCULAR_VALOR(P_ID_TICKET);
    
	INSERT INTO FACTURAS (VALOR_PAGADO, ID_VEHICULO, ID_TICKET)
    VALUES (VALOR_REAL, P_ID_VEHICULO, P_ID_TICKET);
    
    UPDATE ESTACIONAMIENTOS SET ID_ESTADO = 0
    WHERE ID_ESTACIONAMIENTO = P_ID_ESTACIONAMIENTO;
END$$

DELIMITER ;



-- TRIGGER
DROP TRIGGER IF EXISTS `T_VALIDAR_PAGO`;
DELIMITER $$
CREATE TRIGGER T_VALIDAR_PAGO
BEFORE INSERT ON FACTURAS
FOR EACH ROW
BEGIN
    DECLARE T_VALOR_REAL FLOAT;
    SET T_VALOR_REAL = F_CALCULAR_VALOR(NEW.ID_TICKET);

    IF NEW.VALOR_PAGADO < T_VALOR_REAL THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Pago insuficiente.';
    END IF;
END $$

DELIMITER ;



