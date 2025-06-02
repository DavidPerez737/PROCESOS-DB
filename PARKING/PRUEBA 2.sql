-- PROCESO 2

CALL P_FACTURA (1,1,3); -- como la hora de salida la declaramos como now() el valor pagado sale en 0 toca esperar 1 min para que cobre minimo 2 dolares
SELECT * FROM FACTURAS; 
SELECT * FROM ESTACIONAMIENTOS;