library ieee;
use ieee.std_logic_1164.all;

-- Entidad principal: sensor ultrasónico y control de motor
entity sensor is
    port (
        clk, rst, echo, reset, take: in std_logic;  -- Entradas: reloj principal, reset general, señal echo del sensor, reset de motor, señal de toma/captura
        trig, pwm_motor: out std_logic;             -- Salidas: señal trigger para el sensor ultrasónico, señal PWM para controlar el motor
        ss0, ss1, ss2, ss3: out std_logic_vector(6 downto 0)  -- Salidas a displays de 7 segmentos
    );
end entity;

architecture arqsns of sensor is
    -- Señales internas
    signal clkl, clkl1, clkl2, tr, inc, dec: std_logic;            -- Señales auxiliares de reloj y control
    signal salida0, salida1, salida2, salida3, duty_motor, sal: integer; -- Salidas numéricas intermedias
    constant duty_sensor: integer := 500;                          -- Ciclo de trabajo del sensor ultrasónico
    constant limite_sensor: integer := 25000000;                   -- Límite del sensor ultrasónico (frecuencia)
    constant limite_motor: integer := 1000;                        -- Límite del PWM para el motor
    signal dis: integer;                                           -- Tiempo medido del pulso "echo"
    signal valor_distancia: integer;                               -- Distancia calculada a partir del pulso "echo"
begin

    -- División de reloj para generar reloj lento para mediciones ultrasónicas
    u1: entity work.divf(arqdivf) 
        generic map(25) 
        port map(clk, clkl1);

    -- Generador de señal para el módulo trigger
    u2: entity work.senal(arqsenal) 
        port map(clk, duty_sensor, limite_sensor, clkl2);

    -- Generación del pulso trigger para activar el sensor ultrasónico
    u3: entity work.trigger(arqtrigger) 
        port map(clkl2, rst, echo, tr);
  
    -- Asignación de la señal trigger a la salida
    trig <= tr;
   
    -- Contador que mide la duración del pulso echo, almacenando el valor en 'dis' y extrayendo unidades y decenas
    u4: entity work.contador(arqcontador) 
        port map(echo, clkl1, tr, salida0, salida1, dis);

    -- Conversión de salida0 y salida1 a formato de 7 segmentos
    u5: entity work.dec7seg(arqdec) 
        port map(salida0, ss0);
    
    u6: entity work.dec7seg(arqdec) 
        port map(salida1, ss1);

    -- Conversión de duración del eco a valor de distancia (en cm u otra unidad)
    x1: entity work.distancia(arqdis) 
        port map(clkl1, dis, valor_distancia);

    -- División de reloj adicional para controlar el motor
    u7: entity work.divf(arqdivf) 
        generic map(500) 
        port map(clk, clkl);

    -- Lógica de control del motor basada en la distancia
    -- También captura los valores a mostrar en los displays (ss2 y ss3) cuando se activa 'take'
    u8: entity work.movimiento(arqmov)
        port map(clkl, reset, take, valor_distancia, salida2, salida3, duty_motor, salida2, salida3);

    -- Generación de la señal PWM para el motor
    u9: entity work.senal(arqsenal) 
        port map(clkl, duty_motor, limite_motor, pwm_motor);

    -- Conversión de los valores capturados (decenas y unidades del PWM) a display de 7 segmentos
    u10: entity work.dec7seg(arqdec) 
        port map(salida2, ss2);
    
    u11: entity work.dec7seg(arqdec) 
        port map(salida3, ss3);

end architecture;
